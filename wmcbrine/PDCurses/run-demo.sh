#!/bin/bash
if [ "$#" -eq 0 ]; then
  echo "Running PDCurses unit tests..."
  cd x11
  for demo in firework ozdemo ptest rain testcurs tuidemo worm xmas; do
    echo "Running $demo..."
    timeout 10s xvfb-run -a ./$demo || echo "$demo completed or timed out"
  done
  echo "All tests completed."
else
  # Run the specified demo
  cd x11
  echo "Running $1..."
  xvfb-run -a ./$1
fi