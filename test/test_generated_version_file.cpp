#include <iostream>

#include "version.h"

void ShowVersionInfo(void) {
    std::cout << REPOSITORY << std::endl;
    std::cout << "0.1.0." << REVISION_NUM << std::endl;
    std::cout << BUILD_TIME_STR1 << std::endl;
    std::cout << BUILD_TIME_STR2 << std::endl;
    std::cout << BUILD_TIME_STR3 << std::endl;
}

int main(int argc, char** argv) {
    ShowVersionInfo();

    return 0;
}