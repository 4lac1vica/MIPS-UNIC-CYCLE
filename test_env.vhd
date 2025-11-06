----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2025 09:06:52 PM
-- Design Name: 
-- Module Name: test_env - Behavioral
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

entity test_env is
    Port(
           sw : in std_logic_vector(2 downto 0);
           bt1 : in std_logic;
           bt0 : in std_logic;
           clk : in std_logic;
           cat : out std_logic_vector(6 downto 0);
      --     digits : out std_logic_vector(31 downto 0);
           an : out std_logic_vector(7 downto 0);
           led : out std_logic_vector(10 downto 0)
    );
end test_env;

architecture Behavioral of test_env is
component IFetch is
    port (
        jumpAddress : in std_logic_vector(31 downto 0);
        branchAdress : in std_logic_vector (31 downto 0);
        jump : in std_logic;
        PCSrc : in std_logic;
        instruction : out std_logic_vector(31 downto 0);
        out1 : out std_logic_vector(31 downto 0);
        clk : in std_logic;
        en : in std_logic;
        reset : in std_logic
    );
end component;

    
component Decoder is
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
end component;

component MEM is
    port(
        memWr : in std_logic;
        aluResIn : in std_logic_vector(31 downto 0);
        rd2 : in std_logic_vector(31 downto 0);
        clk : in std_logic;
        en : in std_logic;
        memData : inout std_logic_vector(31 downto 0);
        aluResOut : inout std_logic_vector(31 downto 0)
    );
end component;


component UC is
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
end component;

component EX is
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
end component;


component BranchUnit is
    port(
        branch : in std_logic;
        branchNot : in std_logic;
        zero : in std_logic;
        pcSrc : inout std_logic
    );
end component;

component JUnit is
    port(
        instr : in std_logic_vector(25 downto 0);
        pcnext :  in std_logic_vector(3 downto 0);
        ja : inout std_logic_vector(31 downto 0)
    );
end component;


component SSD1 is
    Port ( cat : out STD_LOGIC_VECTOR(6 downto 0);
           digits : in STD_LOGIC_VECTOR(31 downto 0);
           an : out STD_LOGIC_VECTOR(7 downto 0);
           clk : in STD_LOGIC);
end component;

component WriteBack is
port(
    memToReg :  in std_logic;
    aluRezOut : in std_logic_vector(31 downto 0);
    memData : in std_logic_vector(31 downto 0);
    writeBack : inout std_logic_vector(31 downto 0)
   );
    
end component;


component MPG is
    Port ( enable : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;



signal regDst : std_logic;
signal extOp : std_logic;
signal aluSrc : std_logic;
signal branch : std_logic;
signal branchNot : std_logic;
signal jump : std_logic;
signal aluOp : std_logic_vector(1 downto 0);
signal memWr :  std_logic;
signal memToReg : std_logic;
signal regWr :  std_logic;
signal en : std_logic;
signal instr : std_logic_vector(31 downto 0);
signal PC4 : std_logic_vector(31 downto 0);
signal rd1 : std_logic_vector(31 downto 0);
signal rd2 : std_logic_vector(31 downto 0);
signal extImm : std_logic_vector(31 downto 0);
signal func : std_logic_vector(5 downto 0);
signal sa : std_logic_vector(4 downto 0);
signal zero : std_logic;
signal ba : std_logic_vector(31 downto 0);
signal aluRes : std_logic_vector(31 downto 0);
signal aluResOut : std_logic_vector(31 downto 0);
signal memData : std_logic_vector(31 downto 0);
signal wb : std_logic_vector(31 downto 0);
signal ja : std_logic_vector(31 downto 0);
signal pcSrc : std_logic;
signal digits : std_logic_vector(31 downto 0);

begin
   
   --en <= bt0;
   
mpg10 : MPG port map(en, bt0, clk);
ife : IFetch port map(ja, ba, jump, pcSrc, instr, PC4, clk, en, bt1);
dec : Decoder port map(instr(25 downto 0), wb, clk, rd1, rd2, extImm, func, sa);
execution : EX port map(rd1, rd2, extImm, sa, func, PC4, ba, aluSrc, aluOp, aluRes, zero);
control : UC port map(instr(31 downto 26), regDst, extOp, aluSrc, branch, branchNot, jump, aluOp, memWr, memToReg,regWr);
memorie : MEM port map(memWr, aluRes, rd2, clk, en, memData, aluResOut);
writeB : WriteBack port map(memToReg, aluResOut, memData, wb);
jumpUnit : JUnit port map(instr(25 downto 0), PC4(31 downto 28), ja);  
branchU : BranchUnit port map(branch, branchNot, zero, pcSrc);

process(sw)
begin 
    case sw is 
        when "000" => digits <= instr;
        when "001" => digits <= PC4;
        when "010" => digits <= rd1;
        when "011" => digits <= rd2;
        when "100" => digits <= extImm;
        when "101" => digits <= aluRes;
        when "110" => digits <= memData;
        when "111" => digits <= wb;
        when others => 
    end case;
end process;


sevensegm : SSD1 port map(cat, digits, an ,clk);
   
led(10 downto 0) <= aluOP & regDst & extOP & aluSrc & branch & branchNot & jump & memWr & memToReg & regWr;


end Behavioral;
