;	MAIN

; 	CONVERTER

%include "io.mac"
%include "b_h.mac"

.DATA
	intro 		db 	"CALCULADORA ", 0
	msg_ayuda 	db 	"Ingrese #ayuda para desplegar el menú de ayuda ", 0	
	sum_msg		db	'The sum is: ', 0
	number1		db	'0000000000', 0
	number2		db	'0000000000', 0
	uno_dec		db	'0000000000'	;Para decrementar
	sum		db	'          ', 0
	ocho1		db	'0000000008'
	ocho2		db	'0000000008'
	potencia	db	'0000000000', 0
	sum2		db	'          ', 0
	contador	dw	0
	total		db	'0000000000', 0
	final		dd	0
	cont_op		dw	0

		



.UDATA
	operation resb 	264
	base	resb	1
	digit	resb	4

	
	

.CODE
	.STARTUP
	;pushfd	;Conservar el estado de todos los registros de 32bits
	
	GetStr	operation

	mov	EBX, 0
	;mov	ECX, 0
cont:					;Posicionarse en el ultimo digito del string
	cmp	byte[operation+EBX], 0
	je	preconvertir
	inc	EBX
	add	dword[final], 1	
	jmp	cont
preconvertir:
	sub	dword[final], 2
	mov	dword[cont_op], EBX
convertir:
	;dec	EBX
	sub	dword[cont_op], 1
	;PutStr	msg_ayuda
	;PutStr	number1
	;PutLInt	EBX
	;nwln
		
	sub	AL, AL
	mov	EBX, dword[cont_op]
	mov	AL, byte[operation+EBX]
	mov	byte[number1 + 9], AL 
	
	;PutStr	msg_ayuda
	;PutStr	number1
	
	
	powOchoASCII byte[contador]

	;powOchoASCII 3
	
	;PutStr potencia
	nwln
	stringToInt potencia
	;PutLInt	EAX
nwln
	mulASCII number1, EAX
	;mulASCII number1, 3
	addASCII total, sum
	
	
	mov	EAX, dword[final]
		
	cmp	byte[contador], AL
	
	je	SALIR_oct
	
	add 	byte[contador], 1
	
	
	
	jmp	convertir
		
	
	;popfd	;PutStr	sum
	nwln
SALIR_oct:
	
	PutStr	total
	
	stringToInt	total
	PutLInt	EAX
	nwln
	.EXIT







































