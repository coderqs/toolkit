#include <iostream>
<<<<<<< Updated upstream
#include "sample_dp_sigleton.h"
#include "sample_dp_factory.h"

int main(int argc, char** argv) {
    // sample singleton
    //SampleSingleton* s1 = SampleSingleton::GetInstance();
    //SampleSingleton* s2 = SampleSingleton::GetInstance();
    //std::cout << "s1 = " << s1 << std::endl <<
    //    "s2 = " << s2 << std::endl;

    // abstract factory 
    Factory factory;
    ProductA* product_a = (ProductA*)factory.Create("ProductA");
    ProductB* product_b = (ProductB*)factory.Create("ProductB");

=======
#include "DesignPattern/Singleton.h"
#include "sample_dp_facade.h"

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

    std::cout << "--------------------------------" << std::endl;
    SemiworkFacade semiwork;
    semiwork.WrapOperation();
>>>>>>> Stashed changes
    return 0;
}