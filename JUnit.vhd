----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2025 08:00:05 PM
-- Design Name: 
-- Module Name: JUnit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity JUnit is
    port(
        instr : in std_logic_vector(25 downto 0);
        pcnext :  in std_logic_vector(3 downto 0);
        ja : inout std_logic_vector(31 downto 0)
    );
end JUnit;

architecture Behavioral of JUnit is
   
begin
    ja <= pcnext & instr & "00";
end Behavioral;
