section .data
    userMsg db 'Please enter a Filename (please use Ctrl+D; DO NOT use ENTER or RETURN!): '
    lenuserMsg  equ $-userMsg
    asms db `section .data\nsection .bss\nsection .text\n\tglobal _start\nstart:`
    lenasms equ $-asms
    msg_done db 0xA, 0xA, 'Done writing to File', 0xA
    msgdlen equ $-msg_done

section .bss
    fn resw 1
    fd_out resb 1
    fd_in resb 1
section .text
    global _start

_start:
loop:
    ; prompt the User to enter the filename
    mov eax, 4
    mov ebx, 1
    mov ecx, userMsg
    mov edx, lenuserMsg
    int 80h

    ; read the filename
    mov eax, 3
    mov ebx, 0
    mov ecx, fn
    mov edx, 30
    int 80h

    ; create the file
    mov eax, 8
    mov ebx, fn
    mov ecx, 0o755
    int 80h

    mov [fd_out], eax ; make the created file useable by storing the file descriptor

    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, asms
    mov edx, lenasms
    int 80h

    ; close file
    mov eax, 6
    mov ebx, [fd_out]
    int 80h

    ; report the operation has finished
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_done
    mov edx, msgdlen
    int 80h

    ; open file to read
    mov eax, 5
    mov ebx, fn
    mov ecx, 0
    mov edx, 0o777
    int 80h

    mov [fd_in], eax ; create new file descriptor

    ; read the contents of the file
    mov eax, 3
    mov ebx, [fd_in]
    mov ecx, asms
    mov edx, lenasms
    int 80h

    ; print the contents
    mov eax, 4
    mov ebx, 1
    mov ecx, asms
    mov edx, lenasms
    int 80h

    ; close the file
    mov eax, 6
    mov ebx, [fd_in]
    int 80h

    ; exit
    mov eax, 1
    int 80h