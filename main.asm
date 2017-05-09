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

	ayuda		db	"Los números binarios comienzan con una b y los octales con una o. Ejemplo: o123+b1001 ", 0
	ayuda_2		db	"Se recomienda ingresar operaciones simples, como las del ejemplo. ", 0
	ayuda_3		db	"Para punto flotante (solo binario a decimal), ingrese la cantidad que desea convertir. Ej: 1001.1", 0


	info		db	"Instituto Tecnológico de Costa Rica. Ingeniería en Computación. Arquitectura de Computadores", 0
	info_2		db	"Estudiante: Roberto Rojas Segnini, 2016139072",0
	info_3		db	"I semestre del 2017", 0


	
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
	resul		db	'Resultado: ', 0	



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

	cmp	dword[operation], '#ayuda'
	je	AYUDA_calcu	

	checkFloat	operation
	cmp	EAX, 'True'
	je	puntoFlotante

	posfijo
	evaluar
	jmp	borrar_pila
	
	

borrar_pila:
	mov	EDX, 0
borrar_pila_2:
	cmp	byte[pilaPosfijo + EDX], 0
	je	main
	mov	byte[pilaPosfijo + EDX], 0
	inc	EDX
	
	jmp	borrar_pila_2


puntoFlotante:
	bF_dF	operation, frac
	PutLInt	EBX
	PutCh	'.'
	PutLInt	dword[frac]
	nwln
	jmp	main
AYUDA_calcu:
	PutStr	ayuda
	nwln
	PutStr	ayuda_2
	nwln
	PutStr	ayuda_3
	nwln
	jmp main
SALIR_calcu:
	PutStr	info
	nwln
	PutStr	info_2
	nwln
	PutStr	info_3
	nwln
	.EXIT
;nasm -f elf32 main.asm
;ld main.o -o main io.o b_h.o
;./main