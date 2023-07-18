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

    ; Requisição de operandos
    xor rax, rax ; printf("%s", &strIntro)
    mov rdi, str_format
    mov rsi, strIntro
    call printf 

    ; Leitura dos operandos
    xor rax, rax ; scanf("%f %c %f", &f_A, &c_operation, &f_B)
    mov rdi, ops_format
    mov rsi, f_A
    mov rdx, c_operation
    mov rcx, f_B
    call scanf

    ; Identificação de operação

    to_sum: ; soma

    to_subtraction: ; subtração

    to_multiplication: ; multiplicação

    to_division: ; divisão

    to_exponentiation: ; exponenciação

    mov rdi, f_A
    mov rsi, f_B
    call exponenciacao
    
    mov [f_result], eax
    jmp write_file

    write_file: ; Escrita de arquivo resultado
    
end:
    mov rsp, rbp
    pop rbp

    mov rax, 60
    mov rdi, 0
    syscall

%include "include/exponentiation.asm"