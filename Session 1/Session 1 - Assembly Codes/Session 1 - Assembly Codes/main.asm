;
; Session 1 - Assembly Codes.asm
;
; Created: 2/25/2024 2:48:31 PM
; Author : Kavousinejad
;
.include "m32def.inc"

    LDI      R16, 0xFF
    OUT      DDRB, R16

L4: LDI      R16, 0b00000001

START:
    OUT      PORTB, R16
    CALL     DELAY
    LSL      R16
    BRCC     REVERSE
    RJMP     START

REVERSE:
    LDI      R16, 0b10000000
    OUT      PORTB, R16
    CALL     DELAY
    LSR      R16
    BRNE     REVERSE
    RJMP     L4

DELAY:
    LDI      R17, 0xFF
L1: DEC      R17
    BRNE     L1
    RET

