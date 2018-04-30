LD=ld
NASM=nasm

LDFLAGS=
NASMFLAGS=-felf64

PROGRAMS = mmap fact

.SUFFIXES: .nasm

all: $(PROGRAMS)

mmap: mmap.o
	$(LD) $(LDFLAGS) $< -o $@

fact: fact.o
	$(LD) $(LDFLAGS) $< -o $@

.nasm.o:
	$(NASM) $(NASMFLAGS) $<

clean:
	rm -rf *.o *~ $(PROGRAMS)
