#ifndef TOOLKIT__DESIGNPATTERN__FACTORY_H
#define TOOLKIT__DESIGNPATTERN__FACTORY_H

#define PRODUCT_SWITCH_BEGIN() \
    AbstractProduct* product = NULL; 

#define PRODUCT_SWITCH(macro_tag) \
    if (strcmp(tag, #macro_tag) == 0) {\
        product = new macro_tag; \
    }

#define PRODUCT_SWITCH_END() \
    return product;

class AbstractProduct {
public:
    
};

class AbstractFactory {
public:
    virtual AbstractProduct* Create(const char* tag) = 0;
};


#endif // TOOLKIT__DESIGNPATTERN__FACTORY_H