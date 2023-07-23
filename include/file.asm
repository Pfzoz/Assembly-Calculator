write_ok:
    push rbp
    mov rbp, rsp

    mov rdi, fileName
    mov rsi, fileType
    call fopen

    mov rsp, rbp
    pop rbp
    ret




write_not_ok:
    push rbp
    mov rbp, rsp

    mov rsp, rbp
    pop rbp
    ret
