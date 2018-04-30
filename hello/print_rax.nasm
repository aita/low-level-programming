section .data
codes: db '0123456789ABCDEF'


section .text
global _start
_start:
    mov rax, 0x0122334455667788 ; 16文字

    mov rdi, 1                  ; stdout
    mov rdx, 1                  ; 1 byte
    mov rcx, 64                 ; 16 * 4

.loop:
    push rax
    sub rcx, 4

    ; rax > eax > ax = (ah + al)
    ; rcx > ecx > cx = (ch + cl)
    sar rax, cl                 ; 算術右シフト
    and rax, 0xf                ; 下位4bitのみ残す

    lea rsi, [codes + rax]      ; ポインタの指定
    mov rax, 1                  ; write

    ; syscallでrcxとr11が変更される
    push rcx
    syscall
    pop rcx

    pop rax
    test rcx, rcx
    jnz .loop                   ; rcx != 0 なら .loop にジャンプ

    ; exit 0
    mov rax, 60
    xor rdi, rdi
    syscall
