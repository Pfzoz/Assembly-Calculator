write_ok:
    push rbp
    mov rbp, rsp

    mov rdi, fileName
    mov rsi, fileType

    call fopen

    mov [buf], rax

    mov rax, 3
    mov rdi, qword[buf]
    mov rsi, strResult
    mov rdx, [c_operation]
    cvtss2sd xmm0, [f_A]
    cvtss2sd xmm1, [f_B]
    cvtss2sd xmm2, [f_result]
    call fprintf

    mov rdi, qword[buf]
    call fclose

    mov rsp, rbp
    pop rbp
    ret




write_not_ok:
    push rbp
    mov rbp, rsp

    mov rdi, fileName
    mov rsi, fileType

    call fopen

    mov [buf], rax

    mov rax, 2
    mov rdi, qword[buf]
    mov rsi, strError
    mov rdx, [c_operation]
    cvtss2sd xmm0, [f_A]
    cvtss2sd xmm1, [f_B]
    call fprintf

    mov rdi, qword[buf]
    call fclose
    mov rsp, rbp
    pop rbp
    ret
