FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    autotools-dev \
    automake \
    libtool \
    pkg-config \
    libxml2-utils \
    zlib1g-dev \
    libcurl4-gnutls-dev \
    libmms-dev \
    git \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install jsonlint globally
RUN npm install -g jsonlint

# Set working directory
WORKDIR /usr/src/MediaInfoLib

# Copy the current directory contents into the container
COPY . .

# Clone ZenLib dependency
RUN git -C .. clone --depth=1 https://github.com/MediaArea/ZenLib.git

# Build and install ZenLib
RUN cd ../ZenLib/Project/GNU/Library && \
    autoreconf -if && \
    ./configure --enable-silent-rules --enable-static && \
    make && \
    make install

# Build MediaInfoLib
RUN cd Project/GNU/Library && \
    autoreconf -if && \
    ./configure --enable-silent-rules --with-libcurl=runtime && \
    make

# Clone regression test files
RUN cd Project/GNU/Library && \
    make clone_regression_files

# Run tests
CMD ["make", "-C", "Project/GNU/Library", "check"]