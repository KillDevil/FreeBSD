#!/bin/bash -e
#CentOS
#yum install ncurses-devel
#yum install python-devel
#yum install lua-devel
apt-get install libncurses5-dev
apt-get install python-dev
apt-get install liblua5.1-0-dev

make distclean
./configure \
  --disable-gui --enable-fontset --disable-xsmp \
  --enable-pythoninterp --enable-rubyinterp=dynamic --enable-pythoninterp \
  --enable-luainterp=dynamic --enable-perlinterp=dynamic \
  --enable-cscope --enable-multibyte --with-features=huge \
  --with-compiledby=闫峰 --with-modified-by=闫峰

make -j2
sudo make install
