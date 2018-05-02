LD=ld
NASM=nasm

LDFLAGS=
NASMFLAGS=-felf64

PROGRAM = dict
SUFFIX=.nasm
SRCS = $(wildcard ./*$(SUFFIX))
OBJS = $(SRCS:$(SUFFIX)=.o)

.SUFFIXES: .nasm

all: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

main.o: main.nasm colon.inc

.nasm.o:
	$(NASM) $(NASMFLAGS) $<

clean:
	rm -rf *.o *~ $(PROGRAM)
