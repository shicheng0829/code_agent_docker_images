#include "plf_nanotimer.h"
#include <iostream>
#include <cassert>
#include <cmath>

int main() {
    // Test basic timer functionality
    plf::nanotimer timer;
    
    // Test start and get_elapsed_* functions
    timer.start();
    plf::millisecond_delay(10); // Delay for 10ms
    double elapsed_ms = timer.get_elapsed_ms();
    
    // Check that elapsed time is approximately correct (with tolerance)
    assert(elapsed_ms >= 5 && elapsed_ms <= 100); // Reasonable range
    
    std::cout << "10ms delay took " << elapsed_ms << " ms" << std::endl;
    
    // Test microsecond delay
    timer.start();
    plf::microsecond_delay(1000); // Delay for 1000 microseconds (1ms)
    double elapsed_us = timer.get_elapsed_us();
    
    std::cout << "1000us delay took " << elapsed_us << " us" << std::endl;
    
    // Test nanosecond delay
    timer.start();
    plf::nanosecond_delay(1000000); // Delay for 1,000,000 nanoseconds (1ms)
    double elapsed_ns = timer.get_elapsed_ns();
    
    std::cout << "1000000ns delay took " << elapsed_ns << " ns" << std::endl;
    
    // Test timer restart functionality
    timer.start();
    plf::millisecond_delay(5);
    double first_interval = timer.get_elapsed_ms();
    
    timer.start(); // Restart
    plf::millisecond_delay(5);
    double second_interval = timer.get_elapsed_ms();
    
    std::cout << "First interval: " << first_interval << " ms" << std::endl;
    std::cout << "Second interval: " << second_interval << " ms" << std::endl;
    
    std::cout << "All tests passed!" << std::endl;
    
    return 0;
}