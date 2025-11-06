----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2025 04:38:49 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
    port (
        instr : in std_logic_vector(5 downto 0);
        regDst : inout std_logic;
        extOp : inout std_logic;
        aluSrc : inout std_logic;
        branch : inout std_logic;
        branchNot : inout std_logic;
        jump : inout std_logic;
        aluOP : inout std_logic_vector(1 downto 0);
        memWr : inout std_logic;
        memToReg : inout std_logic;
        regWr: inout std_logic
    );
end UC;

architecture Behavioral of UC is
begin
    process(instr)
    begin 
        regDst <= '0';
        extOp <= '0';
        aluSrc <= '0';
        branch <= '0';
        jump <= '0';
        aluOP <= "00";
        memWr <= '0';
        memToReg <= '0';
        regWr <= '0';
        branchNot <= '0';       
        
        case instr is 
            when "000000" => RegDst <= '1'; RegWr <= '1'; aluOP  <= "00";
            when "001000" => RegWr <= '1'; extOp <= '1'; aluSrc <= '1'; aluOP <= "01";
            when "100011" => extOp <= '1'; aluSrc <= '1'; RegWr <= '1'; memToReg <= '1'; aluOp <= "01";
            when "000100" => extOp <= '1'; branch <= '1'; aluOp <= "10";
            when "000101" => extOp <= '1'; branchNot <= '1'; aluOp <= "10";
            when "001100" => extOp <= '1'; regWr <= '1'; aluOp <= "11";
            when "000010" => extOp <= '1'; jump <= '1';
            when others => end case;
    end process;
end Behavioral;
