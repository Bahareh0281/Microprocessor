// must run on Matrix_5x7_Col
// Moving an Arrow 
#include <mega32.h>
#include <delay.h>

const unsigned char Code[]=
{
    0xff,
    0xff,
    0xff,
    0xff,
    0x80,
    0xb6,
    0xb6,
    0xb6,
    
//    0xff,
//    0xff,
//    0xff,
//    0xff,
//    0xc1,
//    0xdd,
//    0xdd,
//    0xc1,

0xff,
0xff,
0xff,
0xff,
0xc0,
0xde,
0xde,
0xc0,

    
    
    0xff,
    0xff,
    0xff,
    0xf7,
    0xc0,
    0xf5,
    0xf3,
    0xf7,
    
    0xff,
    0xff,
    0xff,
    0xff,
    0x80,
    0xff,
    0xff,
    0xff
    
    
    
}
;
void main(void)
{
unsigned char Col,Scan,Refresh,Index,S;
DDRB=0xFF;
DDRA=0xFF;

while (1)
      {
      // Place your code here
      for (S=0; S<29; S++)
      {
        for (Refresh=1; Refresh<11; Refresh++)
        {
            Scan = 0b00000001;
            for (Col=0; Col<5; Col++)
            {
                Index = S + Col;
                PORTA = Code[Index];
                PORTB = Scan;
                delay_ms(4);
                Scan = Scan << 1;
                PORTB = 0x00;
            }
        }
      }
      }
}
