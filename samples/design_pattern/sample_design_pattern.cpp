#include <iostream>
#include "DesignPattern/Singleton.h"

class SampleSingleton : public Singleton<SampleSingleton> {
public:
    SampleSingleton() = default;
    ~SampleSingleton() = default;
};

int main(int argc, char** argv) {
    SampleSingleton* s1 = SampleSingleton::GetInstance();
    SampleSingleton* s2 = SampleSingleton::GetInstance();
    std::cout << "s1 = " << s1 << std::endl <<
        "s2 = " << s2 << std::endl;
    return 0;
}