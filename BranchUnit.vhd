----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2025 08:13:44 PM
-- Design Name: 
-- Module Name: BranchUnit - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BranchUnit is
    port(
        branch : in std_logic;
        branchNot : in std_logic;
        zero : in std_logic;
        pcSrc : inout std_logic
    );
end BranchUnit;

architecture Behavioral of BranchUnit is
    
begin
    pcSrc <= (branch and zero) or (branchNot and (not zero)); 
end Behavioral;
