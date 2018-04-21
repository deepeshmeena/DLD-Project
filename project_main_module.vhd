----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:16:23 04/13/2018 
-- Design Name: 
-- Module Name:    project_main_module - Behavioral 
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

entity project_main_module is
port( reset : IN std_logic ;
		clock : IN std_logic ;
		in1 : IN std_logic ;
		control : IN std_logic ;
		--next_data_in : IN std_logic ;
		--next_data_out : IN std_logic ;
		--Data_in : IN std_logic_vector(7 downto 0);
		Output_final : OUT std_logic_vector ( 7 downto 0) 
		);
end project_main_module;

architecture Behavioral of project_main_module is

component main_module is
    Port (
			  clock : in  STD_LOGIC;
           K : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
			  in_1 : in  STD_LOGIC;
			  ctrl : in  STD_LOGIC;
			  outpu : out STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

--component read_multiple_data_bytes is
--    Port (
--			  clk : in  STD_LOGIC;
--           reset : in  STD_LOGIC;
--           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
--           next_data : in  STD_LOGIC;
--           data_read : out  STD_LOGIC_VECTOR (31 downto 0)
--			  );
--end component;

component display_multiple_data_bytes is
    Port (
				clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            data_in : in  STD_LOGIC_VECTOR (31 downto 0);
            next_data : in  STD_LOGIC;
            data_out : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end component;


component board_clk is
    Port (	boardclk : IN std_logic;
				n : IN STD_LOGIC_VECTOR(31 downto 0);
				output: out std_logic
				);
end component;





signal out_rmdb,output_last_design : std_logic_vector (31 downto 0);
signal final_output : std_logic_vector (7 downto 0);
constant factor : std_logic_vector(31 downto 0):= "00000000101111101011110000100000";
constant key : std_logic_vector(31 downto 0) := "11001100110011001100110001101011";
signal newcl : std_logic;
--signal temp1 : std_logic;
--signal temp : std_logic := '0' ;
signal next_data ,temp3: std_logic := '0' ;
begin
brdclk : board_clk port map(clock,factor,newcl);
--rmdb : read_multiple_data_bytes port map(newcl,reset,Data_in,next_data_in,out_rmdb) ;
main_md : main_module port map(newcl,key,reset,in1,control,output_last_design);



process(newcl,reset)
 begin
  if (reset = '1') then
	--next_data <= '0';
	temp3 <= '0';
	
 elsif (rising_edge(newcl) and reset ='0') then
		if (next_data = '0') then 
		temp3 <= '1';
	--	next_data <= '1';
		elsif (next_data = '1') then
		--next_data <= '0';
		temp3 <= '0';
		end if;
 end if; 
 end process;
 next_data <= temp3;
 

dmdb : display_multiple_data_bytes port map (newcl,reset,output_last_design,next_data,final_output);

Output_final <= final_output ;

end Behavioral;

