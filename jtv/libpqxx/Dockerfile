# Use Debian stable as the base image
FROM debian:stable

# Set environment variables for PostgreSQL
ENV PGHOST=/tmp
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install dependencies
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y lsb-release python3 postgresql libpq-dev \
    postgresql-server-dev-all build-essential autoconf \
    autoconf-archive automake cppcheck clang shellcheck \
    python3-virtualenv libtool git sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user and give it sudo privileges
RUN useradd -m -s /bin/bash developer && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER developer
WORKDIR /home/developer

# Clone the libpqxx repository
RUN git clone https://github.com/jtv/libpqxx.git
WORKDIR /home/developer/libpqxx

# Copy the current libpqxx source code into the container
# This assumes you're building from the libpqxx source directory
COPY . .

# Change ownership of the copied files to the developer user
RUN sudo chown -R developer:developer /home/developer/libpqxx

# Prepare PostgreSQL database
USER root
RUN mkdir /tmp/db && \
    chown postgres /tmp/db && \
    su postgres -c '/usr/lib/postgresql/*/bin/initdb --pgdata /tmp/db --auth trust --nosync'

# Create a script to start PostgreSQL and run tests
RUN echo '#!/bin/bash\n\
# Start PostgreSQL\n\
su postgres -c "/usr/lib/postgresql/*/bin/postgres -D /tmp/db -k /tmp" &\n\
# Wait for PostgreSQL to start\n\
until su postgres -c "/usr/lib/postgresql/*/bin/pg_isready -h /tmp"; do\n\
  sleep 1\n\
done\n\
# Create user and database\n\
su postgres -c "createuser -w -d developer"\n\
su developer -c "createdb --template=template0 --encoding=UNICODE developer"\n\
# Run tests\n\
cd /home/developer/libpqxx\n\
sudo -u developer ./autogen.sh\n\
sudo -u developer ./configure --enable-maintainer-mode --enable-audit --enable-shared --disable-static CXXFLAGS="-O3 -std=c++17" CXX=clang++\n\
sudo -u developer make -j$(nproc)\n\
sudo -u developer PGDATA=db/data make -j$(nproc) check\n' > /start_and_test.sh && chmod +x /start_and_test.sh

# Switch back to developer user
USER developer

# Keep the container running for development
CMD ["/bin/bash"]