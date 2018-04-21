----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:28:30 01/29/2017 
-- Design Name: 
-- Module Name:    read_multiple_data_bytes - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity read_multiple_data_bytes is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           next_data : in  STD_LOGIC;
           data_read : out  STD_LOGIC_VECTOR (31 downto 0));
end read_multiple_data_bytes;

architecture Behavioral of read_multiple_data_bytes is
	signal pos_read : unsigned(1 downto 0) := (others=>'0');
	signal old_next_data: std_logic := '0';
	signal next_write_data: std_logic_vector(7 downto 0) := (others=>'0');
	signal next_pos_read : unsigned(1 downto 0) := (others=>'0');
	signal temp_data_read : std_logic_vector(31 downto 0) := (others => '0');
	signal button_release : std_logic;
begin

	button_release <= old_next_data and (not next_data);
	
	next_write_data <= data_in(7 downto 0) when (button_release = '1') else
								temp_data_read((8*to_integer(pos_read) + 7) downto (8*to_integer(pos_read)));
	
	next_pos_read <= pos_read + 1 when (button_release = '1') else
							pos_read;
							
	process(clk, reset)
	begin
		if (reset = '1') then
			old_next_data <= '0';
		else
			if (rising_edge(clk)) then
				old_next_data <= next_data;
			end if;
		end if;
	end process;
			
	process(clk, reset)
	begin
		if (reset = '1') then
			temp_data_read <= (others=>'0');
		elsif (rising_edge(clk)) then
			temp_data_read((8*to_integer(pos_read) + 7) downto (8*to_integer(pos_read))) <= next_write_data;
		end if;
	end process;
	
	process(clk, reset)
	begin
		if (reset = '1') then
			pos_read <= (others=>'0');
		else
			if (rising_edge(clk)) then
				pos_read <= next_pos_read;
			end if;
		end if;
	end process;
	
	data_read <= temp_data_read;
end Behavioral;