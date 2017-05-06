;	MAIN

; 	POSFIJO

%include "io.mac"
%include "b_h.mac"

.DATA
	;intro_posfijo		db 	"POSFIJO ", 0
	error_msg 	db 	"Error en los datos ingresados ", 0
	PDP		db	0
	PFP		db	0

		



.UDATA
	operation resb 	264
	base	resb	1
	pilaPosfijo	resb	264
	num	resb	264
	
	
	

.CODE
	.STARTUP

	
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
	je	SALIR_posfijo
	
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

	pop	EAX
	prioridades AL, byte[operation + EBX] ;Compara prioridades DENTRO DE LA PILA (%1) y FUERA DE LA PILA (%2)
	inc	EBX

loop1:
	;loop	reading
	dec	ECX
	jnz	reading
	jmp	SALIR_posfijo


;-------------------------------------------------
bin_num:
	cmp	byte[operation + EBX], 'b'
	je	b

	cmp	byte[operation + EBX], '0'
	je	Cero
	
	cmp	byte[operation + EBX], '1'
	je	Uno
	jg	ERROR

	jmp	loop1
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

	jmp	loop1
	
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

	jmp	loop1
	
o:
	mov	byte[pilaPosfijo+EDX], 'o'
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
	mov	byte[pilaPosfijo+EDX], 'd'
	;inc	EBX
	inc 	EDX

dec_num2:

	cmp	byte[operation + EBX], '0'
	jge	Cero_nueve

	jmp	loop1
	
	
Cero_nueve:
	cmp	byte[operation + EBX], '9'
	jg	ERROR
	
	push	EAX
	mov	AL, byte[operation + EBX]
	mov	byte[pilaPosfijo+EDX], AL
	pop 	EAX
	inc	EBX
	inc 	EDX
	jmp	dec_num2		
;-------------------------------------------------

pila_vacia:
	push	EAX
	mov	AL, byte[operation + EBX]
	push	EAX
	inc	EBX
	jmp	loop1

;-------------------------------------------------

vaciar_pila:
	pop	EAX
	PutCh	AL
	nwln
	cmp	AL, '('
	je	vaciar_pila_salir
	
	mov	byte[pilaPosfijo + EDX], AL
	inc	EDX
	jmp	vaciar_pila
vaciar_pila_salir:	
	inc	EBX
	jmp	loop1
;-------------------------------------------------

ERROR:
	PutStr	error_msg
	nwln
	.EXIT
	


SALIR_posfijo:	
	
	pop	EAX
	PutCh	AL
	nwln
	cmp	AL, '#'
	je	SALIR_posfijo_2
	
	mov	byte[pilaPosfijo + EDX], AL
	inc	EDX
	jmp	SALIR_posfijo

SALIR_posfijo_2:	
	inc	EBX
	

	PutStr pilaPosfijo
	nwln
	.EXIT






















