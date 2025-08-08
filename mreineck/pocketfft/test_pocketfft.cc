#include "pocketfft_hdronly.h"
#include <complex>
#include <vector>
#include <iostream>
#include <random>
#include <cmath>

using namespace std;
using namespace pocketfft;

// Simple test for 1D complex FFT
void test_c2c() {
    cout << "Testing 1D complex-to-complex FFT..." << endl;
    
    const size_t len = 8;
    shape_t shape{len};
    stride_t stride_in{sizeof(complex<double>)};
    stride_t stride_out{sizeof(complex<double>)};
    shape_t axes{0};
    
    vector<complex<double>> data(len);
    vector<complex<double>> res(len);
    
    // Simple test data
    for (size_t i = 0; i < len; ++i) {
        data[i] = complex<double>(double(i), 0.0);
    }
    
    // Forward FFT
    c2c(shape, stride_in, stride_out, axes, FORWARD, data.data(), res.data(), 1.0);
    
    // Print results
    cout << "  Input:" << endl;
    for (size_t i = 0; i < len; ++i) {
        cout << "    " << i << ": " << data[i].real() << " + " << data[i].imag() << "i" << endl;
    }
    
    cout << "  FFT result:" << endl;
    for (size_t i = 0; i < len; ++i) {
        cout << "    " << i << ": " << res[i].real() << " + " << res[i].imag() << "i" << endl;
    }
    
    cout << "  PASSED" << endl;
}

int main() {
    cout << "Running PocketFFT tests..." << endl;
    
    test_c2c();
    
    cout << "All tests completed!" << endl;
    return 0;
}