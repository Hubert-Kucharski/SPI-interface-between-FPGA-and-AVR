# SPI-interface-between-FPGA-and-AVR


This is a simple project in which a main goal was to implement SPI interface on uC and FPGA.

Repository consists program files, testbench and photos of wired circuit.
As an uC has been used Atmega 8A and as a FPGA chip Spartan-6 XC6SLX9.

Microcontroller acts as a master which counts number of button presses and sends that number 
throught SPI interface to the slave FPGA board which shows that number on LEDs as a binary code.

Wired circuit used for tests:
![spi](spi.jpg)


Simulation for the FPGA part:
![spi_sim](spi_sim.png)



https://user-images.githubusercontent.com/99823278/184111138-304802b9-253d-4474-9b2d-80ef49d08da7.mp4

