#ifndef TOOLKIT__ERROR_H
#define TOOLKIT__ERROR_H

enum {
    FAILURE = -1,
    SUCCESS = 0,
    INVALID_ARGUMENTS = 1,
};

enum ErrCmdlineParse {
    NO_NEED_PARSE_ARGUMENT = 11,
    INVALID_CALLBACK = 12,
    UNRECOGNIZED_OPTION = 13,
};


#endif // TOOLKIT__ERROR_H