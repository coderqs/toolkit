#ifndef TOOLKIT__SYSTEM__CPUINFO_H
#define TOOLKIT__SYSTEM__CPUINFO_H
#include <iostream>
#include <string>
#if defined(WIN32)
#include <winsock2.h> // include must before window.h
#include <iphlpapi.h>
#include <windows.h> 
#include <intrin.h>

#pragma comment(lib, "iphlpapi.lib")
#pragma comment(lib, "user32.lib")
#pragma warning(disable: 4996) // avoid GetVersionEx to be warned

#endif // defined(WIN32)

namespace toolkit {
    void GetCpuInfo() {
        int cpuInfo[4] = { -1 };
        char cpu_manufacture[32] = { 0 };
        char cpu_type[32] = { 0 };
        char cpu_freq[32] = { 0 };

        __cpuid(cpuInfo, 0x80000002);
        memcpy(cpu_manufacture, cpuInfo, sizeof(cpuInfo));

        __cpuid(cpuInfo, 0x80000003);
        memcpy(cpu_type, cpuInfo, sizeof(cpuInfo));

        __cpuid(cpuInfo, 0x80000004);
        memcpy(cpu_freq, cpuInfo, sizeof(cpuInfo));

        std::cout << "CPU manufacture: " << cpu_manufacture << std::endl;
        std::cout << "CPU type: " << cpu_type << std::endl;
        std::cout << "CPU main frequency: " << cpu_freq << std::endl;
    }

} // namespace toolkit

#endif // TOOLKIT__SYSTEM__CPUINFO_H