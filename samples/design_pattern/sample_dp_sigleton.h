#ifndef TOOLKIT__SAMPLES__DESIGN_PATTERN__SAMPLE_DP_SINGLETON_H
#define TOOLKIT__SAMPLES__DESIGN_PATTERN__SAMPLE_DP_SINGLETON_H

#include "DesignPattern/Singleton.h"

class SampleSingleton : public Singleton<SampleSingleton> {
public:
    SampleSingleton() = default;
    ~SampleSingleton() = default;
};


#endif
