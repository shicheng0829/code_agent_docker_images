# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install any needed packages specified in requirements.txt and build dependencies
# Also installs pkg-config which is needed for the build
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir setuptools pkgconfig \
    && python setup.py build_ext

# Run tests when the container launches
CMD ["python", "setup.py", "test"]