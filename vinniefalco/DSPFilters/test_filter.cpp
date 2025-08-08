#include "shared/DSPFilters/include/DspFilters/Dsp.h"
#include "shared/DSPFilters/include/DspFilters/Butterworth.h"
#include <iostream>

int main() {
  // 创建一个Butterworth低通滤波器
  Dsp::SimpleFilter<Dsp::Butterworth::LowPass<4>, 1> f;
  f.setup(4, 44100, 1000);
  
  std::cout << "DSPFilters library test successful!" << std::endl;
  return 0;
}