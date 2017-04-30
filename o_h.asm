;Octal a decimal

;	MAIN

; 	o_h

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
 	
	mov 	EAX, '9'
	mov	EBX, '3'
	and	EAX, 0FH
	and	EAX, 0FH
	mul	EBX
	aam
	or	EAX, 30H
	PutStr	EAX

	.EXIT
