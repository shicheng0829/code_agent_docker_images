# Concord Development Docker Environment

This Docker environment is set up for developing and testing the Concord C Discord API library.

## Building the Docker Image

```bash
docker build -t concord-dev .
```

## Running Tests

The tests require a valid Discord token to run successfully. Without a token, they will fail with authorization errors, which is expected.

### Display Help Information

```bash
docker run --rm concord-dev
```

### Run Tests Without Token (Will Fail)

```bash
docker run --rm concord-dev sh -c 'cd test && ./racecond && ./rest && ./timeout && ./user-agent && ./websockets && ./queriec'
```

### Run Tests With Token (Requires Valid Discord Token)

```bash
docker run --rm -e DISCORD_TOKEN=your_valid_discord_token_here concord-dev sh -c 'cd test && ./racecond && ./rest && ./timeout && ./user-agent && ./websockets && ./queriec'
```

## Development Workflow

You can also use this environment for development by mounting your local source code:

```bash
docker run --rm -v $(pwd):/app concord-dev
```

This allows you to modify the source code locally and build/test within the consistent environment provided by the Docker container.