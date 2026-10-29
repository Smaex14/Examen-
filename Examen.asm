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
 ;peticion 1
;con eax=4 se llama al sistema sys_write (escribir datos) para imprimir en consola el mensaje 
;con eax=3 llama al sistema sys_read (leer datos) para capturar el número ingresado por el teclado 
	mov eax, 4 
	mov ebx, 1 
 	mov ecx, peticion 
 	mov edx, lenP
 	int 0x80 ;interrucion al sistema

 	mov eax, 3  
 	mov ebx, 0 ; codigo de retorno 0
 	mov ecx, num1
 	mov edx, 2
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
 	mov edx, 2
 	int 0x80

;multiplicacion
	mov eax, 4
	mov ebx, 1
 	mov ecx, Msgsalida
 	mov edx, lensalida
 	int 0x80

	mov al, [num1] ;movemos a la parte baja del registro ax el primer valor 
	sub al, 48 ; restamos 48 para obtener el valor numerico real del  ingreso
	mov bl, [num2] 
	sub bl, 48 
	mul bl	;multiplicamos el registro al por bl

;imprimir resultado
	mov ah, 0 ; movemos a ah un cero para limpiar el registro
	mov bl, 10 ; despues de realizar la multiplicacion ya no necesitamos bl 
	div bl	   ;asi que lo volvemos a reutilzar moviendo un 10 para realizar la division
	add al, 48 ; sumamos un 48 para obtener nuevamente el valor ascii
	add ah, 48
	mov [resultado], al ;movemos a la dirreccion de memoria el valor de las decenas
	mov [resultado+1], ah ; movemos a la direccion+1  guardar las unidades

	mov eax, 4
	mov ebx, 1
 	mov ecx, resultado
 	mov edx, 2
 	int 0x80

	mov eax, 1 ;llamada al sistema sys_exit(salida)
	mov ebx, 0
 	int 0x80 