#ifndef TOOLKIT__SAMPLES__DESIGN_PATTERN__SAMPLE_DP_FACADE_H
#define TOOLKIT__SAMPLES__DESIGN_PATTERN__SAMPLE_DP_FACADE_H

#include <iostream>
#include <string>
#include <memory>

class ISubSystem {
public:
    virtual void operation(void) {
        std::cout << m_system_name << std::endl;
    }

protected:
    std::string m_system_name;
};

class ProductionSystem : public ISubSystem {
public:
    ProductionSystem() {
        m_system_name = "production system";
    }
    //virtual void operation(void) {
    //    std::cout << m_system_name << std::endl;
    //}
};

class SalesSystem : public ISubSystem {
public:
    SalesSystem() {
        m_system_name = "sales system";
    }
    //virtual void operation(void) {
    //    std::cout << m_system_name << std::endl;
    //}
};

class ClearingSystem : public ISubSystem {
public:
    ClearingSystem() {
        m_system_name = "clearing system";
    }
    //virtual void operation(void) {
    //    std::cout << m_system_name << std::endl;
    //}  
};
 
class SemiworkFacade {
public:
    SemiworkFacade() : m_production(new ProductionSystem), m_sales(new SalesSystem), m_clearing(new ClearingSystem){}
    void WrapOperation(void) {
        m_production->operation();
        m_sales->operation();
        m_clearing->operation();
    }

private:
    std::shared_ptr<ProductionSystem> m_production;
    std::shared_ptr<SalesSystem> m_sales;
    std::shared_ptr<ClearingSystem> m_clearing;
};

#endif // TOOLKIT__SAMPLES__DESIGN_PATTERN__SAMPLE_DP_FACADE_H