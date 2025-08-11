# Simple CMakeLists.txt for Boost.Interprocess tests
# This is a minimal version to enable testing

# Create a simple test executable
add_executable(condition_test condition_test.cpp)

# Link with required libraries
target_link_libraries(condition_test 
    PRIVATE 
        Boost::interprocess
        Boost::system
)

# Add test to CTest
add_test(NAME condition_test COMMAND condition_test)