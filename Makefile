CFLAGS=-Wall -O3 -I.
LDFLAGS=-lm -lz

DEPS = JSON_checker.h
OBJ = JSON_checker.o json2gelf.o

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
## brew install argp-standalone
	ARGP_VSN=1.5.0
    CFLAGS+=-I/usr/local/Cellar/argp-standalone/$(ARGP_VSN)/include
	LDFLAGS+=/usr/local/Cellar/argp-standalone/$(ARGP_VSN)/lib/libargp.a
endif

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<

json2gelf: $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f *.o json2gelf
