extern scanf
extern printf

section .data
    str_format     : db "%s", 0
    ops_format : db "%f %c %f", 0
    strIntro   : db "Insira os floats e a operação (x operação y): ", 10, 0
    strResultado : db "Resultado = %f", 10, 0
    strStopper : db "Stopper", 10, 0
    stopper    : db "%d"

section .bss
    f_A : resb 4
    f_B : resb 4
    f_result : resb 4
    c_operation : resb 1

section .text
    global main

main:    
    push rbp
    mov rbp, rsp

    xor rax, rax
    ; printf("%s", &strIntro)
    mov rdi, str_format
    mov rsi, strIntro
    call printf 

    xor rax, rax
    ; scanf("%f %c %f", &f_A, &c_operation, &f_B)
    mov rdi, ops_format
    mov rsi, f_A
    mov rdx, c_operation
    mov rcx, f_B
    call scanf

    mov rdi, f_A
    mov rsi, f_B
    call exponenciacao
    

    mov [f_result], eax
    
    fim_expo:
    mov rax, 1
    mov rdi, strResultado
    cvtss2sd xmm0, [f_result]
    
    ; mov rsi, f_result
    call printf

    ; _stopper:
    ; mov rdi, strStopper
    ; call printf
    ; mov rdi, stopper
    ; call scanf
    
end:
    mov rsp, rbp
    pop rbp

    mov rax, 60
    mov rdi, 0
    syscall

%include "include/exponentiation.asm"