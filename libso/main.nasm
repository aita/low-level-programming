global _start
extern func

section .text
_start:
    mov rdi, 10
    call func

    ; exit
    mov rdi, rax
    mov rax, 60
    syscall
