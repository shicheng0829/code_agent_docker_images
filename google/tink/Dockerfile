# Use Ubuntu 20.04 as the base image
FROM --platform=linux/amd64 ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/usr/local/android-sdk
ENV TMP=/tmp

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    openjdk-11-jdk \
    python3 \
    python3-pip \
    wget \
    unzip \
    build-essential \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*

# Install Bazelisk (to manage Bazel versions)
RUN curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 -o /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel

# Install Go
RUN wget https://go.dev/dl/go1.19.linux-amd64.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz \
    && rm go1.19.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin
RUN mkdir -p $GOPATH/src $GOPATH/bin

# Set up Android SDK (required for Java builds)
RUN mkdir -p $ANDROID_HOME \
    && cd $ANDROID_HOME \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O android-tools.zip \
    && unzip -q android-tools.zip \
    && rm android-tools.zip

# Install Python dependencies
RUN pip3 install --upgrade pip

# Create a non-root user
RUN useradd -m -s /bin/bash developer
USER developer
WORKDIR /home/developer/tink

# Copy the project files
COPY --chown=developer:developer . .

# Copy test script and make it executable
COPY --chown=developer:developer test.sh /home/developer/test.sh
RUN chmod +x /home/developer/test.sh

# Default command
CMD ["/home/developer/test.sh"]