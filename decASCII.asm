;	MAIN

; 	decASCII

%include "io.mac"

.DATA
	intro 		db 	"CALCULADORA ", 0
	msg_ayuda 	db 	"Ingrese #ayuda para desplegar el menú de ayuda ", 0	
	sum_msg		db	'The sub is: ', 0
	number1		db	'0000000099'
	uno_dec		db	'0000000001'
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
	sub	AH, AH
	mov	AL, [number1+ESI]
	sub	AL, [uno_dec+ESI]
	aas
	pushf
	or	AL, 30h
	popf
	mov	[sum+ESI], AL
	dec	ESI
	loop	add_loop
	
	PutStr	sum_msg
	PutStr	sum
	nwln

	mov	ECX, 0
mover_operando_dec:
	
	
	push	EDX
	mov	DL, byte[sum+ECX]
	mov	byte[sum+ECX],  ' '
	;PutCh	DL
	;nwln
	mov	byte[number1+ECX], DL
	;sub	[sum], ECX
	
	inc	CX
	cmp	CX, 10
	je	salir_mover_operando_dec
	jmp	mover_operando_dec

salir_mover_operando_dec:
	pop 	EDX

	

	popfd
	.EXIT