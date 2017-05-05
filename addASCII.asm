;	MAIN

; 	addASCII

%include "io.mac"

.DATA
	intro 		db 	"CALCULADORA ", 0
	msg_ayuda 	db 	"Ingrese #ayuda para desplegar el menú de ayuda ", 0	
	sum_msg		db	'The sum is: ', 0
	number1		db	'0000000099'
	number2		db	'0000000002'
	sum		db	'          ', 0

		



.UDATA
	operation resb 	264
	base	resb	1
	digit	resb	4
	;sum	resb	10
	
	

.CODE
	.STARTUP
	pushfd	;Conservar el estado de todos los registros de 32bits
	
	mov	ESI, 9
	mov	ECX, 10
	clc

add_loop:
	;sub	AH, AH
	mov	AL, [number1+ESI]
	adc	AL, [number2+ESI]
	aaa
	pushf
	or	AL, 30h
	popf
	mov	[sum+ESI], AL
	dec	ESI
	loop	add_loop
	
	PutStr	sum_msg
	PutStr	sum
	nwln

	


SALIR:
	popfd
	.EXIT