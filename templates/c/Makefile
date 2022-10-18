CC ?= gcc
CFLAGS ?= -Wall -Wextra -std=c99 -pedantic -Wvla
LDFLAGS ?=

OBJS =
MAIN_OBJ = main.o

BIN = hello

all: $(BIN)

$(BIN): $(OBJS) $(MAIN_OBJ)
	$(CC) $(LDFLAGS) -o $(BIN) $(OBJS) $(MAIN_OBJ)

clean:
	$(RM) $(BIN) $(OBJS) $(MAIN_OBJ)

.PHONY: all $(BIN) clean
