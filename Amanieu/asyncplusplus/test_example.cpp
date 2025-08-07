#include <async++.h>
#include <iostream>
#include <cassert>

int main() {
    // 测试基本任务执行
    auto task = async::spawn([]() -> int {
        return 42;
    });
    
    int result = task.get();
    assert(result == 42);
    
    // 测试延续任务
    auto task2 = async::spawn([]() -> int {
        return 10;
    }).then([](int x) -> int {
        return x * 2;
    });
    
    int result2 = task2.get();
    assert(result2 == 20);
    
    // 测试并行执行
    auto task3 = async::spawn([]() {
        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    });
    
    auto task4 = async::spawn([]() {
        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    });
    
    async::when_all(task3, task4).get();
    
    std::cout << "All tests passed!" << std::endl;
    return 0;
}