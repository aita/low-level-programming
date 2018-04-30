global _start

section .data
message: db 'hello world', 10


section .text
_start:
    mov rax, 1                  ; write
    mov rdi, 1                  ; stdout
    mov rsi, message            ; 文字列へのポインタ
    mov rdx, 12                 ; 14 bytes
    syscall

    mov rax, 60                 ; exit
    xor rdi, rdi                ; 0
    syscall
