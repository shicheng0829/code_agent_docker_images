FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    python2.7 \
    python-dev \
    python-setuptools \
    python-numpy \
    python-pip \
    g++ \
    make \
    libboost-all-dev \
    psmisc \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install the package
RUN pip install numpy
RUN python setup.py install

# Default command to run tests
CMD ["make", "-C", "tests"]