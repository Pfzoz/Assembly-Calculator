multiplication:
    push rbp
    mov rbp, rsp

    sub rsp, 4

    movss xmm0, [rdi]
    movss xmm1, [rsi]

    mulss xmm0, xmm1

    movss [rsp-4], xmm0
    mov eax, [rsp-4]

    mov rsp, rbp
    pop rbp
    ret