# CppRestSDK Development Docker Image

This Docker image provides a development environment for CppRestSDK with all dependencies installed and ready to run unit tests.

## Features

- Ubuntu 18.04 base image
- All required dependencies for CppRestSDK
- Pre-built CppRestSDK library and unit tests
- Scripts to run unit tests

## Usage

### Build the Docker image

```bash
docker build -t cpprestsdk-dev .
```

### Run unit tests (summary view)

```bash
docker run --rm cpprestsdk-dev /app/run_tests_summary.sh
```

This will show the first 50 lines of test output, which is useful for quick verification.

### Run unit tests (full output)

```bash
docker run --rm cpprestsdk-dev /app/run_tests.sh
```

This will show the full test output. Note that some tests may fail due to network requirements or missing test servers, which is expected in this environment.

### Interactive shell

```bash
docker run -it cpprestsdk-dev
```

This will give you an interactive shell where you can explore the environment, run custom commands, or manually execute tests.

### Rebuild the project

Inside the container:

```bash
cd build.debug && ninja
```

## Notes

- Some tests may fail due to network requirements or missing test servers. These failures are expected in this environment.
- The image includes both debug and release builds of the library.
- Test binaries are located in `/app/build.debug/Release/Binaries/`