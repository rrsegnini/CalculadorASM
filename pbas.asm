;	MAIN

; 	CONVERTER

%include "io.mac"

.DATA
	intro 		db 	"CALCULADORA ", 0
	msg_ayuda 	db 	"Ingrese #ayuda para desplegar el menú de ayuda ", 0	
	sum_msg		db	'The sum is: ', 0
	number1		db	'0000000008'
	number2		db	'0000000008'
	sum		db	'          ', 0

		



.UDATA
	operation resb 	264
	base	resb	1
	digit	resb	4
	;sum	resb	10
	
	

.CODE
	.STARTUP
	pushfd	;Conservar el estado de todos los registros de 32bits

	mov	BL, 3
sum_loop:
	mov	ESI, 9
	mov	ECX, 10
	clc
add_loop:
	mov	AL, [number1+ESI]
	adc	AL, [number2+ESI]
	aaa
	pushf
	or	AL, 30h
	popf
	mov	[sum+ESI], AL
	dec	ESI
	loop	add_loop
	;mov	[sum+ESI], 
	;PutStr	sum_msg
	;PutStr	sum
	nwln
	

	cmp	BL, 1
	je	SALIR
	dec	BL
	
	push	ECX	;Para conservar el ECX
	;PutStr	sum
nwln
	mov	ECX, [sum]
	mov	ECX, 0
	mov	[number1], ECX
	sub	[sum], ECX
	PutStr	number1
	nwln

	pop	ECX
	jmp	sum_loop

	
	
	


SALIR:
	popfd
	.EXIT