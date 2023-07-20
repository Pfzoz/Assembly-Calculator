division:
    push rbp
    mov rbp, rsp

    sub rsp, 4

    movss xmm0, [rdi]
    movss xmm1, [rsi]

    mov [rdx], byte 0
    mov [rsp-4], dword 0
    cvtsi2ss xmm3, [rsp-4]

    comiss xmm1, xmm3 ; verificação de possíveis erros da divisão
    jp unknown_error
    je division_by_zero

    divss xmm0, xmm1

    movss [rsp-4], xmm0
    mov eax, [rsp-4]

    jmp division_end

    unknown_error:

    mov [rdx], byte 1
    jmp division_end

    division_by_zero:

    mov [rdx], byte 1
    jmp division_end

    division_end:

    mov rsp, rbp
    pop rbp
    ret