#include <stdio.h>

#include "hello.h"
#include "world.h"

int main() {
    printf("%s, %s!\n", get_hello(), get_world());
    return 0;
}
