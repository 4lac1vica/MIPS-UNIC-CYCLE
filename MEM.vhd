----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2025 07:38:33 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
    port(
        memWr : in std_logic;
        aluResIn : in std_logic_vector(31 downto 0);
        rd2 : in std_logic_vector(31 downto 0);
        clk : in std_logic;
        en : in std_logic;
        memData : inout std_logic_vector(31 downto 0);
        aluResOut : inout std_logic_vector(31 downto 0)
    );
end MEM;

architecture Behavioral of MEM is
    type reg_array is array (0 to 63) of std_logic_vector(31 downto 0);
    signal mem : reg_array := (others => x"00000000");
begin
    process(clk)
    begin 
        if rising_edge(clk) then
            if en = '1' and memWr = '1' then 
                mem(conv_integer(aluResIn(7 downto 2))) <= rd2; 
            end if;    
        end if;
    end process;
    
    memData <= mem(conv_integer(aluResIn(7 downto 2)));
   aluResOut <= aluResIn;
end Behavioral;
