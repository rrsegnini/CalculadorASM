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
		



.UDATA
	operation resb 	264
	base	resb	1
	digit	resb	4
	pilaPosfijo	resb	264
	frac	resd	1

.CODE
	.STARTUP
 	PutStr 	intro	  ;MENSAJES DE BIENVENIDA	
	PutStr 	msg_ayuda ;
nwln
nwln

main:
	PutStr	prompt
	GetStr	operation
	checkFloat	operation
	cmp	EAX, 'True'
	je	puntoFlotante

	posfijo
	jmp	main
	
	




puntoFlotante:
	bF_dF	operation, frac
	PutLInt	EBX
	PutCh	'.'
	PutLInt	dword[frac]
	nwln
	jmp	main


	.EXIT

