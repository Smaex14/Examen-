section .data
 	peticion db "Ingrese un numero entre 0 y 9:",0xA,0xD
 	lenP equ $ - peticion
 	outMsg db "El resultado  de la suma es:",0xA,0xD
 	lenout equ $ - outMsg
 	

section .bss
	num1 resb 5
	num2 resb 5
	resultado resb 5
 section .text

 global _start

 _start:
 ;peticion 1
	mov eax, 4
	mov ebx, 1
 	mov ecx, peticion
 	mov edx, lenP
 	int 0x80

 	mov eax, 3
 	mov ebx, 0
 	mov ecx, num1
 	mov edx, 5
 	int 0x80

;peticion 2
	mov eax, 4
	mov ebx, 1
 	mov ecx, peticion
 	mov edx, lenP
 	int 0x80

 	mov eax, 3
 	mov ebx, 0
 	mov ecx, num2
 	mov edx, 5
 	int 0x80
;suma
	mov eax, 4
	mov ebx, 1
 	mov ecx, outMsg
 	mov edx, lenout
 	int 0x80

	mov al, [num1]
	sub al, 48
	mov bl, [num2]
	sub bl, 48 
	add al, bl
	mov ah, 0
	mov bl, 10
	div bl
	add al, 48
	add ah, 48
	mov [resultado], al
	mov [resultado + 1], ah

	mov eax, 4
	mov ebx, 1
 	mov ecx, resultado
 	mov edx, 2
 	int 0x80

	mov eax, 1
	mov ebx, 0
 	int 0x80