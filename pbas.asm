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
	je	convertir
	inc	EBX	
	jmp	cont

convertir:
	dec	EBX
		
	sub	AL, AL
	mov	AL, byte[operation+EBX]
	mov	byte[number1 + 9], AL 
	
	;PutLInt	EBX
	;nwln
	
	;pushfd
	push EBX
	
	
	powOchoASCII byte[contador]
	PutStr	potencia
	
	nwln
	
	
	;stringToInt potencia
	;mov	byte[potencia], '2'
	PutStr	potencia
	

	;mulASCII number1, EAX
	

		
	;PutInt	[contador]
	nwln
	cmp	byte[contador], 1
	je	SALIR_oct
	add 	byte[contador], 1
	
	
	;PutStr	total
	;nwln
	;PutStr	number1
	;nwln
	pop EBX
	jmp	convertir
	
	
	
	;popfd	;PutStr	sum
	nwln
SALIR_oct:
	;popfd
	.EXIT