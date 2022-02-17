#include "SPI.h"

void SPI_Init(void)
{
	SPCR |= (1<<SPE)|(1<<MSTR);			// enable SPI as master
	SPCR |= (1<<SPR0);					// prescaler 16 , SCK 500 kHz , Oscillator 8 MHz
	DDRB |= (1<<PB2)|(1<<PB3)|(1<<PB5);	// CS , MOSI , SCK as outputs	
	PORTB |= (1<<PB2);					// disable CS
}

unsigned char SPI_Transmit(unsigned char data)
{
	//unsigned char tmp;
	SPDR = data;
	while (!(SPSR&(1<<SPIF)))	
	{}
	return SPDR;
}