#include <stdio.h>

struct str {
    int len;
    char s[0];
};

struct foo {
    struct str *a;
};



int main()
{
/*    std::shared_ptr<A> pa;
    bool a = pa;
    bool b = pa.operator bool();

    if (pa) {
        std::cout << "hello\n";
    } else {
        std::cout << "world\n";
    }*/
    struct foo f = {0};
    printf("%08x\n", f.a);
    if (f.a->s) {
        printf(f.a->s);
    }
}

