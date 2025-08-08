# Dockerized Development Environment

This project provides two Docker images for different purposes:

## Development and Testing Image

Build the development image:
```bash
docker build -t value-category-cheatsheet-dev .
```

Run tests:
```bash
docker run --rm value-category-cheatsheet-dev
```

## Server Image

Build the server image:
```bash
docker build -f Dockerfile.server -t value-category-cheatsheet-server .
```

Run the server:
```bash
docker run --rm -p 3000:3000 value-category-cheatsheet-server
```

The server will be accessible at http://localhost:3000