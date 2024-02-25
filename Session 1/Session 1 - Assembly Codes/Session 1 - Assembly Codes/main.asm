;
; Session 1 - Assembly Codes.asm
;
; Created: 2/25/2024 2:48:31 PM
; Author : Kavousinejad
;
.include "m32def.inc"
    LDI      R16,HIGH(RAMEND)
    OUT      SPH,R16
    LDI      R16,LOW(RAMEND)
    OUT      SPL,R16

    LDI      R16,0xFF
    OUT      DDRB,R16
L4: LDI      R16,0b00000001

START:
    OUT      PORTB,R16
    CALL     DELAY
    LSL      R16
    CPI      R16,0
    BRNE     START

L5: LDI      R16,0b10000000

REVERSE:
    OUT      PORTB,R16
    CALL     DELAY
    LSR      R16
    BRNE     REVERSE
    JMP      L4
    RJMP     L4

DELAY:
    LDI      R17,0xFF
L1: IN       R18,PINA
L2: LDI      R19,0x10
L3: DEC      R19
    BRNE     L3
    DEC      R18
    BRNE     L2
    DEC      R17
    BRNE     L1
    RET  


