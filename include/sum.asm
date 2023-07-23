sum:
    push rbp
    mov rbp, rsp
    
    movss xmm0, [rdi]
    movss xmm1, [rsi]
    
    addss xmm0, xmm1

    mov rsp, rbp
    pop rbp
    ret
