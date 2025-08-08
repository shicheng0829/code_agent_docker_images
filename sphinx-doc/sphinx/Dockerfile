FROM python:3.12-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Install Python dependencies including test dependencies
RUN pip install --no-cache-dir .[test] pytest defusedxml typing_extensions cython

# Run tests
CMD ["python", "-m", "pytest", "-vv"]