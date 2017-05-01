;	MAIN

; 	powASCII

%include "io.mac"

.DATA
	intro 		db 	"CALCULADORA ", 0
	msg_ayuda 	db 	"Ingrese #ayuda para desplegar el menú de ayuda ", 0	
	sum_msg		db	'The sum is: ', 0
	ocho1		db	'0000000008'
	ocho2		db	'0000000008'
	potencia	db	'          ', 0


.UDATA
	operation resb 	264
	base	resb	1
	digit	resb	4
	;sum	resb	10
	
	

.CODE
	.STARTUP
	pushfd	;Conservar el estado de todos los registros de 32bits


	mov	BH, 2

sum_loop_1:
	mov	BL, 8
sum_loop:
	mov	ESI, 9
	mov	ECX, 10
	clc
add_loop:
	mov	AL, [ocho1+ESI]
	adc	AL, [ocho2+ESI]
	aaa
	pushf
	or	AL, 30h
	popf
	mov	[potencia+ESI], AL
	dec	ESI
	loop	add_loop
	;mov	[potencia+ESI], 
	;PutStr	sum_msg
	;PutStr	potencia
	nwln
	

	cmp	BL, 2
	je	Repetir
	dec	BL
	
	
nwln
	mov	ECX, 0
	push	EDX
mover_operando:
	
	
	
	mov	DL, byte[potencia+ECX]
	mov	byte[potencia+ECX],  ' '
	;PutCh	DL
	;nwln
	mov	byte[ocho1+ECX], DL
	;sub	[potencia], ECX
	
	;PutStr	number1
	;nwln
	inc	CX
	cmp	CX, 10
	je	salir_mover_operandos
	jmp	mover_operando

salir_mover_operandos:
	pop 	EDX
	jmp	sum_loop




	
Repetir:
	
	cmp	BH, 2
	je	SALIR
	dec	BH
	mov	ECX, 0
mover_operandos_2:

	push	EDX
	mov	DL, byte[potencia+ECX]
	mov	byte[potencia+ECX],  ' '
	mov	byte[ocho1+ECX], DL
	mov	byte[ocho2+ECX], DL

	PutStr	ocho1
	nwln
	PutStr	ocho2

	inc	CX
	cmp	CX, 10
	je	salir_mover_operandos_2
	jmp	mover_operandos_2

salir_mover_operandos_2:
	pop EDX
	jmp	sum_loop_1


SALIR:
	popfd
	.EXIT