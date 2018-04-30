LD=ld
NASM=nasm

LDFLAGS=
NASMFLAGS=-felf64

PROGRAMS = mmap fact prime digitsum fib isfib

.SUFFIXES: .nasm

all: $(PROGRAMS)

mmap: mmap.o
	$(LD) $(LDFLAGS) $< -o $@

fact: fact.o
	$(LD) $(LDFLAGS) $< -o $@

prime: prime.o
	$(LD) $(LDFLAGS) $< -o $@

digitsum: digitsum.o
	$(LD) $(LDFLAGS) $< -o $@

fib: fib.o
	$(LD) $(LDFLAGS) $< -o $@

isfib: isfib.o
	$(LD) $(LDFLAGS) $< -o $@

.nasm.o:
	$(NASM) $(NASMFLAGS) $<

clean:
	rm -rf *.o *~ $(PROGRAMS)
