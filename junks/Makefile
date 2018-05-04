LD=ld
NASM=nasm

LDFLAGS=
NASMFLAGS=-felf64

PROGRAMS=hello float
SRCS = $(wildcard ./*$(SUFFIX))
OBJS = $(SRCS:$(SUFFIX)=.o)

all: $(PROGRAMS)
hello: hello.o
float: float_main.o float.o

.SUFFIXES: .nasm
.nasm.o:
	$(NASM) $(NASMFLAGS) $<

clean:
	rm -rf *.o *~ $(PROGRAMS)
