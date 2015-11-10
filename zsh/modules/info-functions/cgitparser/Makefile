CC		:= clang

TARGET=cgitparser

SOURCES=$(wildcard *.c)
INCLUDES=

OBJECTS:=$(SOURCES:.c=.o)

CSTD?=c99
COPT=
CFLAGS=-std=$(CSTD) -Wall
CFLAGS+=$(COPT)
CFLAGS+=$(addprefix -I,$(INCLUDES))

LDFLAGS=-Wl

.PHONY: all test install
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(TARGET)
	rm -f $(OBJECTS)

%.o: %.c
	$(CC) -o $@ $(CFLAGS) $< -c

install: $(TARGET)
	echo "Nothing here yet"

clean:
	rm -f $(OBJECTS) $(TARGET)