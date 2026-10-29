;Aquí se definen las constantes de texto y se calculan sus longitudes
;En la sección bss, se reservan 2 bytes para cada variable numérica, uno para el carácter y otro para el salto de línea 

section .data
 	peticion db "Ingrese un numero entre 0 y 9:",0xA,0xD
 	lenP equ $ - peticion
 	Msgsalida db "El resultado de la multiplicacion es:",0xA,0xD
 	lensalida equ $ - Msgsalida
 	
section .bss
	num1 resb 2
	num2 resb 2
	resultado resb 2

 section .text
 global _start
 _start:
;INGRESO 1
;se configuran los registros para invocar las llamadas al sistema 
;con eax=4 se llama al sistema sys_write (escribir datos) para imprimir en consola el mensaje, ebx=1 para pasar datos de la memoria a la consola 
;con eax=3 llama al sistema sys_read (leer datos) para capturar el número ingresado por el teclado,ebx=0 para pasar datos del usuario a la memoria 
	mov eax, 4 
	mov ebx, 1 
 	mov ecx, peticion 
 	mov edx, lenP
 	int 0x80 

 	mov eax, 3  
 	mov ebx, 0 
 	mov ecx, num1
 	mov edx, 2
 	int 0x80

;INGRESO 2
	mov eax, 4
	mov ebx, 1
 	mov ecx, peticion
 	mov edx, lenP
 	int 0x80

 	mov eax, 3
 	mov ebx, 0
 	mov ecx, num2
 	mov edx, 2
 	int 0x80

;MULTIPLICACIÓN 
;se mueven los valores de la memoria a los registros de la CPU y restamos 48 para obtener el valor numerico real del  ingreso
;se mueve a la parte baja del registro ax el primer valor
	mov eax, 4
	mov ebx, 1
 	mov ecx, Msgsalida
 	mov edx, lensalida
 	int 0x80

	mov al, [num1]  
	sub al, 48 
	mov bl, [num2] 
	sub bl, 48 
	mul bl	;multiplicamos el registro al por bl

; IMPRIMIR RESULTADO
;dividimos entre 10 para separar las decenas y unidades, el cociente(decenas) queda en al y el residuo(unidades) en ah
;se observan en pantalla con sys_write, y el programa se cierra correctamente mediante sys_exit (eax=1) 
	mov ah, 0 
	mov bl, 10 
	div bl	  
	add al, 48 
	add ah, 48
	mov [resultado], al 
	mov [resultado+1], ah 

	mov eax, 4
	mov ebx, 1
 	mov ecx, resultado
 	mov edx, 2
 	int 0x80

	mov eax, 1 
	mov ebx, 0
 	int 0x80 