# LIBSVM Development Docker Image

This Docker image provides a complete development environment for LIBSVM with both C/C++ tools and Python bindings.

## Features

- Ubuntu 20.04 base image
- LIBSVM C/C++ command-line tools (`svm-train`, `svm-predict`, `svm-scale`)
- Python 3 with SciPy and NumPy
- LIBSVM Python bindings
- Pre-built shared library for Python interface

## Building the Image

```bash
docker build -t libsvm-dev .
```

## Running Tests

By default, the container runs a basic test suite:

```bash
docker run --rm libsvm-dev
```

This will:
1. Train a model using `svm-train` on the `heart_scale` dataset
2. Test predictions using `svm-predict`
3. Test data scaling using `svm-scale`

## Using the Container

### Interactive Mode

To access the container interactively:

```bash
docker run -it --rm libsvm-dev bash
```

### Running Custom Commands

To run custom commands:

```bash
docker run --rm libsvm-dev [command]
```

For example, to run a Python script:

```bash
docker run --rm libsvm-dev python3 my_script.py
```

### Mounting Volumes

To access your local files:

```bash
docker run -it --rm -v /path/to/local/dir:/app/data libsvm-dev bash
```

## Components Verification

The image has been tested with the `heart_scale` dataset and includes:

1. **CLI Tools**: 
   - `svm-train` - Training tool
   - `svm-predict` - Prediction tool
   - `svm-scale` - Data scaling tool

2. **Python Bindings**:
   - Full Python interface to LIBSVM functions
   - Compatible with both dense and sparse data formats
   - Supports all SVM types (C-SVC, nu-SVC, one-class SVM, epsilon-SVR, nu-SVR)

## Environment Variables

- `LD_LIBRARY_PATH` is set to include the `/app` directory for shared library access

## Dependencies

- build-essential
- python3
- python3-pip
- python3-dev
- wget
- gnuplot
- scipy
- numpy