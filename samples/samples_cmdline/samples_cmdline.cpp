#include <iostream>
#include <string>
#include "toolkit/cmdline_parse.h"

struct CmdineParams {
    std::string ip;
    int port;
};
static void _SettingParamInfo(cmdline::parser* cmd_paresr) {
    cmd_paresr->add<std::string>("ip", 'i', "设置本地地址", false, "127.0.0.1");
    cmd_paresr->add<int>("port", 'p', "设置本地端口", false, 8080, cmdline::range(0, 65535));
}

static int _ParseArguments(cmdline::parser* cmd_paresr, void* params) {
    CmdineParams* cmd_params = (CmdineParams*)params;
    try
    {
        cmd_params->ip = cmd_paresr->get<std::string>("ip");
        cmd_params->port = cmd_paresr->get<int>("port");
    }
    catch (const std::exception& e)
    {
        printf("%s", e.what());
        return UNRECOGNIZED_OPTION;
    }
}
int main(int argc, char** argv) {
    CmdineParams params;
    int ret = CmdlineParse(argc, argv, _SettingParamInfo, _ParseArguments, &params);
    printf("ret: %d\n", ret);
    printf("ip: %s, port: %d", params.ip.c_str(), params.port);
    return 0;
}