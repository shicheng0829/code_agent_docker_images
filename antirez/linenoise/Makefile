linenoise_example: linenoise.h linenoise.c

linenoise_example: linenoise.c example.c
	$(CC) -Wall -W -Os -g -o linenoise_example linenoise.c example.c

clean:
	rm -f linenoise_example

test: linenoise_example
	@echo "Testing if executable exists..."
	@test -x linenoise_example && echo "Test passed: linenoise_example is executable"
