section .data
newline_char: db 10
codes: db '0123456789ABCDEF'

test: dq -1

section .text
global _start

print_newline:
    mov rax, 1                  ; write
    mov rdi, 1                  ; stdout
    mov rsi, newline_char
    mov rdx, 1
    syscall
    ret


print_hex:
    mov rax, rdi
    mov rdi, 1
    mov rdx, 1
    mov rcx, 64
iterate:
    push rax
    sub rcx, 4                  ; rcx: 60, 56, 52, ... 4, 0
    sar rax, cl                 ; raxをclだけ右ローテート
    and rax, 0xf                ; 下位4bit以外クリア
    lea rsi, [codes + rax]

    mov rax, 1                  ; write
    push rcx
    syscall

    pop rcx
    pop rax
    test rcx, rcx
    jnz iterate

    ret


print_test:
    mov rdi, [test]
    call print_hex
    call print_newline
    ret

_start:
    call print_test

    mov byte[test], 1
    call print_test

    mov word[test], 1
    call print_test

    mov dword[test], 1
    call print_test

    mov qword[test], 1
    call print_test

    ; exit 0
    mov rax, 60
    xor rdi, rdi
    syscall
