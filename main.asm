;	MAIN

; 	CONVERTER

%include "io.mac"
%include "b_h.mac"
.DATA
	intro 		db 	"CALCULADORA ", 0
	msg_ayuda 	db 	"Ingrese #ayuda para desplegar el menú de ayuda ", 0	
	
		



.UDATA
	operation resb 	264
	base	resb	1
	digit	resb	4
	frac	resd	1
	;offset	resb	9

.CODE
	.STARTUP
 	PutStr 	intro	  ;MENSAJES DE BIENVENIDA	
	PutStr 	msg_ayuda ;
nwln
nwln

	GetStr	operation

	
	
	;checkFloat	operation
	bF_dF	operation, frac
	PutLInt	EBX
	PutCh	'.'
	PutLInt	dword[frac]
	;inc	EDX
	;bF_dF	operation, frac	
	;PutLInt	EBX

	;cmp	EAX, 'True'
	;je	YES

	
	
	nwln

	.EXIT

