----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:43 01/29/2017 
-- Design Name: 
-- Module Name:    display_multiple_data_bytes - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_MISC.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_multiple_data_bytes is
	port(clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            data_in : in  STD_LOGIC_VECTOR (31 downto 0);
            next_data : in  STD_LOGIC;
            data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end display_multiple_data_bytes;

architecture Behavioral of display_multiple_data_bytes is
	signal pos_display: unsigned(1 downto 0) := (others=>'0');
	signal next_pos_display: unsigned(1 downto 0) := (others=>'0');
	signal old_data_in: std_logic_vector(31 downto 0) := (others=>'0');
	signal old_next_data: std_logic := '0';
	signal change_data_in: std_logic;
	signal change_next_data: std_logic;
begin
	data_out(7 downto 0) <= data_in((8*to_integer(pos_display) + 7) downto (8*to_integer(pos_display)));

	
	process(clk, reset)
	begin
		if (reset = '1') then
--			data_out <= (others=>'0');
			old_data_in <= (others=>'0');
		else
			if (clk'event and clk = '1') then
				old_data_in <= data_in;
			end if;
		end if;
	end process;
	
	process(clk, reset)
	begin
		if (reset = '1') then
--			data_out <= (others=>'0');
			old_next_data <= '0';
		else
			if (clk'event and clk = '1') then
				old_next_data <= next_data;
			end if;
		end if;
	end process;
	
	change_data_in <= or_reduce(data_in xor old_data_in);
	change_next_data <= old_next_data and (not next_data);
	
	process(pos_display, change_data_in, change_next_data)
	begin
		if (change_data_in = '1') then
			next_pos_display <= (others=>'0');
		elsif (change_next_data = '1') then
			next_pos_display <= pos_display + 1;
		else
			next_pos_display <= pos_display;
		end if;
	end process;
								
	process(clk, reset)
	begin
		if (reset = '1') then
--			data_out <= (others=>'0');
			pos_display <= (others=>'0');
		else
			if (clk'event and clk = '1') then
				pos_display <= next_pos_display;
			end if;
		end if;
	end process;
			
end Behavioral;