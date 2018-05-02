section .text
global string_length
global print_char
global print_newline
global print_string
global print_error
global print_uint
global print_int
global string_equals
global parse_uint
global parse_int
global read_word
global string_copy
global exit


string_length:
    xor rax, rax
.loop:
    cmp byte[rdi + rax], 0
    je .end
    inc rax
    jmp .loop
.end:
    ret

print_string:
    push rdi
    call string_length
    pop rsi
    mov rdx, rax                ; length
    mov rdi, 1                  ; stdout
    mov rax, 1                  ; write
    syscall
    ret

print_error:
    push rdi
    call string_length
    pop rsi
    mov rdx, rax                ; length
    mov rdi, 2                  ; stderr
    mov rax, 1                  ; write
    syscall
    ret

print_newline:
    mov rdi, 10

print_char:
    push rdi
    mov rax, 1                  ; write
    mov rsi, rsp
    mov rdi, 1                  ; stdout
    mov rdx, 1
    syscall
    pop rdi
    ret

print_int:
    test rdi, rdi
    jns print_uint
    push rdi
    mov rdi, '-'
    call print_char
    pop rdi
    neg rdi

print_uint:
    mov rax, rdi
    mov rdi, rsp
    ; バッファを確保 (xxxxxx00)
    sub rsp, 24
    dec rdi                     ; ポインタを末尾に移動
    mov byte[rdi], 0            ; NUL
    mov r8, 10
.loop:
    xor rdx, rdx              ; rdx = 0
    div r8                    ; rax = rdx:rax / 10, rdx = rdx:rax % 10
    or dl, 0x30               ; 剰余から文字コードを計算
    dec rdi                   ; ポインタを移動
    mov byte[rdi], dl
    test rax, rax
    jnz .loop
    call print_string
    add rsp, 24                 ; バッファを廃棄
    ret

    ; rdi = s1
    ; rsi = s2
string_equals:
    mov al, byte[rdi]           ; $al = *s1
    cmp al, byte[rsi]           ; if *s1 != *s2
    jne .not_equal
    inc rdi                     ; s1++
    inc rsi                     ; s2++
    test al, al                 ; if $al != '\0'
    jne string_equals
    mov rax, 1
    ret
.not_equal:
    mov rax, 0
    ret

read_char:
    push 0
    xor rax, rax                ; read
    xor rdi, rdi                ; stdin
    mov rsi, rsp
    mov rdx, 1
    syscall
    pop rax
    ret

read_word:
    push r12                    ; calle-saved
    push r13                    ; calle-saved
    mov r12, rsi
    xor r13, r13

    ; skip whitespace characters
.skip:
    push rdi
    call read_char
    pop rdi

    cmp al, 0x20                ; SPACE
    je .skip
    cmp al, 0x09                ; TAB
    je .skip
    cmp al, 0x0A                ; LF
    je .skip
    cmp al, 0x0D                ; CF
    je .skip
    test al, al                 ; NUL
    jz .end

    ; read until whitespace characters
.loop:
    mov byte[rdi + r13], al
    inc r13

    push rdi
    call read_char
    pop rdi

    cmp al, 0x20                ; SPACE
    je .end
    cmp al, 0x09                ; TAB
    je .end
    cmp al, 0x0A                ; LF
    je .end
    cmp al, 0x0D                ; CF
    je .end
    test al, al                 ; NUL
    jz .end

    cmp r12, r13
    jne .loop

    ; buffer is too short
    xor rax, rax
    pop r13
    pop r12
    ret

.end:
    mov byte[rdi + r13], 0
    mov rax, rdi
    mov rdx, r13
    pop r13
    pop r12
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_uint:
    mov r8, 10
    xor rax, rax
    xor rcx, rcx
.loop:
    movzx r9, byte[rdi + rcx]
    cmp r9b, '0'
    jb .end
    cmp r9b, '9'
    ja .end
    sub r9b, 0x30
    xor rdx, rdx
    mul r8
    add rax, r9
    inc rcx
    jmp .loop
.end:
    mov rdx, rcx
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_int:
    mov al, byte[rdi]
    cmp al, '-'
    jne parse_uint
    inc rdi
    call parse_uint
    test rdx, rdx
    jz .error
    neg rax
    inc rdx
    ret
.error:
    xor rax, rax
    ret

    ; rdi = source pointer
    ; rsi = buffer pointer
    ; rdx = buffer length
string_copy:
    push rdi
    push rsi
    push rdx
    call string_length
    pop rdx
    pop rsi
    pop rdi

    cmp rax, rdx
    jae .too_long

    push rsi
.loop:
    mov al, [rdi]
    mov byte[rsi], al
    inc rdi
    inc rsi
    test al, al
    jnz .loop
    pop rax
    ret

.too_long:
    xor rax, rax
    ret

exit:
    mov rax, 60                 ; exit
    syscall
