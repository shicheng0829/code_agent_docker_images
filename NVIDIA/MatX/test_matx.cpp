#include <matx.h>

int main() {
  // Create a tensor with 2 elements
  matx::tensor_t<float, 1> t({2});
  
  // Initialize tensor values
  t.SetVals({1.0f, 2.0f});
  
  // Print tensor values
  t.Print();
  
  return 0;
}