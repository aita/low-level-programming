#include <stdio.h>

void print(int i) {
    printf("%d\n", i);
}


int main() {
    int i;


    for (i = 0; i < 10; i++) {
        print(i);
    }

    return 0;
}
