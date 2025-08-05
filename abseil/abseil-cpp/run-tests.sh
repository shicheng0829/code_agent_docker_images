#!/bin/bash
cd build
cmake .. \
  -DABSL_GOOGLETEST_DOWNLOAD_URL=https://github.com/google/googletest/releases/download/v1.17.0/googletest-1.17.0.tar.gz \
  -DABSL_BUILD_TESTING=ON \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_CXX_STANDARD=17
make -j$(nproc)
TZDIR=/abseil-cpp/absl/time/internal/cctz/testdata/zoneinfo \
ctest -j$(nproc) --output-on-failure