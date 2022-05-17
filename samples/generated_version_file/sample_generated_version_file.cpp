#include <iostream>

#include "version.h"

//void ShowVersionInfo(void) {
//    std::cout << REPOSITORY << std::endl;
//    std::cout << "0.1.0." << REVISION_NUM << std::endl;
//    std::cout << "build time: " <<
//        BUILD_YEAR_CH0 << BUILD_YEAR_CH1 <<
//        BUILD_YEAR_CH2 << BUILD_YEAR_CH3 <<
//        '-' << BUILD_MONTH_CH0 << BUILD_MONTH_CH1 <<
//        '-' << BUILD_DAY_CH0 << BUILD_DAY_CH1 <<
//        ' ' << __TIME__<< std::endl;
//    //std::cout << BUILD_TIME_STR2 << std::endl;
//    //std::cout << BUILD_TIME_STR3 << std::endl;
//}

int main(int argc, char** argv) {
    ShowVersionInfo();

    return 0;
}