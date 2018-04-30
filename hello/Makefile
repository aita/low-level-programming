LD=ld
NASM=nasm

LDFLAGS=
NASMFLAGS=-felf64

PROGRAMS=hello false mappings_loop endianness \
	print_call print_one print_rax

.SUFFIXES: .nasm

all: $(PROGRAMS)

hello: hello.o
	$(LD) $(LDFLAGS) $< -o $@
false: false.o
	$(LD) $(LDFLAGS) $< -o $@
mappings_loop: mappings_loop.o
	$(LD) $(LDFLAGS) $< -o $@
endianness: endianness.o
	$(LD) $(LDFLAGS) $< -o $@
print_call: print_call.o
	$(LD) $(LDFLAGS) $< -o $@
print_one: print_one.o
	$(LD) $(LDFLAGS) $< -o $@
print_rax: print_rax.o
	$(LD) $(LDFLAGS) $< -o $@


.nasm.o:
	$(NASM) $(NASMFLAGS) $<

clean:
	rm -rf *.o *~ $(PROGRAMS)
