----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2025 10:31:40 AM
-- Design Name: 
-- Module Name: IFetch - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFetch is
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
end IFetch;

architecture Behavioral of IFetch is
    signal q : std_logic_vector(31 downto 0);
    signal mux1 : std_logic_vector(31 downto 0);
    signal d : std_logic_vector(31 downto 0);
    signal input : std_logic_vector(31 downto 0);
    signal suma : std_logic_vector(31 downto 0);
    type ROM is array(0 to 31) of std_logic_vector(31 downto 0);
    signal mem : ROM := (
            

            
            
        b"001000_00000_01000_0000_0000_0000_0000",   --20080000  -- addi $8,$0,$0
        b"001000_00000_01001_0000_0000_0010_0000",   --20090020  -- addi $9,$0,32
        b"001000_00000_00010_0000_0000_0000_0000",   --20020000  -- addi $2,$0,$0
        b"000100_01001_00000_0000_0000_0000_1110",   --1120000E  -- beq $9,$0,14
        
        
        b"100011_00000_01010_0000_0000_0000_0000",   --8C0A0000  -- lw $10, 0($0)
        b"000000_00011_00000_01011_00000_100000",    --605820    -- add $11, $3, $0
        b"001000_01100_00000_0000_0000_0000_0000",   --21800000  -- addi $12, $0, 0
        b"000100_01011_00000_0000_0000_0000_0000",   --11600000  -- beq $11, $0, 5
        
        
        b"001100_01011_01101_0000_0000_0000_0001",   --316D0001  -- andi $13, $11, 1
        b"000000_01011_01011_0000_0000_0000_0110",   --16B0006   -- xor $12, $12, $6
        b"000000_00000_01011_01011_00001_000010",    --B5842     -- srl $11, $11, 1
        b"000010_0000_0000_0000_0000_0000_001000",   --8000008   -- j 8
        
        b"000101_01100_0000_0000_0000_0000_00010",   --15800002  -- bne $12, $0, 2
        b"000000_00010_01010_00010_00000_100000",    --4A1020    -- add $2, $2, $10
        b"001000_01000_01000_0000_0000_0000_0100",   --21080004  -- addi $8, $8, 4 
        b"001000_01001_01001_1111_1111_1111_1111",   --2129FFFF  -- addi $9, $9, -1
        
        
        b"000010_0000_0000_0000_0000_0000_000100",  --8000004   -- j 4
        b"001000_00000_00010_0000_0000_0000_1010",  --2002000A  -- $2, $0, 10
        others => x"00000000"
    );
    signal romAdress : std_logic_vector(4 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then 
            q <= x"00000000";
        elsif rising_edge(clk) then 
            if (en = '1') then
                q <= d;
            end if;    
        end if;
    end process;

    process(jump)
    begin 
        case jump is 
            when '1' => d <= jumpAddress;
            when '0' => d <= mux1;
            when others => 
        end case;  
    end process;
    
    process(PCSrc)
    begin 
    case PCSrc is 
        when '1' => mux1 <= branchAdress;
        when '0' => mux1 <= suma;
        when others => 
    end case;
    end process;
    
    romAdress <= q(6 downto 2);
    
    
    suma <= q + 4;
    
    
    out1 <= suma;
    instruction <= mem(conv_integer(romAdress));
     
end Behavioral;
