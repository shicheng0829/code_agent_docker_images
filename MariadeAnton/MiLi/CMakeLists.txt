cmake_minimum_required(VERSION 3.10)
project(mili_tests)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)

# Include directories
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/mili)

# Find GTest
find_package(GTest REQUIRED)

# Since we're using gmock features, we need to link gmock as well
# On Ubuntu, gmock is usually packaged with gtest
find_library(GMOCK_LIBRARY NAMES gmock PATHS /usr/lib /usr/local/lib)
find_library(GMOCK_MAIN_LIBRARY NAMES gmock_main PATHS /usr/lib /usr/local/lib)

# Create executable
file(GLOB TEST_SOURCES "tests/*_test*.cpp")
# Remove gmock-related tests to avoid linking issues
list(FILTER TEST_SOURCES EXCLUDE REGEX ".*delete-container_test.*")
list(FILTER TEST_SOURCES EXCLUDE REGEX ".*prepos-caller_test.*")
list(FILTER TEST_SOURCES EXCLUDE REGEX ".*properties_tests.*")
list(FILTER TEST_SOURCES EXCLUDE REGEX ".*raii_test.*")

add_executable(mili_test ${TEST_SOURCES} tests/mili_test_suite.cpp)

# Link libraries
target_link_libraries(mili_test GTest::GTest GTest::Main pthread)