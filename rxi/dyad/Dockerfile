FROM gcc:latest

RUN apt-get update && apt-get install -y python3

WORKDIR /app

COPY . .

RUN mkdir -p bin

# Compile the echoserv example during the build
RUN cd example && gcc -I../src -o ../bin/echoserv echoserv.c ../src/dyad.c

# Expose port 8000
EXPOSE 8000

# Default command to run the compiled binary
CMD ["./bin/echoserv"]