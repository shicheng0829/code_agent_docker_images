add_executable(TermOx.tests.unit EXCLUDE_FROM_ALL
    events.test.cpp
    terminal.test.cpp
)

target_compile_options(
    TermOx.tests.unit
    PRIVATE
        -Wall
        -Wextra
        -Wpedantic
)

# 设置C++标准
set_target_properties(TermOx.tests.unit PROPERTIES
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED ON
)

target_link_libraries(
    TermOx.tests.unit
    PRIVATE
        TermOx
        zzz
)