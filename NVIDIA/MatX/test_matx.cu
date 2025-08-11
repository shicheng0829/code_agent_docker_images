#include <matx.h>

int main() {
  // Initialize MatX runtime
  matx::Init();
  
  // Create a tensor with 2 elements
  matx::tensor_t<float, 1> t({2});
  
  // Initialize tensor values
  t.SetVals({1.0f, 2.0f});
  
  // Print tensor values
  t.PrefetchDeviceToHost();
  printf("Tensor values: %f %f\n", t(0), t(1));
  
  // Cleanup
  matx::Destroy();
  
  return 0;
}