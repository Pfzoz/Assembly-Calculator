;nasm -f elf64 calculator.asm ; gcc -m64 -no-pie calculator.o -o calculator.x

extern scanf
extern printf

section .data
    str_format   : db "%s", 0
    ops_format   : db "%f %c %f", 0
    strIntro     : db "Insira os floats e a operação ('x' 'operação' 'y'): ", 10, 0
    strResult    : db "%f %c %f = %f", 10, 0
    strError     : db "%f %c %f = funcionalidade não disponível", 10, 0
    strStopper   : db "Stopper", 10, 0
    stopper      : db "%d"

section .bss
    f_A : resb 4
    f_B : resb 4
    error : resb 1
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

    cmp [c_operation], byte 'a'
    je to_sum

    cmp [c_operation], byte 's'
    je to_subtraction

    cmp [c_operation], byte 'm'
    je to_multiplication

    cmp [c_operation], byte 'd'
    je to_division

    cmp [c_operation], byte 'e'
    je to_exponentiation

    to_sum: ; soma
    mov [c_operation], byte '+'
    jmp end

    to_subtraction: ; subtração
    mov [c_operation], byte '-'
    jmp end

    to_multiplication: ; multiplicação
    mov [c_operation], byte '*'

    mov rdi, f_A
    mov rsi, f_B
    call multiplication
    
    mov [f_result], eax
    jmp write_file

    to_division: ; divisão
    mov [c_operation], byte '/'

    mov rdi, f_A
    mov rsi, f_B
    mov rdx, error
    call division

    cmp [error], byte 1
    je error_handle

    mov [f_result], eax
    jmp write_file

    to_exponentiation: ; exponenciação
    mov [c_operation], byte '^'

    mov rdi, f_A
    mov rsi, f_B
    mov rdx, error
    call exponentiation
    
    cmp [error], byte 1
    je error_handle

    mov [f_result], eax
    jmp write_file

    write_file: ; Escrita de arquivo resultado
    ; código teste ; (para verificação)
        mov rax, 3
        mov rdi, strResult
        mov rsi, [c_operation]
        cvtss2sd xmm0, [f_A]
        cvtss2sd xmm1, [f_B]
        cvtss2sd xmm2, [f_result]
        call printf
    ; fim código teste

    jmp end

    error_handle:
    ; código-teste ; (para verificação)
    mov rax, 2
    mov rdi, strError
    mov rsi, [c_operation]
    cvtss2sd xmm0, [f_A]
    cvtss2sd xmm1, [f_B]
    call printf
    ; fim código-teste
end:
    mov rsp, rbp
    pop rbp

    mov rax, 60
    mov rdi, 0
    syscall

%include "include/exponentiation.asm"
%include "include/multiplication.asm"
%include "include/division.asm"