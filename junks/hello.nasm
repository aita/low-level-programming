extern printf

section .text
global main

main:
    call hello
    xor rax, rax
    ret

hello:
section .data
    message: db `hello world\n`
section .text
    lea rdi, [message]
    call printf
    ret
