; Bahareh Kavousi nejad
; 99431217
.include "m32def.inc"
    LDI      R16,HIGH(RAMEND)
    OUT      SPH,R16
    LDI      R16,LOW(RAMEND)
    OUT      SPL,R16

    LDI      R16,0xFF
    OUT      DDRB,R16
L4: LDI      R16,0b00000001

BEGIN:
    OUT      PORTB,R16
    CALL     DELAYS
    LSL      R16
    CPI      R16,0
    BRNE     BEGIN

L5: LDI      R16,0b10000000

END:
    OUT      PORTB,R16
    CALL     DELAYS
    LSR      R16
    BRNE     END
    JMP      L4
    RJMP     L4

DELAYS:
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


