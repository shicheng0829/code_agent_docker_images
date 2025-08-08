FROM openjdk:8-alpine

# Install bash and other utilities
RUN apk add --no-cache bash curl

# Install Leiningen
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
    && chmod +x lein \
    && mv lein /usr/local/bin/

# Create app directory
WORKDIR /app

# Copy project files
COPY project.clj /app/
COPY README.md /app/
COPY run-tests.sh /app/

# Install dependencies
RUN lein deps

# Copy source code and tests
COPY src /app/src
COPY test /app/test
COPY resources /app/resources

# Make the script executable
RUN chmod +x /app/run-tests.sh

# Default command runs tests
CMD ["/app/run-tests.sh"]