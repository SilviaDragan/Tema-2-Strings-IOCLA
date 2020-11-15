%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

	mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

	push 	edx

	xor 	eax, eax
	xor 	ebx, ebx
	xor 	edx, edx

	mov 	eax, edi
	mov 	ebx, 26
	div 	ebx	
	
	xor 	ebx, ebx

	mov 	ebx, edx

each_letter:
	mov 	al, byte [esi + ecx - 1]
	
	cmp 	eax, 32
	je 		altceva

	cmp 	eax, 96
	jle 	could_be_uppercase
	cmp 	eax, 122
	jle 	could_be_lowercase

could_be_uppercase:

	cmp 	eax, 64
	jle 	altceva
	cmp 	eax, 90
	jg 		altceva

could_be_lowercase:

	add 	eax, ebx	
	cmp 	eax, 90
	jle 	is_upper
	cmp 	eax, 96
	jg 		is_upper

	sub 	eax, 91
	add 	eax, 'A'
	
	jmp 	altceva

is_upper:
	cmp 	eax, 122
	jle 	altceva
	
	sub 	eax, 123
	add 	eax, 'a'

	jmp 	altceva

altceva:

	pop 	edx
	
	mov 	[edx + ecx - 1], al	

	push 	edx

	xor 	edx, edx

	loop each_letter

	pop 	edx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
