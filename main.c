#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "SPI.h"

volatile unsigned char send_enable = 0;

void Button_Init(void)
{
	MCUCR |= (1<<ISC11);	// the falling edge of INT1 generates an interrupt request
	GICR |= (1<<INT1);
}

ISR(INT1_vect)
{
	_delay_ms(5);
	if (!(PIND&(1<<PD3)))
		send_enable = 1;

}

int main(void)
{
	SPI_Init();
	Button_Init();
	sei();							// global interrupt flag set
	unsigned char counter = 0;		// data to be send
	unsigned char data_received = 0;
	DDRB |= (1<<PB0);
    while (1) 
    {
		PORTB &= (~(1<<PB0));
		if (send_enable)
		{
			PORTB |= (1<<PB0);
			send_enable = 0;
			counter++;
			PORTB &= (~(1<<PB2));				// enable CS
			data_received = SPI_Transmit(counter);
			PORTB |= (1<<PB2);					// disable CS	
		}
    }
}

