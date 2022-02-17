LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SPI_FPGA_tb IS
END SPI_FPGA_tb;
 
ARCHITECTURE behavior OF SPI_FPGA_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SPI_FPGA
    PORT(
         CLK : IN  std_logic;
         MOSI : IN  std_logic;
         MISO : BUFFER  std_logic;
         SCK : IN  std_logic;
         CS : IN  std_logic;
         LED_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal MOSI : std_logic := '0';
   signal SCK : std_logic := '0';
   signal CS : std_logic := '0';

 	--Outputs
   signal MISO : std_logic;
   signal LED_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SPI_FPGA PORT MAP (
          CLK => CLK,
          MOSI => MOSI,
          MISO => MISO,
          SCK => SCK,
          CS => CS,
          LED_out => LED_out
        );

 --*** Test Bench - User Defined Section ***
	clock: process
	begin
		CLK  <= '0';
      		for i in 1 to 1000 loop
       			wait for 5 ns;
			CLK  <= not CLK;
      		end loop;
      		wait;
	end process;
	
	SCL: process
	begin
		SCK  <= '0';
		wait for 280 ns;
      		for i in 1 to 1000 loop
       			wait for 35 ns;
			SCK  <= not SCK;
      		end loop;
      		wait;
	end process;
--    Stimulus process
   tb: process
   begin	
	CS <= '1';   
	wait for 250 ns;
	CS <= '0';
	wait for 25 ns;
	MOSI <= '1';
	wait for 100 ns;
	MOSI <= '0';
	wait for 100 ns;
	MOSI <= '1';
	wait for 100 ns;
	MOSI <= '1';
	wait for 100 ns;
	MOSI <= '0';
	wait for 100 ns;
	MOSI <= '1';
	wait for 100 ns;
	MOSI <= '0';
	CS <= '1';
	wait for 300 ns;
	CS <= '0';
	wait for 25 ns;
	MOSI <= '1';
	wait for 100 ns;
	MOSI <= '1';
	wait for 100 ns;
	MOSI <= '1';
	wait for 100 ns;
	MOSI <= '0';
	wait for 100 ns;
	MOSI <= '0';
	wait for 100 ns;
	MOSI <= '0';
	wait for 100 ns;
	MOSI <= '0';
	CS <= '1';

      wait;
   end process;

END;
