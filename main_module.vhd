----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:38:46 03/27/2018 
-- Design Name: 
-- Module Name:    main_module - Behavioral 
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

entity main_module is
port(
			  clock : in  STD_LOGIC;
           K : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
			  in_1 : in  STD_LOGIC;
			  ctrl : in  STD_LOGIC;
			  outpu : out STD_LOGIC_VECTOR (31 downto 0)
			  );
end main_module;

architecture Behavioral of main_module is

component state_machine is
    Port (
			in1 : in std_logic ;
			ctrl : in std_logic ; 
			clk : in std_logic ;
			output1 : out std_logic ;
			output2 : out std_logic ;
			output3 : out std_logic 
			  );
end component;
component conditional is
    Port (
			a : in std_logic ;
			b : in std_logic ;
			c: in std_logic ;
			--reset: in std_logic ;
			--clk : in std_logic;
			d : out std_logic_vector(7 downto 0)
			  );
end component;

component read_multiple_data_bytes is
    Port (
				clk : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				data_in : in  STD_LOGIC_VECTOR (7 downto 0);
				next_data : in  STD_LOGIC;
				data_read : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

component encrypter is
    Port (
				P : in  STD_LOGIC_VECTOR (31 downto 0);
				K : in  STD_LOGIC_VECTOR (31 downto 0);
				clock : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				enable : in  STD_LOGIC;
				C : out  STD_LOGIC_VECTOR (31 downto 0)
      
			  );
end component;

signal out1,out2,out3 : std_logic;
signal next_data ,temp1: std_logic := '0';
signal cd_out : std_logic_vector (7 downto 0) := "00000000";
signal read_out,c_out : std_logic_vector (31 downto 0);
constant enable : std_logic := '1';
begin
 s_m : state_machine port map (in_1,ctrl,clock,out1,out2,out3);
 c_d : conditional port map (out1,out2,out3,cd_out);
 
 
 process(clock)
 begin
 if (rising_edge(clock) ) then
		if (next_data = '0') then 
		temp1 <= '1';
		else temp1 <= '0';
		end if;
 end if; 
 end process;
 next_data <= temp1;
 
 read_mult : read_multiple_data_bytes port map (clock,reset,cd_out,next_data,read_out);
 
 en : encrypter port map (read_out,K,clock,reset,enable,c_out);
 
 outpu <= c_out;
end Behavioral;
