; float exponentiation( float op1, float op2)
; rdi => float A
; rsi => float B
exponentiation:
    ; stack-frame
    push rbp
    mov rbp, rsp

    sub rsp, 4 ; multiplicando

    mov [rdx], byte 0 ; nenhum erro

    ; pegando os floats
    movss xmm0, [rdi] ; xmm0 => float A
    movss xmm1, [rsi] ; xmm1 => float B

    ; Convert with Truncation from Single Scalar to Single Integer
    cvttss2si r10, xmm1

    ; utilizando xmm3 para guardar o multiplicador
    movss xmm3, xmm0

    ; xmm0 => multiplicando
    ; xmm3 => multiplicador 
    xor r12, r12
    cmp r10, 0
    je one_return
    jl negative_warn

    dec r10 ; Pois a primeira 'multiplicação' é o próprio número
    expo_loop: ; for (int r12 = 0; r12 < r10; r12++)
        cmp r12, r10
        jge expo_loop_end
        
        mulss xmm0, xmm3

        inc r12
        jmp expo_loop
    expo_loop_end:

    movss [rsp-4], xmm0
    mov rax, [rsp-4]

    mov rsp, rbp ; dealloc
    pop rbp ; de-stack-frame
    ret

    one_return:
    mov [rsp-4], dword 1
    cvtsi2ss xmm3, [rsp-4]
    movss [rsp-4], xmm3
    mov rax, [rsp-4]

    mov rsp, rbp ; dealloc
    pop rbp ; de-stack-frame
    ret

    negative_warn:
    mov [rdx], byte 1

    mov rsp, rbp
    pop rbp
    ret