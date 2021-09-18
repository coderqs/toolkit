#include <iostram>
#include "version.h"

void show_version(void) {
    printf(\
        "%s version %s\n" \
        "build time: %s%s%s%s-%s%s-%s%s %s\n" ,\
        PROGRAM_NAME, PROGRAM_VERSION,
        BUILD_YEAR_CH0, BUILD_YEAR_CH1, BUILD_YEAR_CH2, BUILD_YEAR_CH3,\
        BUILD_MONTH_CH0, BUILD_MONTH_CH1, BUILD_DAY_CH0, BUILD_DAY_CH1,\
       __TIME__
    )
}

int main(int argc, char** argv) {
    if (argc == 2) {
        char* flag = argv[1];
        if (!strcmp(flag, "-v") || !strcmp(flag, "--version") || !strcmp(flag, "version"))
            show_version();
        else
            printf("Invalid parameter.\n");
            
    }
    else {
        printf("Too many parameters!\n");
    }
}