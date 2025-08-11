FROM debian:latest

# Install necessary tools for building and testing BqLog
RUN apt-get update && \
    apt-get install -y gcc g++ make cmake openjdk-17-jdk gdb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up Java environment
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Fix ARM compilation issue
RUN sed -i 's/__builtin_arm_yield()/asm volatile("yield" ::: "memory")/g' src/bq_common/platform/thread/thread_posix.cpp

# Default command to run tests
CMD ["bash", "-c", "cd build/test/linux && chmod +x *.sh && ./RunTest_GCC.sh"]