----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:20:25 03/20/2018 
-- Design Name: 
-- Module Name:    state_machine - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity state_machine is
port (
		in1 : in std_logic := '0';
		ctrl : in std_logic := '0'; 
		clk : in std_logic := '0';
		output1 : out std_logic := '0';
		output2 : out std_logic := '0';
		output3 : out std_logic := '0'
		);
end state_machine;

architecture Behavioral of state_machine is

signal op1,op2,op3 : STD_LOGIC_VECTOR (1 downto 0) := (others => '0'); 
signal input1,input2,input3 : STD_LOGIC := '0';
signal out1_1,out1_2,out1_3,out0_1,out0_2,out0_3 : STD_LOGIC := '0';

begin
--process for sm1

process(clk)
begin
if (rising_edge(clk)) then 
	if(input1 ='1' and op1="00") then op1 <= "01";
	elsif(input1 ='0' and op1="00") then op1 <= "11";
	elsif(input1 ='1' and op1="01") then op1 <= "10";
	elsif(input1 ='0' and op1="01") then op1 <= "00";
	elsif(input1 ='1' and op1="10") then op1 <= "11";
	elsif(input1 ='0' and op1="10") then op1 <= "01";
	elsif(input1 ='1' and op1="11") then op1 <= "00";
	elsif(input1 ='0' and op1="11") then op1 <= "10";
	end if;
end if ;
end process;
output1 <= op1(1);
input2 <= op1(0);

--process for sm2
process(clk)
begin
if (rising_edge(clk)) then 
	if(input2 ='1' and op2="00") then op2 <= "01";
	elsif(input2 ='0' and op2="00") then op2 <= "11";
	elsif(input2 ='1' and op2="01") then op2 <= "10";
	elsif(input2 ='0' and op2="01") then op2 <= "00";
	elsif(input2 ='1' and op2="10") then op2 <= "11";
	elsif(input2 ='0' and op2="10") then op2 <= "01";
	elsif(input2 ='1' and op2="11") then op2 <= "00";
	elsif(input2 ='0' and op2="11") then op2 <= "10";
end if;
end if ;

end process;
output2 <= op2(1);
input3 <= op2(0);

--process for sm3

process(clk)
begin
if (rising_edge(clk)) then 
	if(input3 ='1' and op3="00") then op3 <= "01";
	elsif(input3 ='0' and op3="00") then op3 <= "11";
	elsif(input3 ='1' and op3="01") then op3 <= "10";
	elsif(input3 ='0' and op3="01") then op3 <= "00";
	elsif(input3 ='1' and op3="10") then op3 <= "11";
	elsif(input3 ='0' and op3="10") then op3 <= "01";
	elsif(input3 ='1' and op3="11") then op3 <= "00";
	elsif(input3 ='0' and op3="11") then op3 <= "10";
	end if;
end if ;

end process;

output3 <= op3(1);
out1_3 <= op3(0);

-- process for mux

--process(clk)
--begin
	--if(rising_edge(clk)) then 
		--if (ctrl = '0') then input1 <= in1;
			--else input1 <= out1_3;
		--end if;
	--end if;
--end process;


input1 <= in1 when ctrl = '0' else 
     out1_3  ; 


end Behavioral;

