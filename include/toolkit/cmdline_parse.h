#ifndef TOOLKIT__CMDLINE_PARSE_H
#define TOOLKIT__CMDLINE_PARSE_H

#include "cmdline/cmdline.h"
#include "error.h"
#include "version.h"

#define VERSION_DESC "获取程序版本号"

typedef void (*SettingCmdlienParamInfo)(cmdline::parser* cmd_paresr);
/// @brief 成功需要返回 0 否则会影响 CmdlineParse 的返回值
typedef int (*ParseCmdlineArguments)(cmdline::parser* cmd_paresr, void* params);

/// @brief 
/// @param argc 
/// @param argv 
/// @param seting  cmdline 设置选项的函数，注：v(version) 已默认占用。
/// @param parse  cmdline 解析的函数。
/// @param params 需要解析的参数的结构体指针。
/// @return 返回 SUCCESS 或者 NO_NEED_PARSE_ARGUMENT 为成功，其余为失败
///         NO_NEED_PARSE_ARGUMENT 发现没有输入选项(argc = 1时)或者需要传出解析值(比如选项 'v' 它不需要将值传出)
int CmdlineParse(int argc, char** argv, SettingCmdlienParamInfo seting, ParseCmdlineArguments parse, void* params) {
    if (argc == 0 || argv == nullptr)
        return INVALID_ARGUMENTS;
    if (nullptr == seting || nullptr == parse)
        return INVALID_CALLBACK;

    int _internal_param_parsed_cnt = 0;
    cmdline::parser cmd_paresr;
    cmd_paresr.add("version", 'v', VERSION_DESC);
    seting(&cmd_paresr);

    cmd_paresr.parse_check(argc, argv);
    try
    {
        if (cmd_paresr.exist("version")) {
            ++_internal_param_parsed_cnt;
            printf("version\n");
            ShowVersionInfo();
        }
    }
    catch (const std::exception& e)
    {
        printf("%s\n", e.what());
    }
    if (_internal_param_parsed_cnt + 1 == argc) {
        return NO_NEED_PARSE_ARGUMENT;
    }
    
    return parse(&cmd_paresr, params) == SUCCESS ? SUCCESS : FAILURE;
}


#endif // TOOLKIT__CMDLINE_PARSE_H