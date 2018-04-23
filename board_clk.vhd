----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:42:28 04/17/2018 
-- Design Name: 
-- Module Name:    board_clk - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity board_clk is
port( 	boardclk : IN std_logic;
			n : IN STD_LOGIC_VECTOR(31 downto 0);
			output: out std_logic
									);
end board_clk;

architecture Behavioral of board_clk is

signal counter: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal var : std_logic := '0';

begin

 output <= var;

    process(boardclk)
    begin
        if rising_edge(boardclk) then
            counter <= counter + "00000000000000000000000000000001";
            if(counter = n) then
                
                var <= not var;

                counter <= (others => '0');
            end if;
        end if;
    end process;


end Behavioral;








