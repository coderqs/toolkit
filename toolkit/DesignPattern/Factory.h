#ifndef TOOLKIT__DESIGNPATTERN__FACTORY_H
#define TOOLKIT__DESIGNPATTERN__FACTORY_H

#define PRODUCT_SWITCH_BEGIN() \
    AbstractProduct* product = NULL; 

#define PRODUCT_SWITCH(tag_) \
    if (strcmp(tag, #tag_) == 0) {\
        product = new tag_; \
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