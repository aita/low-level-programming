LD=ld
NASM=nasm

LDFLAGS=
NASMFLAGS=-felf64

PROGRAMS=main

.SUFFIXES: .nasm

all: main

main: symbols.o executable_object.o
	$(LD) $(LDFLAGS) $^ -o $@

.nasm.o:
	$(NASM) $(NASMFLAGS) $<

clean:
	rm -rf *.o *~ $(PROGRAMS)
