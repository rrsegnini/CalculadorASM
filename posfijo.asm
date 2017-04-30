;	MAIN

; 	POSFIJO

%include "io.mac"

.DATA
	intro 		db 	"POSFIJO ", 0
	error_msg 		db 	"Error en los datos ingresados ", 0
	

		



.UDATA
	operation resb 	264
	base	resb	1
	pilaPosfijo	resb	264
	num	resb	264
	
	
	

.CODE
	.STARTUP

	PutStr	intro
	
	mov	EBX, 0		;Desplazamiento para recorrer el string
	mov	byte[pilaPosfijo], '#'	
	mov	CX, 264	
	mov	EAX, 0
	mov	AL, '#'
	push	EAX	;Pila vacia
	mov	EDX, 0		;Contador para la pila posfijo
	
	GetStr	operation
	
reading:
	cmp	byte[operation + EBX], 0	;SALTA SI LELGA AL FINAL DE STRING
	je	SALIR
	
	cmp	byte[operation + EBX], 'b'	;Si es binario
	je	bin_num

	cmp	byte[operation + EBX], 'h'	;Si es hexadecimal
	je	hex_num

	cmp	byte[operation + EBX], 'o'	;Si es octal
	je	oct_num

	cmp	byte[operation + EBX], '0'	;Si es decimal
	jge	dec_num
	
	pop	EAX
	cmp	EAX, '#'			;Si la pila esta vacia
	je	pila_vacia
	push	EAX	
	
	cmp	byte[operation + EBX], ')'			;Si se encuentra un parentesis de cierre
	je	vaciar_pila

	;pop	EAX
	;pioridades	AL, byte[operation + EBX] ;Compara prioridades DENTRO DE LA PILA (%1) y FUERA DE LA PILA (%2)
	inc	EBX

loop:
	
	loop	reading
	jmp	SALIR



bin_num:
	cmp	byte[operation + EBX], 'b'
	je	b

	cmp	byte[operation + EBX], '0'
	je	Cero
	
	cmp	byte[operation + EBX], '1'
	je	Uno
	jg	ERROR

	jmp	loop
b:
	mov	byte[pilaPosfijo+EDX], 'b'
	inc	EBX
	inc 	EDX
	jmp	bin_num

Cero:	
	mov	byte[pilaPosfijo+EDX], '0'
	inc	EBX
	inc 	EDX
	jmp	bin_num
Uno:	
	mov	byte[pilaPosfijo+EDX], '1'
	inc	EBX
	inc 	EDX
	jmp	bin_num	

;-------------------------------------------------
hex_num:
	cmp	byte[operation + EBX], 'h'
	je	h
	
	cmp	byte[operation + EBX], '0'
	jge	Cero_F

	jmp	loop
	
h:
	mov	byte[pilaPosfijo+EDX], 'h'
	inc	EBX
	inc 	EDX
	jmp	hex_num

	
Cero_F:
	cmp	byte[operation + EBX], 'F'
	jg	ERROR
	
	push	EAX
	mov	AL, byte[operation + EBX]
	mov	byte[pilaPosfijo+EDX], AL
	pop 	EAX
	inc	EBX
	inc 	EDX
	jmp	hex_num


;-------------------------------------------------	
oct_num:
	cmp	byte[operation + EBX], 'o'
	je	o
	
	cmp	byte[operation + EBX], '0'
	jge	Cero_siete

	jmp	loop
	
o:
	mov	byte[pilaPosfijo+EDX], 'h'
	inc	EBX
	inc 	EDX
	jmp	oct_num

	
Cero_siete:
	cmp	byte[operation + EBX], '7'
	jg	ERROR
	
	push	EAX
	mov	AL, byte[operation + EBX]
	mov	byte[pilaPosfijo+EDX], AL
	pop 	EAX
	inc	EBX
	inc 	EDX
	jmp	oct_num

;-------------------------------------------------
dec_num:
	cmp	byte[operation + EBX], '0'
	jge	Cero_nueve

	jmp	loop
	
	
Cero_nueve:
	cmp	byte[operation + EBX], '9'
	jg	ERROR
	
	push	EAX
	mov	AL, byte[operation + EBX]
	mov	byte[pilaPosfijo+EDX], AL
	pop 	EAX
	inc	EBX
	inc 	EDX
	jmp	dec_num		
;-------------------------------------------------

pila_vacia:
	mov	AL, byte[operation + EBX]
	push	EAX
	inc	EBX
	jmp	loop

;-------------------------------------------------

vaciar_pila:
	pop	EAX
	PutCh	AL
	cmp	AL, '('
	je	vaciar_pila_salir
	
	mov	byte[pilaPosfijo + EDX], AL
	inc	EDX
	jmp	vaciar_pila
vaciar_pila_salir:	
	inc	EBX
	jmp	loop
;-------------------------------------------------

ERROR:
	PutStr	error_msg
	nwln
	.EXIT
	


SALIR:	
	PutStr pilaPosfijo
	nwln
	.EXIT






















