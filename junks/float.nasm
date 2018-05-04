section .data
pi: dq 1.0, 2.0, 3.0, 4.0

section .text
global func

func:
    ; push rbp
    ; mov rbp, rsp

    movupd xmm0, [rdi]
    movupd xmm1, [rdi]
    addpd xmm0, xmm1
    movupd [rdi], xmm0

    ; leave
    ret
