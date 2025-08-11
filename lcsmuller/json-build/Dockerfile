FROM alpine:latest

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    clang \
    gcc

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build tests
RUN cd test && make

# Default command to run all tests
CMD ["cd test && echo 'Running basic tests...' && ./test && echo && echo 'Running auto tests...' && ./test_auto"]

# Allow running specific commands as arguments
ENTRYPOINT ["sh", "-c"]