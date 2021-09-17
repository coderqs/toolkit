
execute_process(
    COMMAND git rev-parse --short=8 HEAD
    RESULT_VARIABLE SHORT_HASH_RESULT
    OUTPUT_VARIABLE SHORT_HASH)