





%macro	b_h	1	;number
	shl 	%1, 8
	mov 	CX, 264
	mov 	EAX, 0
	mov	EBX, 0
read_str:
	mov	EAX, dword[%1 + (264-CX)]
	cmp	EAX, '1001'
	je	Uno 
	
Cero:
	
	
		
		



%endmacro