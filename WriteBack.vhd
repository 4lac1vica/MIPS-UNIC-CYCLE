----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2025 07:55:16 PM
-- Design Name: 
-- Module Name: WriteBack - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WriteBack is

port(
    memToReg :  in std_logic;
    aluRezOut : in std_logic_vector(31 downto 0);
    memData : in std_logic_vector(31 downto 0);
    writeBack : inout std_logic_vector(31 downto 0)
   );
    
end WriteBack;

architecture Behavioral of WriteBack is
begin
    process(memToReg)
    begin 
        if memToReg = '0' then 
            writeBack <= aluRezOut;
        else 
            writeBack <= memData;
        end if;    
    end process;

end Behavioral;
