section .data
    filename db '/home/nathan/Downloads/CVAP_2019-2023_ACS_csv_files/Tract.csv', 0     ; filename to read
    newline db 10                  ; newline character
    err_msg db 'Error opening file', 10
    err_len equ $ - err_msg
    time_msg db 'Total time (nanoseconds): '
    time_len equ $ - time_msg
    lines_msg db 'Total lines: '
    lines_len equ $ - lines_msg

section .bss
    fd resq 1                      ; file descriptor
    buffer resb 1024                ; buffer for reading
    start_time resq 2               ; start time (timespec structure)
    end_time resq 2                 ; end time (timespec structure)
    line_count resq 1               ; line count

section .text
    global _start

_start:
    ; Get start time
    mov rax, 228                   ; syscall for clock_gettime
    mov rdi, 7                     ; CLOCK_MONOTONIC
    mov rsi, start_time            ; store time in start_time
    syscall

    ; Open file
    mov rax, 2                     ; open syscall
    mov rdi, filename              ; filename
    mov rsi, 0                     ; read-only mode
    xor rdx, rdx                   ; no special flags
    syscall

    cmp rax, 0                     ; check if file opened successfully
    jl error_open

    mov [fd], rax                  ; save file descriptor

    ; Initialize line count
    mov qword [line_count], 0

read_loop:
    ; Read from file
    mov rax, 0                     ; read syscall
    mov rdi, [fd]                  ; file descriptor
    mov rsi, buffer                ; buffer
    mov rdx, 1024                  ; buffer size
    syscall

    test rax, rax                  ; check if read returned 0 (EOF)
    jle close_file

    ; Count lines in buffer
    mov rcx, rax                   ; set counter to bytes read
    mov rsi, buffer                ; point to buffer start
    xor rbx, rbx                   ; clear line count for this iteration

count_lines:
    cmp byte [rsi], 10              ; check for newline
    jne skip_line
    inc qword [line_count]          ; increment total line count
    inc rbx                         ; increment lines in this iteration

skip_line:
    inc rsi                         ; move to next byte
    dec rcx                         ; decrement counter
    jnz count_lines

    jmp read_loop                   ; continue reading

close_file:
    ; Close file
    mov rax, 3                     ; close syscall
    mov rdi, [fd]                  ; file descriptor
    syscall

    ; Get end time
    mov rax, 228                   ; syscall for clock_gettime
    mov rdi, 7                     ; CLOCK_MONOTONIC
    mov rsi, end_time              ; store time in end_time
    syscall

    ; Calculate time difference (nanoseconds)
    ; Seconds to nanoseconds
    mov rax, [end_time]            ; end seconds
    mov rbx, [start_time]          ; start seconds
    sub rax, rbx
    mov rcx, 1000000000            ; seconds to nanoseconds
    mul rcx

    ; Add nanoseconds part
    mov rbx, [end_time + 8]        ; end nanoseconds
    mov rcx, [start_time + 8]      ; start nanoseconds
    sub rbx, rcx
    add rax, rbx                   ; total nanoseconds

    ; Print time
    push rax                       ; save time value
    mov rax, 1                     ; write syscall
    mov rdi, 1                     ; stdout
    mov rsi, time_msg              ; time message
    mov rdx, time_len              ; message length
    syscall

    ; Convert time to string and print
    pop rax                        ; restore time value
    call print_number

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Print lines message
    mov rax, 1
    mov rdi, 1
    mov rsi, lines_msg
    mov rdx, lines_len
    syscall

    ; Print line count
    mov rax, [line_count]
    call print_number

    ; Exit program
    mov rax, 60                    ; exit syscall
    xor rdi, rdi                   ; exit code 0
    syscall

error_open:
    ; Print error message
    mov rax, 1                     ; write syscall
    mov rdi, 2                     ; stderr
    mov rsi, err_msg               ; error message
    mov rdx, err_len               ; message length
    syscall

    ; Exit with error
    mov rax, 60                    ; exit syscall
    mov rdi, 1                     ; exit code 1
    syscall

; Print number in RAX
print_number:
    ; Convert number to string on stack
    push rbp
    mov rbp, rsp
    sub rsp, 32                    ; allocate space for string
    
    mov rcx, 10                    ; divisor
    mov rdi, rsp                   ; destination for string
    
convert_loop:
    xor rdx, rdx                   ; clear rdx for division
    div rcx                        ; divide RAX by 10
    add rdx, '0'                   ; convert remainder to ASCII
    dec rdi                        ; move back in buffer
    mov [rdi], dl                  ; store digit
    test rax, rax                  ; check if quotient is zero
    jnz convert_loop

    ; Print converted number
    mov rax, 1                     ; write syscall
    mov rsi, rdi                   ; string to print
    mov rdx, rbp                   ; calculate string length
    sub rdx, rsi
    mov rdi, 1                     ; stdout
    syscall

    ; Restore stack and return
    mov rsp, rbp
    pop rbp
    ret