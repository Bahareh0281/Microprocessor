/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
� Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 4/20/2024
Author  : kavousi.b99@gmail.com - Bahareh Kavousi nejad - 99431217
Company : IUST
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*****************************************************/
/*
Bahareh Kavousi nejad - 99431217
*/
#include <mega32.h>
#include <stdlib.h>
#include <string.h>
#include <delay.h>

// Alphanumeric LCD functions
#include <alcd.h>

// Declare your global variables here
unsigned int milisecond = 0;
char str_ms[];
unsigned int second = 0;
char str_s[];
unsigned int minute = 58;
char str_m[];
unsigned int hour = 23;
char str_h[];


interrupt [TIM1_COMPA] void timer1_compa_isr(void) {
    milisecond += 1;
    
      
    if(hour == 24) {
        lcd_gotoxy(3,1);
        lcd_puts("  ");
        hour=0;
    }   
    
    if (minute == 60) {
        lcd_gotoxy(6,1);
        lcd_puts("  ");
        minute=0;  
        hour++;
    }
    
    if (second == 60) {
        lcd_gotoxy(9,1);
        lcd_puts("  ");
        second = 0; 
        minute++;
    }
    
    if (milisecond == 10) {
        milisecond = 0;   
        second++;
    }   

    itoa(milisecond, str_ms);
    lcd_gotoxy(12,1);
    lcd_puts(str_ms);

    itoa(second, str_s);
    lcd_gotoxy(9,1);
    lcd_puts(str_s);

    itoa(minute, str_m);
    lcd_gotoxy(6,1);
    lcd_puts(str_m);
       
    itoa(hour, str_h);
    lcd_gotoxy(3,1);
    lcd_puts(str_h); 
}


void main(void) {
    // Declare your local variables here     
    
    DDRC=0xFF; 
    PORTC=0x00;

    TCCR1A=0x00;
    TCCR1B=0x0C;
    TCNT1H=0x00;
    TCNT1L=0x00;
    ICR1H=0x00;
    ICR1L=0x00;
    OCR1AH=0x0C;
    OCR1AL=0x35;
    OCR1BH=0x00;
    OCR1BL=0x00;

    TIMSK=0x10;   
    
    // Alphanumeric LCD initialization
    // Connections are specified in the
    // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
    // RS - PORTC Bit 0
    // RD - PORTC Bit 1
    // EN - PORTC Bit 2
    // D4 - PORTC Bit 4
    // D5 - PORTC Bit 5
    // D6 - PORTC Bit 6
    // D7 - PORTC Bit 7
    // Characters/line: 16
    
    // Global enable interrupts
    #asm("sei")
    lcd_init(16);
    lcd_clear();

    lcd_gotoxy(3,0);
    lcd_puts("LCD CLOCK");

    lcd_gotoxy(11,1);
    lcd_puts(":");
    lcd_gotoxy(5,1);
    lcd_puts(":");
    lcd_gotoxy(8,1);
    lcd_puts(":");

    while(1) {
          // Place your code here
            
    }
}

