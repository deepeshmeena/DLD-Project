--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:43:34 04/19/2018
-- Design Name:   
-- Module Name:   /home/deepesh/STUDY/dld/final_project/final_testbench.vhd
-- Project Name:  final_project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: project_main_module
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY final_testbench IS
END final_testbench;
 
ARCHITECTURE behavior OF final_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT project_main_module
    PORT(
         reset : IN  std_logic;
         clock : IN  std_logic;
         in1 : IN  std_logic;
         control : IN  std_logic;
         Output_final : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clock : std_logic := '0';
   signal in1 : std_logic := '0';
   signal control : std_logic := '0';

 	--Outputs
   signal Output_final : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: project_main_module PORT MAP (
          reset => reset,
          clock => clock,
          in1 => in1,
          control => control,
          Output_final => Output_final
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.=
		reset <= '1';
      wait for 100 ns;	
			reset <= '0' ;
         in1 <= '1' ;
         control <= '1' ;

      wait for clock_period*10;

      -- insert stimulus here 
		

      wait;
   end process;

END;
