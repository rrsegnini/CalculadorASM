;	MAIN

; 	EVALUAR

%include "io.mac"
%include "b_h.mac"

.DATA
	;intro_posfijo		db 	"EVALUAR ", 0
	error_msg 	db 	"Error en los datos ingresados ", 0
	PDP		db	0
	PFP		db	0
	pilaPosfijo	db	'b1111b10+',0

	;PDP		db	0
	;PFP		db	0
	
	;PASAR AL MAIN
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

	;operando	dd	'                                                    '
	;FIN PASAR AL MAIN	



.UDATA
	operation resb 	264
	operando resb 	264
	;base	resb	1
	;pilaPosfijo	resb	264
	;num	resb	264
	
	
	

.CODE
	.STARTUP

	
	mov	EBX, 0		;Desplazamiento para recorrer el string
	;mov	byte[pilaPosfijo], '#'	
	mov	CX, 264	
	mov	EAX, 0
	mov	AL, '#'
	push	EAX	;Pila vacia
	mov	EDX, 0		;Contador para la pila posfijo
	
	;GetStr	operation
	
reading:
	cmp	byte[pilaPosfijo + EBX], 0	;SALTA SI LELGA AL FINAL DE STRING
	je	SALIR_posfijo
	
	cmp	byte[pilaPosfijo + EBX], 'b'	;Si es binario
	je	bin_num

	cmp	byte[pilaPosfijo + EBX], 'h'	;Si es hexadecimal
	je	hex_num

	cmp	byte[pilaPosfijo + EBX], 'o'	;Si es octal
	je	oct_num

	cmp	byte[pilaPosfijo + EBX], '0'	;Si es decimal
	jge	dec_num

	cmp	byte[pilaPosfijo + EBX], '+'	;Si es decimal
	je	op_sumar
	
	cmp	byte[pilaPosfijo + EBX], '-'	;Si es decimal
	je	op_restar

	pop	EAX
	cmp	EAX, '#'			;Si la pila esta vacia
	je	pila_vacia
	push	EAX	
	
	cmp	byte[pilaPosfijo + EBX], ')'			;Si se encuentra un parentesis de cierre
	je	vaciar_pila

	pop	EAX
	prioridades AL, byte[operation + EBX] ;Compara prioridades DENTRO DE LA PILA (%1) y FUERA DE LA PILA (%2)
	inc	EBX

loop1:
	;loop	reading
	;mov	EDX, 0
	dec	ECX
	jnz	reading
	jmp	SALIR_posfijo


;-------------------------------------------------
bin_num:
	
	mov	byte[operando+EDX], 'b'
	inc	EBX
	inc 	EDX

b:	
	cmp	byte[pilaPosfijo + EBX], '0'
	je	Cero
	
	cmp	byte[pilaPosfijo + EBX], '1'
	je	Uno
	;jg	loop1
	
	push	EBX
	push	ECX

	b_d	operando
	
	pop 	ECX
	pop	EBX
	PutLInt	EAX
	nwln
	push	EAX 		;METE EL NUMERO EN ENTERO A LA PILA
	sub	EDX, EDX
	;jmp	SALIR_posfijo_2
	jmp	borrar_operando


Cero:	
	mov	byte[operando+EDX], '0'
	inc	EBX
	inc 	EDX
	jmp	b
Uno:	
	mov	byte[operando+EDX], '1'
	inc	EBX
	inc 	EDX
	jmp	b	

;-------------------------------------------------
hex_num:
	cmp	byte[pilaPosfijo + EBX], 'h'
	je	h
	
	cmp	byte[pilaPosfijo + EBX], '0'
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
	
	;pop	EAX
	;PutLInt	EAX
	
	;PutStr pilaPosfijo
	nwln
	.EXIT

;-------------------------------------------------
op_sumar:
	pop	EAX
	mov	dword[segundo_operando], EAX
	pop	EAX
	mov	dword[primer_operando], EAX
	
	push	EDX
	mov	EDX, dword[segundo_operando]
	mov	EAX, dword[primer_operando]
	add	EAX, EDX
	PutLInt	EAX
	pop	EDX
	jmp	SALIR_posfijo_2
	


op_restar:
	pop	EAX
	mov	dword[segundo_operando], EAX
	pop	EAX
	mov	dword[primer_operando], EAX
	
	push	EDX
	mov	EDX, dword[segundo_operando]
	mov	EAX, dword[primer_operando]
	sub	EAX, EDX
	PutLInt	EAX
	pop	EDX
	jmp	SALIR_posfijo_2




borrar_operando:
	mov	EDX, 0
borrar_operando_2:
	cmp	EDX, 5
	;cmp	byte[operando + EDX], 0
	je	SALIR_posfijo_2
	mov	byte[operando + EDX], 0
	inc	EDX
	jmp	SALIR_posfijo_2












