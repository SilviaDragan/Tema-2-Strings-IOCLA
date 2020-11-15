%include "io.mac"

section .text
    global bin_to_hex
    extern printf

section .data
    hexa_value dd 0
    values: db '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
    contor dd 0
    contor_hexa_value dd 0
    length dd 0
    sum dd 0
    start_4 dd 0

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

	mov     eax, 0

    mov     [contor], eax
    mov     [sum], eax
    mov     [length], ecx
    mov     [hexa_value], edx
    mov     [contor_hexa_value], eax

    xor     edx, edx

    mov     al, cl
    mov     bl, byte 4

    div     bl

    mov bl, ah

    mov [start_4], bl

    cmp     bl, 0
    je      final_for

    sub     bl, 1

    xor     eax, eax
    xor     ecx, ecx
    xor     edx, edx

for:
    mov     eax, [contor]
    mov     cl, [esi + eax]

    cmp     cl, 48
    je      is_zero

    mov     edx, ebx
    sub     edx, eax

    mov     ecx, 1
    
    cmp     dl, 3
    jne     shift_two_times
    shl     ecx, 3
    jmp     shifted

shift_two_times:
    cmp     dl, byte 2 
    jne     shift_one_time
    shl     ecx, 2
    jmp     shifted

shift_one_time:
    cmp     dl, byte 1
    jne     dont_shift
    shl     ecx, 1
    jmp     shifted

dont_shift:

shifted:
    
    mov     edx, [sum]
    add     edx, ecx

is_zero:    

    mov     [sum], edx

    add     eax, 1
    mov     [contor], eax


    cmp     al, bl
    jle     for

    mov     ecx, [sum]

    mov     cl, [values + ecx]

    xor     edx, edx

    mov     dl, [contor_hexa_value]

    mov     ebx, [hexa_value]

    mov     [ebx], byte cl

    inc     edx
    mov     [contor_hexa_value], edx
    

final_for:


mata:

for_four:

    xor     edx, edx

    mov     ebx, [start_4]
    mov     ecx, 0
    

    mov     eax, [esi + ebx]
    cmp     al, 48
    je      next1
    mov     ecx, 1
    shl     ecx, 3

next1:
    
    add     edx, ecx

    ;PRINTF32 `EDX1 %u\n\x0`, edx

    mov     ecx, 0

    mov     eax, [esi + ebx + 1]
    cmp     al, 48
    je      next2
    mov     ecx, 1
    shl     ecx, 2

next2:

    add     edx, ecx

    ;PRINTF32 `EDX2 %u\n\x0`, edx


    mov     ecx, 0

    mov     eax, [esi + ebx + 2]
    cmp     al, 48
    je      next3
    mov     ecx, 1
    shl     ecx, 1

next3:

    add     edx, ecx

    ;PRINTF32 `EDX3 %u\n\x0`, edx


    mov     ecx, 0

    mov     eax, [esi + ebx + 3]
    cmp     al, 48
    je      next4
    mov     ecx, 1
    shl     ecx, 0

next4:

    add     edx, ecx

    mov     edx, [values + edx]

    xor     ebx, ebx
    xor     ecx, ecx
    
    mov     cl, [contor_hexa_value]

    mov     ebx, [hexa_value]

    mov     [ebx + ecx], dl

    inc     ecx
    mov     [contor_hexa_value], ecx

    mov     ebx, [start_4]
    add     ebx, 4

    mov     [start_4], ebx

    mov     ecx, [length]

    cmp     ebx, ecx
    jge     out
    jl      for_four

out:



    mov     eax, [contor_hexa_value]

    mov     edx, [hexa_value]
    mov     ebx, [length]

    mov     byte [edx + eax], 0x0A


    ;; TODO: Implement bin to hex

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
