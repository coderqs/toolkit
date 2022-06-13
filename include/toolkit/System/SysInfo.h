#ifndef TOOLKIT__SYSTEM__SYSINFO_H
#define TOOLKIT__SYSTEM__SYSINFO_H
#include <string>

namespace toolkit {

#ifdef WIN32
#include <winsock2.h> // include must before window.h
#include <iphlpapi.h>
#include <windows.h> 

#pragma comment(lib, "iphlpapi.lib")
#pragma comment(lib, "user32.lib")
#pragma warning(disable: 4996) // avoid GetVersionEx to be warned

#else 

#endif // WIN32



} // namespace toolkit
#endif // TOOLKIT__SYSTEM__SYSINFO_H