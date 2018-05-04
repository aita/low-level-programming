#include <stdio.h>

extern double func(double f[]);

int main() {
    int i;
    double f;
    double a[] = {3, 4};

    f = func(&a[0]);
    printf("f = %f\n", f);

    for (i = 0; i < sizeof(a)/sizeof(double); i++) {
        printf("a[%d] = %f\n", i, a[i]);
    }

    return 0;
}
