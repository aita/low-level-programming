section .data
test_string: db "abcdef", 0

section .text
global _start

strlen:
    xor rax, rax

.loop:
    cmp byte[rdi+rax], 0
    je .end
    inc rax
    jmp .loop

.end:
    ret

_start:
    mov rdi, test_string
    call strlen

    mov rdi, rax
    mov rax, 60
    syscall
