section .text
%include "colon.inc"

extern find_word

extern read_word
extern string_length
extern print_string
extern print_error
extern exit

global _start


section .rodata
message: db 'hello world', 10
key: db 'second', 0


not_found_msg: db "no such word", 10

%include "words.inc"


section .text
_start:
    push rbp
    mov rbp, rsp
    sub rsp, 256

    mov rdi, rsp
    mov rsi, 256
    call read_word

    mov rdi, rax
    mov rsi, head
    call find_word
    test rax, rax
    jz .error

    push rax
    lea rdi, [rax + 8]
    call string_length
    pop rdi
    lea rdi, [rdi + rax + 8 + 1]
    call print_string

.exit:
    leave
    ;  exit
    xor rdi, rdi
    call exit

.error:
    mov rdi, not_found_msg
    call print_error

    jmp .exit
