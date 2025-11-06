----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2025 05:28:07 PM
-- Design Name: 
-- Module Name: Decoder - Behavioral
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

entity Decoder is
    Port(
        instruction : in std_logic_vector(25 downto 0);
        wd1 : in std_logic_vector(31 downto 0);
        clk : in std_logic;
        rd1 : out std_logic_vector(31 downto 0);
        rd2 : out std_logic_vector(31 downto 0);
        extImm : out std_logic_vector(31 downto 0);
        func : out std_logic_vector(5 downto 0);
        sa : out std_logic_vector(4 downto 0) 
    );
end Decoder;
    
architecture Behavioral of Decoder is
    type reg_array is array(0 to 31) of std_logic_vector(31 downto 0);
    signal decoder : reg_array := (others => x"00000000"); 
    signal regWr : std_logic;
    signal regDst : std_logic;
    signal en : std_logic;
    signal extOp : std_logic;
begin

    rd1 <= decoder(conv_integer(instruction(25 downto 21)));
    rd2 <= decoder(conv_integer(instruction(20 downto 16)));
    
    process(clk)
    begin 
        if rising_edge(clk) then 
            if (en = '1') then 
                if regWr = '1' then 
                    if (regDst = '0') then 
                        decoder(conv_integer(instruction(20 downto 16))) <= wd1;
                    else 
                        decoder(conv_integer(instruction(15 downto 11))) <= wd1;
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    
    process(clk)
    begin
        if extOp = '0' then 
            extImm <= x"0000" & instruction(15 downto 0);
        else 
            if instruction(15) = '1' then 
                extImm <= x"1111" & instruction(15 downto 0);
            else 
                extImm <= x"0000" & instruction(15 downto 0);
            end if;
        end if;
    end process;
    
    func <= instruction(5 downto 0);
    sa <= instruction(10 downto 6);

end Behavioral;
