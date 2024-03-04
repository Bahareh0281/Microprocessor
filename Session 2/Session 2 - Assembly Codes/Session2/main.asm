; Bahareh Kavousi nejad
; 99431217
.include "m32def.inc"
		LDI		R16,HIGH(RAMEND)
		OUT		SPH,R16
		LDI		R16,LOW(RAMEND)
		OUT		SPL,R16

		LDI		R16,0xFF
		OUT		DDRC,R16		;PORTC as output
		OUT		DDRD,R16		;PORTD as output
		OUT		PORTA,R16		;Enabling Pullup Resistor on PORTA 
		LDI		R16,0x00
		OUT		DDRA,R16		;PORTA as input

START:	IN		R16,PINA
		CPI 	R16,0
		BREQ 	START1
		LDI		R20,0           ;LSB = 0
		LDI		R21,0			;middle bit = 0
		LDI		R22,0			;second middle bit = 0
		LDI     R23,0			;MSB = 0
		RJMP	F0

START1:	LDI		R20,9			;LSB = 9
		LDI		R21,9			;middle bit = 9
		LDI		R22,9			;second middle bit = 9
		LDI    	R23,9			;MSB = 9
		RJMP	J0

S: 		IN			R16,PINA
		CPI 		R16,0
		BREQ 		J0

F0:		CPI 		R20,0x09
		BREQ 		F1
		INC 		R20
		RJMP		F4

F1:		LDI 		R20,0x00
		CPI 		R21,0x09
		BREQ 		F2
		INC 		R21
		RJMP		F4

F2:		LDI 		R21,0x00
		CPI 		R22,0x09
		BREQ 		F3
		INC 		R22
		RJMP		F4

F3: 	LDI 		R22,0x00
		CPI 		R23,0x09
		BREQ 		F5
		INC 		R23

F5: 	LDI 		R23,0x00
		BREQ 		F4

J0: 	CPI 		R20,0x00
		BREQ 		J1
		DEC			R20
		RJMP		F4

J1:		LDI 		R20,0x09
		CPI 		R21,0x00
		BREQ 		J2
		DEC 		R21
		RJMP		F4

J2:		LDI 		R21,0x09
		CPI 		R22,0x00
		BREQ 		J3
		DEC 		R22
		RJMP		F4

J3:	 	LDI 		R22,0x09
		CPI 		R23,0x00
		BREQ 		J4
		DEC 		R22

J4:		LDI 		R23,0x09
		RJMP 		F4

F4:
		LDI		R16,0b1110	;displaying LSB
		OUT		PORTD,R16
		MOV		R16,R23
		CALL	CONVERT
		OUT		PORTC,R16
		CALL	DELAY

		LDI		R16,0b1101	;displaying middle bit
		OUT		PORTD,R16
		MOV		R16,R22
		CALL	CONVERT
		OUT		PORTC,R16
		CALL	DELAY
		
		LDI		R16,0b1011	;displaying second middle bit 
		OUT		PORTD,R16
		MOV		R16,R21
		CALL	CONVERT
		OUT		PORTC,R16
		CALL	DELAY

		LDI		R16,0b0111	;displaying MSB 
		OUT		PORTD,R16
		MOV		R16,R20
		CALL	CONVERT
		OUT		PORTC,R16
		CALL	DELAY
		RJMP	S

DELAY:	LDI		R17,0x01
L1:		LDI		R18,0xFF
L2:		LDI		R19,0xA0
L3:		DEC		R19
		BRNE	L3
		DEC		R18
		BRNE	L2
		DEC		R17
		BRNE	L1
		RET

CONVERT:	;converts a digit to 7seg code 
		CPI		R16,0
		BRNE	C1
		LDI		R16,0x3F
		RET

C1:		CPI		R16,1
		BRNE	C2
		LDI		R16,0x06
		RET
C2:		CPI		R16,2
		BRNE	C3
		LDI		R16,0x5B
		RET
C3:		CPI		R16,3
		BRNE	C4
		LDI		R16,0x4F
		RET
C4:		CPI		R16,4
		BRNE	C5
		LDI		R16,0x66
		RET
C5:		CPI		R16,5
		BRNE	C6
		LDI		R16,0x6D
		RET
C6:		CPI		R16,6
		BRNE	C7
		LDI		R16,0x7D
		RET
C7:		CPI		R16,7
		BRNE	C8
		LDI		R16,0x07
		RET
C8:		CPI		R16,8
		BRNE	C9
		LDI		R16,0x7F
		RET
C9:		CPI		R16,9
		BRNE	C10
		LDI		R16,0x6F
C10:	RET
