; Bahareh Kavousi nejad
; 99431217

.INCLUDE  "M32DEF.INC"
.ORG 0

LDI R28,1   
RJMP MAIN
    
.ORG $014
    RJMP	TIMER0FUNC		; Go to TIMER0FUNCTION
.ORG $00E
    RJMP	TIMER1FUNC		; Go to TIMER1FUNCTION

.ORG 0X100
MAIN:                     
  LDI        R16,0XFF
  OUT        DDRB,R16
  LDI        R16,0xFF
  OUT        DDRC,R16        ; PORTC as output
  OUT        DDRD,R16        ; PORTD as output
  OUT        PORTA,R16       ; Enabling Pullup Resistor on PORTA 
  LDI        R16,0x00
  OUT        DDRA,R16        ;PORTA as input

; TIMER0 Setup 
LDI			R16,0x0C
OUT			TCCR0,R16

LDI			R16,0x00
OUT			TCNT0,R16

LDI			R16,0x63
OUT			OCR0,R16


; TIMER1 Setup 
LDI			R16,0X00
OUT			TCCR1A,R16

LDI			R16,0x0C
OUT			TCCR1B,R16

LDI			R16,HIGH(31250) 
OUT			OCR1AH,R16

LDI			R16,LOW(31250) 
OUT			OCR1AL,R16

LDI			R16, 0x12 
OUT			TIMSK,R16
SEI

; Main Loop
LDI			R30,0
LDI			R31,0
LDI			R27,0b00000000		; LED 
DISPLY: 
	MOV        R17,R30
    MOV        R24,R31
    LDI        R20,0
    LDI        R21,0
    LDI        R22,0
    LDI        R23,0
                
    MOV        R17,R30
    MOV        R24,R31
D1:     
	CPI        R17,10
    BRLO	   D2
    LDI        R18,10
    SUB        R17,R18
    INC        R21            ; Middle bit 2
    RJMP       D1
D2:     
	MOV        R22,R17        ; LSB       
    LDI        R23,0
D4:     
	CPI        R24,10
    BRLO       D3
    SUB        R24,R18
    INC        R23
    NOP						  ; MSB
    RJMP       D4
D3:     
	MOV        R20,R24        ; Middle bit 1
	NOP
            
H1:         
	LDI        R16,0b11110111 ; displaying LSB
    OUT        PORTD,R16          
    MOV        R16,R22
    CALL       CONVERT
    OUT        PORTC,R16
    CPI        R28,1
    BRNE       H2
    RJMP       H1
                     
H2:         
	LDI        R16,0b11111011    ;displaying Middle bit 2
    OUT        PORTD,R16          
    MOV        R16,R21
    CALL       CONVERT
    OUT        PORTC,R16
    CPI		   R28,2
    BRNE       H3
    RJMP       H2           
        
H3:         
		LDI        R16,0b11111101    ;displaying Middle bit 1
        OUT        PORTD,R16
        MOV        R16,R20
        CALL       CONVERT
        OUT        PORTC,R16
        CPI        R28,3
        BRNE       H4
        RJMP       H3
                       
H4:        
		LDI        R16,0b11111110    ;displaying MSB
        OUT        PORTD,R16
        NOP 
        MOV        R16,R23
        NOP
        CALL       CONVERT
        NOP
        NOP
        OUT        PORTC,R16              
        CPI        R28,4
        BRNE       DISPLY
        RJMP       H4

; Convert a digit to 7seg code            
CONVERT: 
    CPI			R16,0
    BRNE		C1
    LDI			R16,0x3F
    RET
C1:        
	CPI			R16,1
    BRNE		C2
    LDI			R16,0x06
    RET
C2:        
	CPI			R16,2
    BRNE		C3
    LDI			R16,0x5B
    RET
C3:        
	CPI			R16,3
    BRNE		C4
    LDI			R16,0x4F
    RET
C4:        
	CPI			R16,4
    BRNE		C5
    LDI			R16,0x66
    RET
C5:        
	CPI			R16,5
    BRNE		C6
    LDI			R16,0x6D
    RET
C6:        
	CPI			R16,6
    BRNE		C7
    LDI			R16,0x7D
    RET
C7:        
	CPI			R16,7
    BRNE		C8
    LDI			R16,0x07
    RET
C8:        
	CPI			R16,8
    BRNE		C9
    LDI			R16,0x7F
    RET
C9:        
	CPI			R16,9
    BRNE		C10
    LDI			R16,0x6F
C10:    
	RET
                                
; 5ms            
TIMER0FUNC:          
INC			R28
CPI			R28,5
BRNE		DO
LDI			R28,1
DO:			RETI

; 1s
TIMER1FUNC:
LSL			R27              ; LED
CPI			R27,0
BRNE		LED
LDI			R27,0b00000001 
LED: 
OUT			PORTB,R27
; Input
IN		R25,PINA            
CPI     R25,0b00000000 
BRNE	DS1
RJMP	DS0

; If DS is off -> couter is added each time
DS0:    
		CPI		R31,99
        BRNE	INCREM              ; 0000 after 9999
        CPI		R30,99
        BRNE	GO2
        LDI		R31,00
        LDI		R30,00
        RETI
INCREM:	
		CPI		R30,99
        BRNE	GO2
        LDI		R30,00
        INC		R31
        RETI
GO2:		
		INC		R30
        RETI

; If DS is on -> couter is decreased each time
DS1:      
		CPI		R31,00            
		BRNE	DECRE           ; 9999 after 0000
        CPI		R30,00
        BRNE	GO1
        LDI		R31,99
        LDI		R30,99
        RETI
DECRE:	
		CPI		R30,00
        BRNE	GO1
        LDI		R30,99
        DEC		R31
        RETI
GO1:		
		DEC R30
        RETI