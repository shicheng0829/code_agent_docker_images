# Simple Makefile for minimp3 development

# Default target
.PHONY: all
all: build

# Build the minimp3 test program
.PHONY: build
build:
	gcc -O2 -std=c89 -Wall -Wextra -Wmissing-prototypes -Werror -o minimp3 minimp3_test.c -lm

# Run a basic test
.PHONY: test-basic
test-basic: build
	./minimp3 vectors/l3-sin1k0db.bit

# Run all tests
.PHONY: test-all
test-all: build
	@echo "Running tests on various MP3 files..."
	@for f in vectors/*.bit; do \
		echo "Testing $$f"; \
		./minimp3 "$$f" || exit 1; \
	done
	@echo "All tests passed!"

# Clean build artifacts
.PHONY: clean
clean:
	rm -f minimp3

# Help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all         - Build the project (default)"
	@echo "  build       - Build the minimp3 test program"
	@echo "  test-basic  - Run a basic test"
	@echo "  test-all    - Run all tests"
	@echo "  clean       - Clean build artifacts"
	@echo "  help        - Show this help"