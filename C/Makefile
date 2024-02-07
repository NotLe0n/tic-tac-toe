CC = gcc
CFLAGS = -Wall -Werror -pedantic -std=c90

FILE_NAME = tic-tac-toe
SRC_FILE = $(FILE_NAME).c

.PHONY: clean

all:
	$(CC) -o bin/$(FILE_NAME) $(SRC_FILE) $(CFLAGS)

clean:
	rm -rf bin/$(FILE_NAME)
