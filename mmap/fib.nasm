%define O_RDONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2


section .data
fname: db 'input.txt', 0


section .text
global _start


%include "../iolib/lib.inc"


_start:
    ; call open
    mov rax, 2
    mov rdi, fname
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall

    ; call mmap
    mov r8, rax                 ; file descriptor
    mov rax, 9                  ; mmap
    mov rdi, 0
    mov rsi, 4096
    mov rdx, PROT_READ
    mov r10, MAP_PRIVATE
    mov r9, 0
    syscall

    mov rdi, rax
    call parse_uint

    xor rcx, rcx
    mov r8, 0                   ; a = 0
    mov r9, 1                   ; b = 1
.loop:
    cmp rcx, rax
    jae .end
    xchg r8, r9                 ; a, b = b, a
    add r9, r8                  ; b = b + a
    inc rcx
    jmp .loop

.end:
    mov rdi, r8
    call print_uint
    call print_newline

    ; exit(0)
    mov rax, 60
    xor rdi, rdi
    syscall
