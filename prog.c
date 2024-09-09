#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <sys/stat.h>
#include "./header/math_parameters.h"

int main(int argc, char *argv[]) {
    char filename[100];
    sprintf(filename, "%s/param_info.txt", argv[1]);

    FILE *file = fopen(filename, "w");

    fprintf(file, "PARAM value: %.2f\n", PARAM);
    fprintf(file, "B value: %.2f\n", B);
    fclose(file);

    return 0;
}
