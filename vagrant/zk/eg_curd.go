package main

import (
	//"fmt"
	"github.com/samuel/go-zookeeper/zk"
	"log"
	"os"
	"strings"
	"time"
)

func must(err error) {
	if err != nil {
		panic(err)
	}
}

func connect() *zk.Conn {
	zksStr := os.Getenv("ZOOKEEPER_SERVERS")
	zks := strings.Split(zksStr, ",")
	conn, _, err := zk.Connect(zks, time.Second)
	must(err)
	return conn
}

func main() {
	const root = "/Service"
	const cdir = "/Service/Quantity"

	conn := connect()
	defer conn.Close()

	// 删除已经存在的条目
	exists, stat, err := conn.Exists(root)
	must(err)
	if exists {
		// 先删除子节点
		children, _, err := conn.Children(root)
		must(err)
		for _, name := range children {
			cdir := strings.Join([]string{root, name}, "/")
			exists, _, err := conn.Exists(cdir)
			if exists {
				err = conn.Delete(cdir, -1)
				must(err)
				log.Printf("delete %s ok\n", cdir)
			} else {
				log.Printf("%s doesn't exist.", cdir)
			}
		}

		// 删除节点
		err = conn.Delete(root, -1)
		must(err)
		log.Printf("delete %s ok\n", root)
	} else {
		log.Printf("%s doesn't exist.\n", root)
	}

	flags := int32(0)
	acl := zk.WorldACL(zk.PermAll)

	path, err := conn.Create(root, []byte("小苹果"), flags, acl)
	must(err)
	log.Printf("create %v ok\n", path)

	data, stat, err := conn.Get(root)
	must(err)
	log.Printf("%v, NumChildren: %v\n", string(data), stat.NumChildren)

	path, err = conn.Create(cdir, []byte{100}, flags, acl)
	must(err)
	log.Printf("create %v ok\n", path)

	data, stat, err = conn.Get(cdir)
	must(err)
	log.Printf("小苹果的数量: %v\n", data[0])
}
