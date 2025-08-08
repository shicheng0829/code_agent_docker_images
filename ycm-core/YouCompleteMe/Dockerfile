FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL C.UTF-8

# Install dependencies
RUN apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get -y --no-install-recommends install \
                     gnupg \
                     locales \
                     tzdata \
                     language-pack-en \
                     sudo \
                     libncurses5-dev libncursesw5-dev \
                     git \
                     build-essential \
                     cmake \
                     python3-dev \
                     python3-pip \
                     python3-setuptools \
                     python3-wheel \
                     openjdk-11-jdk-headless \
                     nodejs \
                     npm \
                     vim-nox \
                     zlib1g-dev && \
  apt-get -y autoremove

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata

# Install Python test requirements
COPY python/test_requirements.txt /tmp/test_requirements.txt
RUN pip3 install --break-system-packages -r /tmp/test_requirements.txt

# Copy the project code
COPY . /youcompleteme
WORKDIR /youcompleteme

# Initialize submodules
RUN git submodule update --init --recursive

# Build ycmd
RUN python3 ./install.py --force-sudo

# Create a non-root user
RUN useradd -m -s /bin/bash ycm_user

# Change ownership of the project directory
RUN chown -R ycm_user:ycm_user /youcompleteme

# Switch to the non-root user
USER ycm_user

# Run tests
CMD ["python3", "run_tests.py", "--quiet", "python/ycm/tests"]