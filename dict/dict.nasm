section .text
global find_word

extern string_equals

    ; rdi = a pointer to a null-terminated string
    ; rsi = a pointer to a last element of a dict
find_word:
    xor rax, rax
.loop:
    test rsi, rsi
    jz .end
    push rdi
    push rsi
    lea rsi, [rsi + 8]
    call string_equals
    pop rsi
    pop rdi
    test rax, rax
    jnz .found
    mov rsi, [rsi]
    jmp .loop
.found:
    mov rax, rsi
.end:
    ret
