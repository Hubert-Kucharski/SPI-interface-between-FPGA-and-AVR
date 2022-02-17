library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity SPI_FPGA is
port(
	CLK: in std_logic;					-- Clock signal
	MOSI: in std_logic;
	MISO: buffer std_logic;
	SCK: in std_logic;
	CS: in std_logic;
	LED_out: out std_logic_vector(7 downto 0)			-- Port for LEDs
	);
end SPI_FPGA;

architecture Behavioral of SPI_FPGA is
type states is (IDLE,DATA_FLOW);
signal state: states := IDLE;
signal next_state: states := IDLE;
signal MOSI_data: std_logic_vector(7 downto 0) := "00000000";		
signal MISO_data: std_logic_vector(7 downto 0) := "10101011";		-- Data to be sent to master

begin
state_machine: process(CLK)
begin
	if rising_edge (CLK) then
		state <= next_state;
	end if;
end process;
work: process(SCK,CS)
variable bit_number: integer range 0 to 7 := 1;			-- Bit index for vector
begin
	if rising_edge(SCK) then
		case state is
			when IDLE =>
				if CS = '0' then			-- When master starts transmission
					next_state <= DATA_FLOW;
					MOSI_data(0) <= MOSI;	-- LSB bit assign
					MISO <= MISO_data(0);
				else				-- Stay in IDLE
					next_state <= IDLE;
				end if;
			when DATA_FLOW =>
				MOSI_data(bit_number) <= MOSI;
				MISO <= MISO_data(bit_number);
				if bit_number = 7 or CS = '1' then	-- When all bits are received
					next_state <= IDLE;
					bit_number := 1;
				else
					next_state <= DATA_FLOW;
					bit_number := bit_number + 1;
				end if;
		end case;
	end if;
end process;
LED_output_change: process(CLK,CS)					-- Use MOSI_data to drive LEDs
begin
	if rising_edge(CLK) and CS = '1' then
		LED_out <= MOSI_data;
	end if;		
end process;
end Behavioral;

