----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:00:17 03/27/2018 
-- Design Name: 
-- Module Name:    conditional - Behavioral 
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
use IEEE.numeric_std.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conditional is
port(
		a : in std_logic ;
		b : in std_logic ;
		c : in std_logic ;
		--reset: in std_logic ;
		--clk : in std_logic;
		d : out std_logic_vector(7 downto 0)
		);
end conditional;

architecture Behavioral of conditional is
signal temp : std_logic_vector (2 downto 0);

begin
temp <= a & b & c;

d <= "00000001" when temp = "000" else 
     "00000010" when temp = "001" else 
     "00000100" when temp = "010" else 
     "00001000" when temp = "011" else
	  "00010000" when temp = "100" else 
     "00100000" when temp = "101" else 
     "01000000" when temp = "110" else 
     "10000000" ;


--end process;
end Behavioral;
