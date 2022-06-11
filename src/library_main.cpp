#include "version.h"

#ifdef __linux__

#ifdef __x86_64__
const char interp[] __attribute__((section(".interp"))) = "/lib64/ld-linux-x86-64.so.2";
#else
const char interp[] __attribute__((section(".interp"))) = "/lib/ld-linux.so.2";
#endif // __x86_64__
#include <unistd.h>

static const char banner[] =
PROGRAM_NAME " version " PROGRAM_VERSION_MAJOR "." PROGRAM_VERSION_MINOR "." PROGRAM_VERSION_PATCH "\n" \
"Build in " __DATE__ __TIME__ " (for Linux platform)\n" \
"Managed on " REPOSITORY " revision num: " REVISION_NUM "\n" \
"Copyright (C) all rights reserved QingSong\n";

extern void __libc_print_version(void);
void __libc_print_version(void) {
    write(STDOUT_FILENO, banner, sizeof banner - 1);
}

/* This function is the entry point for the shared object.
   Running the library as a program will get here.  */

extern void __libc_main(void) __attribute__((noreturn));
void __libc_main(void) {
    __libc_print_version();
    _exit(0);
}

#endif