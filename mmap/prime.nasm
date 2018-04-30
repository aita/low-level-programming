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

    mov r9, rax
    mov r8, 2
    xor rdx, rdx
    div r8
    mov r8, rax
    mov rcx, 2
.loop:
    cmp rcx, r8
    jae .prime
    mov rax, r9
    xor rdx, rdx
    div rcx
    test rdx, rdx
    jz .not_prime
    inc rcx
    jmp .loop

.prime:
    mov rax, 1
    jmp .end

.not_prime:
    mov rax, 0

.end:
    mov rdi, rax
    call print_uint
    call print_newline

    ; exit(0)
    mov rax, 60
    xor rdi, rdi
    syscall
