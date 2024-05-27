/*******************************************************
This program was created by the
CodeWizardAVR V3.14 Advanced
Automatic Program Generator
� Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/26/2024
Author  : 
Company : 
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

//3

#include <mega32.h>
#include <delay.h>

char code[] = { 0x3F, 0x06, 0x5B, 0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F}  ;
int counter;

// Timer 0 output compare interrupt service routine
interrupt [TIM0_COMP] void timer0_comp_isr(void)
{
    counter++;
    if (counter == 3) 
        counter=0;

}


// Declare your global variables here

void main(void)
{
    PORTC=0x00;
    PORTD=0x00;
    DDRC=0xFF;
    DDRB=0xFF;
    DDRD=0x00;

    // Timer/Counter 0 initialization
    // Clock source: System Clock
    // Clock value: 7.813 kHz
    // Mode: CTC top=OCR0
    // OC0 output: Disconnected
    TCCR0=0x0C;
    TCNT0=0x00;
    OCR0=0x63;

    // Timer(s)/Counter(s) Interrupt(s) initialization
    TIMSK=0x12;

    // Global enable interrupts
    #asm("sei")

    while (1)
    {       
        unsigned int number = 0; 
        int rem , index = 0;
        char decimal[3]={0,0,0}; 

        if(PIND.0 == 1)   
        {
            number += 1;
        }  
               
        if(PIND.1 == 1)   
        {
            number += 2;
        }  
               
        if(PIND.2 == 1)   
        {
            number += 4;
        }   
               
        if(PIND.3 == 1)   
        {
            number += 8;
        }  
               
        if(PIND.4 == 1)   
        {
            number += 16;
        } 
               
        if(PIND.5 == 1)   
        {
            number += 32;
        }  
               
        if(PIND.6 == 1)   
        {
            number += 64;
        }  
                  
        if(PIND.7 == 1)   
        {
            number += 128;
        }

        while(number !=0)
        {
            rem = number % 10;

            decimal[index] = rem;

            number /= 10;

            index++;
        }
        
        if(counter == 0)
        {
            PORTB = 0b01111111; 
            PORTC = code[decimal[0]];
        }
            
        else if(counter == 1)
        { 
            PORTB = 0b10111111;
            PORTC = code[decimal[1]];
        }
        else if(counter == 2)
        {
            PORTB = 0b11111101;
            PORTC = code[decimal[2]];
        }    
        delay_ms(5);
    }
}
