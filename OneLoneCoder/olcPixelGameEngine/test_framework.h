#include <iostream>
#include <vector>
#include <string>
#include <functional>

class TestCase {
public:
    TestCase(const std::string& name, std::function<bool()> test_func) 
        : name(name), test_func(test_func) {}
    
    bool run() {
        std::cout << "Running test: " << name << " ... ";
        bool result = test_func();
        std::cout << (result ? "PASSED" : "FAILED") << std::endl;
        return result;
    }
    
private:
    std::string name;
    std::function<bool()> test_func;
};

class TestSuite {
public:
    static TestSuite& getInstance() {
        static TestSuite instance;
        return instance;
    }
    
    void addTest(const std::string& name, std::function<bool()> test_func) {
        tests.emplace_back(name, test_func);
    }
    
    bool runAllTests() {
        std::cout << "Running " << tests.size() << " tests..." << std::endl;
        int passed = 0;
        for (auto& test : tests) {
            if (test.run()) {
                passed++;
            }
        }
        std::cout << "Tests completed: " << passed << "/" << tests.size() << " passed" << std::endl;
        return passed == tests.size();
    }
    
private:
    TestSuite() = default;
    std::vector<TestCase> tests;
};

#define ADD_TEST(name, func) \
    TestSuite::getInstance().addTest(name, func);

#define RUN_TESTS() \
    return TestSuite::getInstance().runAllTests() ? 0 : 1;

#define ASSERT_TRUE(condition) \
    do { \
        if (!(condition)) { \
            std::cerr << "Assertion failed at " << __FILE__ << ":" << __LINE__ << std::endl; \
            return false; \
        } \
    } while(0)

#define ASSERT_FALSE(condition) \
    do { \
        if (condition) { \
            std::cerr << "Assertion failed at " << __FILE__ << ":" << __LINE__ << std::endl; \
            return false; \
        } \
    } while(0)

#define ASSERT_EQUAL(a, b) \
    do { \
        if (!((a) == (b))) { \
            std::cerr << "Assertion failed at " << __FILE__ << ":" << __LINE__ << ": " << (a) << " != " << (b) << std::endl; \
            return false; \
        } \
    } while(0)