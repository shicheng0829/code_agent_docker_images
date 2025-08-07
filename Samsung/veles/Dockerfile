FROM python:3.9-slim

WORKDIR /app

# Upgrade pip to latest version
RUN pip install --upgrade pip

# Install some dependencies that might be needed for building packages
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    git \
    unixodbc-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements files
COPY requirements.txt requirements-dev.3.txt ./

# Install development dependencies
RUN pip install --no-cache-dir -r requirements-dev.3.txt

# Create a temporary file with adjusted requirements
# We need to handle some packages separately due to version conflicts
RUN echo "matplotlib>=1.4.0" >> temp-requirements.txt && \
    echo "numpy>=1.8.2" >> temp-requirements.txt && \
    echo "scipy>=0.13.3" >> temp-requirements.txt && \
    echo "Pillow>=2.0.0" >> temp-requirements.txt && \
    echo "six>=1.3.0" >> temp-requirements.txt && \
    echo "tornado>=4.0" >> temp-requirements.txt && \
    echo "tornado-smtpclient>=0.1.5" >> temp-requirements.txt && \
    echo "twisted>=14.0.0" >> temp-requirements.txt && \
    echo "ply>=3.4" >> temp-requirements.txt && \
    echo "paramiko==1.13.0" >> temp-requirements.txt && \
    echo "opencl4py>=1.0" >> temp-requirements.txt && \
    echo "argcomplete>=0.8" >> temp-requirements.txt && \
    echo "ipython<4.0.0" >> temp-requirements.txt && \
    echo "jpeg4py>=0.1.0" >> temp-requirements.txt && \
    echo "cffi>=0.8.2" >> temp-requirements.txt && \
    echo "glymur>=0.5.10" >> temp-requirements.txt && \
    echo "lockfile>=0.9.1" >> temp-requirements.txt && \
    echo "python-snappy>=0.5" >> temp-requirements.txt && \
    echo "posix-ipc>=0.9.8" >> temp-requirements.txt && \
    echo "pycrypto>=2.6.1" >> temp-requirements.txt && \
    echo "ecdsa>=0.11" >> temp-requirements.txt && \
    echo "pyzmq>=14.3.1" >> temp-requirements.txt && \
    echo "wget>=2.2" >> temp-requirements.txt && \
    echo "service_identity>=0.2" >> temp-requirements.txt && \
    echo "pygit2>=0.21.4" >> temp-requirements.txt && \
    echo "pyinotify>=0.9.4" >> temp-requirements.txt && \
    echo "cuda4py>=1.0" >> temp-requirements.txt && \
    echo "psutil>=1.2.1" >> temp-requirements.txt && \
    echo "pyxDamerauLevenshtein>=1.2" >> temp-requirements.txt && \
    echo "h5py>=2.2" >> temp-requirements.txt && \
    echo "jinja2>=2.7.2" >> temp-requirements.txt && \
    echo "pycparser>=2.10" >> temp-requirements.txt && \
    echo "pyodbc>=3.0.10" >> temp-requirements.txt && \
    echo "markdown>=2.6.2" >> temp-requirements.txt && \
    echo "py-gfm>=0.1.1" >> temp-requirements.txt && \
    echo "weasyprint>=0.23" >> temp-requirements.txt && \
    echo "pyasn1>=0.1.8" >> temp-requirements.txt && \
    echo "lmdb>=0.86" >> temp-requirements.txt

# Install main dependencies from the temporary file
RUN pip install --no-cache-dir -r temp-requirements.txt

# Install specific versions of motor and pymongo that are compatible
# Since we're having issues with older versions, let's try newer ones
RUN pip install --no-cache-dir motor>=2.0.0 pymongo>=3.0.0

# Clean up the temporary file
RUN rm temp-requirements.txt

# Copy the rest of the application
COPY . .

# Fix the time.clock issue for Python 3.8+
# This is a workaround for the deprecated time.clock function
RUN sed -i 's/from time import clock/from time import perf_counter as clock/g' veles/external/progressbar/spinner.py

# Install the package and its dependencies
# We'll install the package directly without editable mode to avoid issues
RUN pip install --no-cache-dir .

# Set environment variable to allow root execution
ENV VELES_ALLOW_ROOT=1

# Command to run tests
CMD ["python", "-m", "unittest", "discover"]