Usage instructions:
1. Build the Docker image: docker build -t rapidyaml-dev .
2. Run tests: docker run --rm rapidyaml-dev make test
3. Run specific test: docker run --rm rapidyaml-dev ./test/ryml-test-<test-name>-0.9.0
4. Interactive shell: docker run -it rapidyaml-dev bash
