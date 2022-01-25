#include <iostream>
#include <string>

#include "cmdline/cmdline.h"

int main(int argc, char** argv) {
    cmdline::parser cmd_paresr;
    cmd_paresr.add("help", 'h', "获取帮助");
    cmd_paresr.add("version", 'v', "获取程序版本号");
    cmd_paresr.add<std::string>("ip", 'i', "设置本地地址", true, "127.0.0.1");
    cmd_paresr.add<int>("port", 'p', "设置本地端口", true, 8080, cmdline::range(0, 65535));

    cmd_paresr.parse_check(argc, argv);

    if (cmd_paresr.exist("help")) {
        std::cout << "need help" << std::endl;
    }
    if (cmd_paresr.exist("v")) {
        std::cout << "version: %s" << std::endl;
    }

    std::string ip = cmd_paresr.get<std::string>("ip");
    std::cout << "ip: " << ip << std::endl;
    int port = cmd_paresr.get<int>("p");
    std::cout << "port: " << port << std::endl;

    return 0;
}