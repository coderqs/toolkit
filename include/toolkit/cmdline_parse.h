#ifndef TOOLKIT__CMDLINE_PARSE_H
#define TOOLKIT__CMDLINE_PARSE_H

#include "cmdline/cmdline.h"
#include "error.h"
#include "version.h"

#define VERSION_DESC "��ȡ����汾��"

typedef void (*SettingCmdlienParamInfo)(cmdline::parser* cmd_paresr);
/// @brief �ɹ���Ҫ���� 0 �����Ӱ�� CmdlineParse �ķ���ֵ
typedef int (*ParseCmdlineArguments)(cmdline::parser* cmd_paresr, void* params);

/// @brief 
/// @param argc 
/// @param argv 
/// @param seting  cmdline ����ѡ��ĺ�����ע��v(version) ��Ĭ��ռ�á�
/// @param parse  cmdline �����ĺ�����
/// @param params ��Ҫ�����Ĳ����Ľṹ��ָ�롣
/// @return ���� SUCCESS ���� NO_NEED_PARSE_ARGUMENT Ϊ�ɹ�������Ϊʧ��
///         NO_NEED_PARSE_ARGUMENT ����û������ѡ��(argc = 1ʱ)������Ҫ��������ֵ(����ѡ�� 'v' ������Ҫ��ֵ����)
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