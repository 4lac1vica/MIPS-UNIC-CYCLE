----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2025 06:26:26 PM
-- Design Name: 
-- Module Name: EX - Behavioral
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

entity EX is
    port (
        rd1 : in std_logic_vector(31 downto 0);
        rd2 : in std_logic_vector(31 downto 0);
        extImm : in std_logic_vector(31 downto 0);
        sa : in std_logic_vector(4 downto 0);
        func : in std_logic_vector(5 downto 0);
        pc4 : in std_logic_vector(31 downto 0);
        ba : inout std_logic_vector(31 downto 0);
        aluSrc : in std_logic;
        aluOp : in std_logic_vector(1 downto 0);
        aluRes : out std_logic_vector(31 downto 0);
        zero : inout std_logic
    );
end EX;

architecture Behavioral of EX is
    signal aluCtrl : std_logic_vector(2 downto 0);
    signal aluRez1 : std_logic_vector(31 downto 0);
begin
    zero <= '0';
    process(aluOp, func)
    begin
        case AluOp is 
            when "00" => 
                case func is
                    when "000001" => aluCtrl <= "000";
                    when "000010" => aluCtrl <= "010";
                    when "000100" => aluCtrl <= "100";
                    when others => 
                end case;  
            when "01" => aluCtrl <= "000";
            when "10" => aluCtrl <= "001";
            when "11" => aluCtrl <= "011";
            when others =>    
        end case;    
    end process;
    
    
    process(aluCtrl, aluSrc, rd1, sa)
    begin
        if (aluSrc = '0') then 
            case aluCtrl is 
               when "000" => aluRez1 <= rd1 + rd2;
               when "010" => aluRez1 <= rd1 xor rd2;
               when "100" => aluRez1 <= to_stdlogicvector(to_bitvector(rd2) srl conv_integer(sa));
               when others =>
            end case;   
                 
        else 
            case aluCtrl is 
                when "000" => aluRez1 <= rd1 + extImm;
                when "001" => aluRez1 <= rd1 - extImm;
                when "011" => aluRez1 <= rd1 and extImm;
                when others => 
            end case;     
        end if;
    end process;
    
  aluRes <= aluRez1;
  
  
  process(aluRez1)
  begin 
    if (aluRez1 = x"000000000") then 
        zero <= '1'; 
    end if;  
  end process;
  
  
  ba <= (extImm(29 downto 0) & "00") + pc4;
  
  
end Behavioral;
