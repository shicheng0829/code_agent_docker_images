# Trilogy Development Environment

This directory contains Docker configurations for developing and testing Trilogy, a MySQL client library.

## Files

- `Dockerfile`: Builds a container with all dependencies needed to compile and test Trilogy
- `docker-compose.dev.yml`: Sets up a development environment with both the Trilogy app and a MySQL database

## Quick Start

1. Build and start the development environment:
   ```
   docker-compose -f docker-compose.dev.yml up -d
   ```

2. Run tests:
   ```
   docker-compose -f docker-compose.dev.yml exec app make test
   ```

3. Enter the development container for interactive work:
   ```
   docker-compose -f docker-compose.dev.yml exec app bash
   ```

4. Stop the development environment:
   ```
   docker-compose -f docker-compose.dev.yml down
   ```

## Environment Variables

The test suite recognizes the following environment variables:
- `MYSQL_HOST`: Database hostname (default: 127.0.0.1)
- `MYSQL_PORT`: Database port (default: 3306)
- `MYSQL_USER`: Database username (default: root)
- `MYSQL_PASS`: Database password
- `MYSQL_DB`: Database name (default: test)

## Development Workflow

1. Make changes to the source code on your host machine
2. The changes will be immediately reflected in the container due to volume mounting
3. Compile and test inside the container:
   ```
   make test/test  # Rebuild tests
   make test       # Run tests
   ```

## Notes

- The MySQL database is preconfigured with a test user (testuser/testpass) and test database
- Test failures with `TRILOGY_UNSUPPORTED` are expected in some cases due to protocol differences between MySQL versions