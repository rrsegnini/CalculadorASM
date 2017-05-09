;	MAIN

; 	CONVERTER

%include "io.mac"
%include "b_h.mac"
.DATA
	intro 		db 	"CALCULADORA ", 0
	msg_ayuda 	db 	"Ingrese #ayuda para desplegar el menú de ayuda ", 0	
	prompt 		db 	"CALCULADORA:  ", 0
	error_msg 	db 	"Error en los datos ingresados ", 0
	PDP		db	0
	PFP		db	0

	;pilaPosfijo	db	'b10o10+',0
	
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

	primer_operando	dd	0
	segundo_operando dd	0
	resul		db	'Resultado: '	



.UDATA
	operation resb 	264
	base	resb	1
	digit	resb	4
	pilaPosfijo	resb	264
	frac	resd	1

	operando resb 	264

.CODE
	.STARTUP
 	PutStr 	intro	  ;MENSAJES DE BIENVENIDA	
	PutStr 	msg_ayuda ;
nwln
nwln

main:
	PutStr	prompt
	GetStr	operation

	cmp	dword[operation], '#salir'
	je	SALIR_calcu
	checkFloat	operation
	cmp	EAX, 'True'
	je	puntoFlotante

	posfijo
	evaluar
	jmp	main
	
	




puntoFlotante:
	bF_dF	operation, frac
	PutLInt	EBX
	PutCh	'.'
	PutLInt	dword[frac]
	nwln
	jmp	main

SALIR_calcu:

	.EXIT
;nasm -f elf32 main.asm
;ld main.o -o main io.o b_h.o
;./main