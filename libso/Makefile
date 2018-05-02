LD=ld
NASM=nasm

LDFLAGS=
NASMFLAGS=-felf64

PROGRAM=main

.SUFFIXES: .nasm

all: main

$(PROGRAM): main.o libso.so
	$(LD) $(LDFLAGS) -o $@ $< -d libso.so --dynamic-linker=/lib64/ld-linux-x86-64.so.2

libso.so: libso.o
	$(LD) -shared -o $@ $^


.nasm.o:
	$(NASM) $(NASMFLAGS) $<

clean:
	rm -rf *.o *~ $(PROGRAM) libso.so
