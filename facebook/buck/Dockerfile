# Use an official OpenJDK runtime as a parent image
FROM openjdk:8-jdk

# Set the working directory in the container
WORKDIR /usr/src/buck

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip \
    ant \
    && rm -rf /var/lib/apt/lists/*

# Install pyenv dependencies
RUN apt-get update && apt-get install -y \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    ca-certificates \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pyenv
ENV PYENV_ROOT=/root/.pyenv
ENV PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN curl -k https://pyenv.run | bash \
    && $PYENV_ROOT/bin/pyenv install 3.9.4 \
    && $PYENV_ROOT/bin/pyenv global 3.9.4

# Verify Python installation
RUN python --version

# Copy the current directory contents into the container at /usr/src/buck
COPY . .

# Build the project
RUN ant

# Command to run tests
CMD ["./bin/buck", "test", "--all", "--test-selectors", "!.*[Ii]ntegration.*"]