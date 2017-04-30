; 	CONVERTER

%include "io.mac"
%include "b_h.mac"
.DATA
	msg_1 	db 	"Ingrese el numero seguido de la base en la que esta: ", 0
	msg_2 	db 	"Ingrese la base destino: ", 0	



.UDATA
	number 	resb 	264
	base	resb	1
	digit	resb	4
	;offset	resb	9

.CODE
	.STARTUP
 	PutStr 	msg_1
	GetStr 	number	;EL NUMERO INGRESADO
	
	PutStr 	msg_2
	GetCh 	DL	;LA BASE DESTINO
	
	b_h	number
	jmp	SALIR

	;shl 	number, 8
	mov 	CX, 263
	mov	EDX, 1 
	mov 	EAX, 0
	mov	EBX, 0
read_str:
	mov	EAX, dword[number + EDX]
	mov	[digit], EAX
	;PutStr	digit
	cmp	EAX, 0
	je	SALIR

	cmp 	EAX, '1010'
	je	A
	cmp	EAX, '1011'
	je	B
	cmp	EAX, '1100'
	je	C
	cmp	EAX, '1101'
	je	D
	cmp	EAX, '1110'
	je	E
	cmp	EAX, '1111'
	je	F
	;jmp	read_str2

	jmp	de0_9

read_str2:
	loop 	read_str
	.EXIT
	 

de0_9:
	sub	EAX, 185
	jmp	read_str2
	;PutLInt	EAX
		


A:
	PutCh 	'A'
	add	EDX, 4
	jmp 	read_str2
B:
	PutCh 	'B'
	add	EDX, 4
	jmp 	read_str2
C:
	PutCh 	'C'
	add	EDX, 4
	jmp 	read_str2
D:
	PutCh 	'D'
	add	EDX, 4
	jmp 	read_str2
E:
	PutCh 	'E'
	add	EDX, 4
	jmp 	read_str2
F:
	PutCh 	'F'
	add	EDX, 4
	jmp 	read_str2


SALIR:
	nwln
	.EXIT
































