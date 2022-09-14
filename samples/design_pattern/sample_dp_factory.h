#ifndef TOOLKIT__SAMPLES__DESIGN_PATTERN__SAMPLE_DP_FACTORY_H
#define TOOLKIT__SAMPLES__DESIGN_PATTERN__SAMPLE_DP_FACTORY_H

#include <iostream>

#include "toolkit/design_pattern/factory.h"

class ProductA : public AbstractProduct {
public:
    ProductA() {
        std::cout << "Constructor ProductA" << std::endl;
    }
};

class ProductB : public AbstractProduct {
public:
    ProductB() {
        std::cout << "Constructor ProductB" << std::endl;
    }
};

class Factory : public AbstractFactory {
public:
    virtual AbstractProduct* Create(const char* tag);
};

AbstractProduct* Factory::Create(const char* tag)
{
    PRODUCT_SWITCH_BEGIN()
        PRODUCT_SWITCH(ProductA)
        PRODUCT_SWITCH(ProductB)
    PRODUCT_SWITCH_END()
}

#endif
