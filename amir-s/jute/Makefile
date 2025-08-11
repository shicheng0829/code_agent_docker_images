# Makefile for jute JSON parser

# Compiler
CXX = g++

# Compiler flags
CXXFLAGS = -Wall -Wextra -std=c++11

# Source files
SOURCES = jute.cpp
HEADERS = jute.h

# Default target
all: main test

# Build main executable
main: main.cpp $(SOURCES) $(HEADERS)
	$(CXX) $(CXXFLAGS) -o main main.cpp $(SOURCES)

# Build test executable
test: test.cpp $(SOURCES) $(HEADERS)
	$(CXX) $(CXXFLAGS) -o test test.cpp $(SOURCES)

# Run tests
check: test
	./test

# Clean build files
clean:
	rm -f main test

# Install (just shows message since this is a header-only library)
install:
	@echo "This is a header-only library. Simply copy jute.h to your include directory."

.PHONY: all clean check install