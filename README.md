# MIPS Unic Cycle

# Quick Descripton


Tools : Xilinx Vivado 2024.1

Tested on Nexys A7. 

## EN
This project was developed for the Computer Architecture course. The goal of the project is the implementation in VHDL of a 32-bit MIPS processor using a Single-Cycle architecture.

A Single-Cycle processor executes each instruction completely in a single clock cycle. The architecture follows the classic MIPS model and includes the following components:

1) **Instruction Fetch (IF)**

In the MIPS Single-Cycle architecture, the Instruction Fetch stage **is responsible for reading an instruction from the instruction memory** using a value called the **Program Counter (PC)**. In the same clock cycle, the PC is updated with **PC + 4**, preparing the address of the next instruction.

An important aspect to mention is that the instructions are written in MIPS Assembly and converted to binary according to the instruction type. Each instruction can be one of the following types:

- R-type instructions – arithmetic and logical operations (e.g. add, sub, shl);

- I-type instructions – immediate-type operations (e.g. andi, ld, st);

- J-type instructions – jump operations (e.g. j, jne).

Below is the VHDL implementation of the Instruction Fetch module, which includes:

 - the PC register;

 - increment logic (PC + 4);

 - support for branch and jump instructions;

 - instruction memory implemented as a ROM.

  ```
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
```

2) **Instruction Decode**

   In the MIPS Single-Cycle architecture, the Instruction Decode stage interprets the instruction fetched in the Instruction Fetch stage and prepares the data required for execution.

   During this stage:

      - the control unit decodes the opcode field and generates the appropriate control signals (such as RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, Branch, Jump);

      - the register file is accessed, and operands are read based on the rs and rt fields.

   For I-type instructions, the immediate value is extended to 32 bits. Additionally, branch addresses can be computed using PC + 4 and the immediate offset.

   The Instruction Decode stage does not use pipelining; all operations are performed in the same clock cycle, according to the Single-Cycle architecture.

 ```
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
```

Code Explanation

a) **Register File**

   - implemented as an **array of 32 registers**, each 32 bits wide;

   - registers are **read combinationally** using:

      - **rs** → instruction(25 downto 21)

      - **rt** → instruction(20 downto 16)

   - outputs are available on **rd1** and **rd2**

b) **Register Write**

   - performed synchronously with the clock, on the **rising edge**, if enabled:

      - **regWr** enables writing;

      - **regDst** selects the destination register:

         - **rt** for **I-type** instructions;

         - **rd** for **R-type** instructions;

   - **wd1** represents the data written to the register.

c) **Immediate Extension**

   - for **I-type** instructions, the 16-bit **immediate field is extended to 32 bits using extOp**:

      - **extOp = 0** → zero extension;

      - **extOp = 1** → sign extension.

d) **Auxiliary Execution Fields**

**func** → function field (instruction(5 downto 0)), used by the ALU Control for **R-type instructions**;

**sa** → shift amount field (instruction(10 downto 6)), used for **shift operations**.


3) **Execution (EX)**

   The EX module implements the Execute stage of the MIPS Single-Cycle architecture. This stage is responsible for performing arithmetic and logical operations, computing branch addresses, and evaluating branch conditions.

```
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
```

a) **ALU Control**

   - **ALU control** signals are generated based on:

      - **aluOp** – signal from the **main control unit**;

      - **func** – function field for **R-type instructions**.

   - These signals determine the operation executed by the ALU.

b) **Operand Selection**

   - the **ALU** receives:

      - **the first operand from rd1**;

      - the second operand depending on aluSrc:

         - **rd2** for R-type instructions;

         - **extImm** for I-type instructions.

c) **ALU Operations**

   - supported operations:

      - **ADD**

      - **SUB**

      - **AND**

      - **XOR**

      - **SRL** (shift right logical) using the sa field.

d) **Zero Signal**

   - the **zero signal** is set when the ALU result equals **zero**;

   - used to evaluate **branch instructions (beq, bne)**.

e) **Branch Address Calculation**

   - the **branch address** is computed by:

      - left-shifting the immediate value by 2 bits (**extImm << 2**);

      - adding it to **PC + 4**.
   
4) **Memory**

   The **MEM module** implements the **Memory Access stage** of the MIPS Single-Cycle architecture. This stage is mainly used by instructions that **access data memory, especially load and store**.
```
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
```
**Code Explanation**

 - memory addressing uses **aluResIn(7 downto 2)**, assuming data is aligned on **4-byte boundaries**.

a) **Store Operations**

   - data is written to memory:

   - synchronously with the clock;

   - on the rising edge;

   - when en and memWr are asserted.

b) **Load Operations**

   - **memory read is performed combinationally**;

   - the read value is available on **memData**, later used in the Write Back stage.

c) **ALU Result Propagation**

   - the **ALU** result from the **Execute stage** is forwarded **via aluResOut** to the **Write Back stage** when memory is **not** accessed.

```
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
```




5) **Write Back (WB)**

The **WriteBack module** implements the **final stage** of the **MIPS Single-Cycle architecture**. Its role is **to select the final value that will be written into the register file**.

```
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
```
**Code Explanation**

a) **Data Source Selection**

   - depending on the **instruction type**, the data written to the register can come from:

      - **ALU** result (**aluRezOut**):

      - **arithmetic and logical R-type instructions**;

      - **I-type** instructions that do not access memory;

   - memory data (memData):

   - load instructions.

   - selection is controlled by **memToReg**:

      - **memToReg = 0 → ALU result**;

      - **memToReg = 1→ memory data**.

b) **Write Back Output**

   - **writeBack** represents the final value sent to the register file;

   - **writing occurs in the Instruction Decode stage**;

   - this stage is **purely combinational**, implemented using a **multiplexer**.

6) **Auxiliary Modules**
   
      During the implementation, several auxiliary modules were used to support the main components and testing.

   1) **JUnit (Jump Unit)**

      This module implements the logic required to compute the jump address in the MIPS Single-Cycle architecture.

```
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
```
   
   It is used by all J-type instructions.

   For jump instructions:

   - the target address is not computed by the ALU;

   - it is formed by concatenating fields from the instruction and the upper bits of PC + 4:

      - most significant bits from PC + 4;

      - next 26 bits from instr(25 downto 0);

      - last two bits are 00, since instructions are aligned on 4 bytes.
    
   2) **BranchUnit**
      The BranchUnit module implements branch decision logic for beq and bne instructions.

      It decides whether the Program Counter should be updated with the branch address or continue sequential execution (PC + 4).

      The decision is based on:

         - control signals:

         - branch → active for beq;

         - branchNot → active for bne;

         - the zero signal from the ALU.
     
```
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
```

   **PCSrc Signal**

   The BranchUnit module implements branch decision logic for beq and bne instructions.

   It decides whether the Program Counter should be updated with the branch address or continue sequential execution (PC + 4).

3) **Control Unit(UC)**
   - Module where all control signals for the processor are generated based on the instruction opcode.

  ```
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
```

 4) **SSD1**
     - VHDL module used to drive the 7-segment display available on the Nexys A7 board.
       
```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SSD1 is
    Port ( cat : out STD_LOGIC_VECTOR(6 downto 0);
           digits : in STD_LOGIC_VECTOR(31 downto 0);
           an : out STD_LOGIC_VECTOR(7 downto 0);
           clk : in STD_LOGIC);
end SSD1;

architecture Behavioral of SSD1 is

signal digit : STD_LOGIC_VECTOR(3 downto 0);
signal cnt : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
signal sel : STD_LOGIC_VECTOR(2 downto 0);

begin

    counter : process(clk) 
    begin
        if rising_edge(clk) then
            cnt <= cnt + 1;
        end if;
    end process;

    sel <= cnt(16 downto 14);

    muxCat : process(sel, digits)
    begin
        case sel is
            when "000" => digit <= digits(3 downto 0);
            when "001" => digit <= digits(7 downto 4);
            when "010" => digit <= digits(11 downto 8);
            when "011" => digit <= digits(15 downto 12);
            when "100" => digit <= digits(19 downto 16);
            when "101" => digit <= digits(23 downto 20);
            when "110" => digit <= digits(27 downto 24);
            when "111" => digit <= digits(31 downto 28);
            when others => digit <= (others => 'X');
        end case;
    end process;

    muxAn : process(sel)
    begin
        case sel is
            when "000" => an <= "11111110";
            when "001" => an <= "11111101";
            when "010" => an <= "11111011";
            when "011" => an <= "11110111";
            when "100" => an <= "11101111";
            when "101" => an <= "11011111";
            when "110" => an <= "10111111";
            when "111" => an <= "01111111";
            when others => an <= (others => 'X');
        end case;
    end process;

    with digit SELect
        cat <= "1000000" when "0000",   -- 0
               "1111001" when "0001",   -- 1
               "0100100" when "0010",   -- 2
               "0110000" when "0011",   -- 3
               "0011001" when "0100",   -- 4
               "0010010" when "0101",   -- 5
               "0000010" when "0110",   -- 6
               "1111000" when "0111",   -- 7
               "0000000" when "1000",   -- 8
               "0010000" when "1001",   -- 9
               "0001000" when "1010",   -- A
               "0000011" when "1011",   -- b
               "1000110" when "1100",   -- C
               "0100001" when "1101",   -- d
               "0000110" when "1110",   -- E
               "0001110" when "1111",   -- F
               (others => 'X') when others;

end Behavioral;
```
**Code Notes:**

 - acts as a decoder using active-low logic;

 - each digit consists of 7 segments labeled from a to g.

5) **MPG(MonoPulse Generator)**
   
   - VHDL module used to generate a single clock pulse from a push button.
  
 ```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MPG is
    Port ( enable : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal cnt_int : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
signal Q1, Q2, Q3 : STD_LOGIC;

begin

    enable <= Q2 and (not Q3);

    process(clk)
    begin
        if clk='1' and clk'event then
            cnt_int <= cnt_int + 1;
        end if;
    end process;

    process(clk)
    begin
        if clk'event and clk='1' then
            if cnt_int(17 downto 0) = "111111111111111111" then
                Q1 <= btn;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if clk'event and clk='1' then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
    end process;

end Behavioral;
```

 6) **Test Module**
    In this module, all previously described components are connected together.

    It represents the top-level testing environment used to validate the processor on hardware.
```
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
```


## RO 

Acest proiect a fost realizat pentru cursul de Arhitectura Calculatoarelor. Acest proiect are ca scop implementarea in VHDL a unui procesor MIPS pe 32 de biti, avand arhitectura de tip Unic Cycle.
Un astfel de procesor executa o instructiune complet la un singur ciclu de ceas. Arhitectura respecta modelul clasic de MIPS si include urmatoarele componente:

1) **Instruction Fetch**
   
   In arhitectura MIPS Single Cycle, etapa Instruction Fetch are ca scop citirea unei instructiuni din memoria de instructiuni, folosind o valoare denumita "Program Counnter" (PC). In acelasi ciclu de ceas, PC-ul este actualizat cu PC+4,
   pregatind adresa urmatoarei instructiuni. Un alt lucru important de mentionat este faptul ca instructiunile sunt scrise in MIPS Assembly, fiind convertite la binar folosind un protcol de convertire, in functie de tipul instructiunii.    Fiecare instructiune poate sa fie de 3 tipuri:
    - Instructiuni de tip R -> Pentru operatii aritmetico-logice (ex add, sub, shl).
    - Instructiuni de tip I -> Pentru operatii de tip immediate (ex andi, ld, st).
    - Instructiuni de tip J -> Pentru operatii de tip jump (ex j, jne).
      
   Mai jos este prezentata implementarea in VHDL a modulului Instruction Fetch, care include:
    - registrul PC;
    - logica de incrementare (PC + 4);
    - suport pentru instructiunile de branch si de jump 
    - memoria instructiunilor implementata ca o memorie ROM 
   
  ```
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
```

2) **Instruction Decode**

   In arhitectura MIPS Single Cycle, etapa de Instruction Decode are rolul de a interpreta instructiunea citita in etapa de Instruction Fetch si de a pregati datele necesare executiei.
   In aceasta etapa, unitatea de control decodifica campul opcode al instructiunii si genereaza semnalele de control corespunzatoare (precum **RegWrite**, **ALUSrc**, **MemRead**, **MemWrite**, **MemToReg**, **Branch**, **Jump**). In paralel, blocul de registre este accesat, iar operanzii sunt cititi pe baza campurilor **rs** si **rt**.

   Pentru instructiunile de tip **I**, valoarea imediata este **extinsa la 32 de biti**. De asemenea, in aceasta etapa se pot calcula adresele pentru ramificatii, folosind valoarea **PC + 4** si offsetul imediat.

   Etapa **Instruction Decode** nu utilizeaza pipeline, toate operatiile fiind realizate in acelasi ciclu de ceas, conform arhitecturii **Single Cycle**.


```
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
```
Explicatii ale codului: 

a) Fisierul de registrii este implementat ca un array de 32 de registre pe 32 de biti:
   - Citirea registrelor se face combinational, folosind campurile:
        - **rs** -> **instruction(25 downto 21)**
        - **rt** -> **instruction(20 downto 16)**
   - Valorile citite sunt disponibile pe iesirile **rd1** si **rd2**

b) Scrierea in registrul de fisiere se face **sincron cu ceasul**, pe **front crescator**, daca semnalele permit acest lucru:
   - **regWr** -> activeaza scrierea;
   - **regDst** -> selecteaza registrul destinatie:
        - **rt** pentru instructiuni de tip **I**;
        - **rd** pentru instructiuni de tip **R**;
   - **wd1** -> datele care se vor scrie in registru  

c) Extinderea valorii imediate 
   - Pentru instructiunile de tip **I**, campul imediat de 16 biti este extins la 32 de biti, in functie de semnalul **extOp**:
        - **extOp** = 0 -> facem extindere cu 0;
        - **extOp** = 1 -> facem ***sign extend*;

d) Campuri auxiliare pentru executie
   - **func** -> campul **function(instruction(5 downto 0))**, utilizat de **ALU Control** pentru instructiunile de tip R
   - **sa** -> campul **shift amount(instruction(10 downto 6))**, utilizat pentru instructiunile de shift.



3) **Execute**

   Modulul **EX** implementeaza etapa de execute in arhitectura **MIPS Unic Cycle**. Aceasta etapa responsabila de efectuarea operatiilor aritmetice si logice, de calculul adreselor instructiunilor de tip ***branch*,
   precum si evaluarea conditiilor de ramificare.

   

   

```
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
```
Explicatii ale codului: 

a) **ALU Control**
   - Semnalele **ALU Control** sunt generate pe baza combinatiei dintre:
        - **aluOp** - semnal provenit de la unitatea de control principala;
        - **func** - campul **function** al instructiunilor de tip R;
     Aceste semnale determina ce operatie executa ALU. 

b) **Selectia Operanzilor**
   - ALU-ul primeste:
        - primul operand din **rd1**;
        - al doilea operand in functie de **aluSrc**:
             - **rd2** pentru instructiuni de tip **R**;
             - **extImm** pentru instructiuni de tip **I**;
         
c) **Operatii ALU**
   - ALU-ul executa operatiile aritmetice si logice in functie de **aluCtrl**:
        - **ADD** - adunare
        - **SUB** - scadere
        - **AND** - operatie logica
        - **XOR** - operatie logica
        - **SRL** - **shift right logical* folosind campul **sa**

d) **Semnalul Zero**
   - Semnalul de zero este setat atunci cand rezultatul ALU este 0. Acesta este folosit pentru evaluarea instructiunilor de tip **branch**(**beq* si **bne*);

e) **Calculul adresei de branch**

   - Adresa de ramificare este calculata prin:
        - deplasarea la stanga cu 2 biti a valorii imediate( **extImm << 2** );
        - adunarea cu **PC + 4**


4) **Memory**

   Modulul **MEM** implementeaza etapa **Memory Access** din arhitectura **MIPS Single Cycle**. Aceasta etapa este utilizata in principal de instructiunile care acceseaza memoria de date, in special **load** si **store**.
```
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
```

Explicatii ale codului: 


-> adresarea memoriei se face folosind bitii **aluResIn(7 downto 2)**, presupunand date aliniate pe 4 octeti.

a) **Operatii de scriere (store)**
   - pentru instructiunile de tip **store**, scrierea in memoria de date se face:
        - **sincron cu ceasul**
        - **pe front crescator**
        - daca semnalele **en** si **memWr** sunt active

b) **Operatii de citire**
   - citirea din memoria de date se face **combinational**, iar valoarea citita este disponibila pe iesirea **memData**. Aceasta este utilizata ulterior in etapa **Write Back*.

c) **Propagarea rezultatului ALU**
   - Rezultatul calculat in etapa **Execute** este propagat mai departe prin rezultatul semnalului **aluResOut**, pentru a fi utilizat in etapa **Write Back**, in cazul in care instructiunea nu acceseaza memoria


5) **Write Back**

   - Modulul **WriteBack** implementeaza pasul cu acelasi nume din arhitectura **MIPS Unic Cycle**. Aceasta etapa are rolul de a selecta valoarea finala in care va fi scrisa in fisierul de registre.

```
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
```
Explicatii ale codului : 

a) **Selectia sursei de date**
   - In functie de tipul instructiunii executate, datele care trebuie sa fie scrise in registru pot sa provina din doua surse:
        - **Rezultatul ALU** sau **aluRezOut**
             - pentru instructiunile aritmetice si logice (**de tip R**);
             - pentru instructiunile de tip **I** care nu acceseaza memoria
        - **Datele citite din memoria de date (memData)**
             - pentru instructiunile de tip **load**
   - Selectia intre cele doua surse se face prin intermediul semnalului de control **memToReg**:
        - *memToReg = 0* -> se calculeaza rezultatul ALU
        - *memToReg = 1* -> se selecteaza datele din memorie
          
b) **Iesirea din Write Back**
   - Semnalul *writeBack* reprezinta valoarea finala care este trimisa catre fisierul de registre, unde va fi scrisa in registrul destinatie in etapa de **Instruction Decode**
   - Aceasta etapa nu realizeaza operatii secventiale si nu utilizeaza ceasul, selectia fiind realizata **combinational**, printr-un multiplexor

6) **Module auxiliare**

   Pe parcursul implementarii am folosit mai multe module care sa ma ajute sa implementez componentele principale, sau sa ma ajute sa testez

   1) **JUnit**

      - Acest modul este foarte util pentru a realiza Jump-ul. Acest modul implementeaza logica necesara pentru calcului adresei de salt in arhitectura **MIPS Single Cycle**. Acesta este utilizat de toate instructiunile de tip **J**.
     
```
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
```
- In instructiunile de tip **jump**, adresa tinta nu este calculata de **ALU**, ci este formata prin concatenarea unor campuri din instructiune cu bitii superiori ai adresei **urmatoarei instructiuni**.
- In arhitectura MIPS, adresa de jump se construieste astfel:
     - cei mai semnificativi biti provin de la **PC + 4**
     - urmatorii **26 de biti** provin de la campul **instr(25 downto 0)**
     - ultimii doi biti sunt **00**, deoarece avem instructiuni aliniate pe **4 bytes**.

 2) **BranchUnit**
    - Modulul **BranchUnit** implementeaza logica de decizie pentru instructiunile de tip **branch** in arhitectura **MIPS Single Cycle**, precum **beq** sau **bne**.
    - Modulul are rolul de a evalua anumite **conditii** pentru a decide daca **Program Counter-ul** va fi actualizat cu adresa de ramificare sau va continua executia secventiala (**PC + 4**).
    - Decizia de ramificare este luata pe baza :
         - semnalelor de control generate de unitatea de control:
              - **branch** -> activ pentru instructiunile de tip **beq**;
              - **branchNot** -> activ pentru instructiunile de tip **bne**;
         - semnalului **zero**, furnizat de **ALU** in etapa **Execute**.
```
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
```

Explicatii ale codului : 

**Semnalul PCSrc**
- semnalul **pcSrc** controleaza multiplexorul din etapa **Instruction Fetch**, care selecteaza urmatoarea valoare a PC-ului.
   - **pcSrc = 0** -> PC <- PC + 4;
   - **pcSrc = 1** -> PC <- **adresa de branch calculata in EX**
 
   3) **UC**
      - Modul unde am initializat toate semnalele pentru toate componentele
```
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
```

   4) **SSD1**

      - modul **VHDL** pentru a folosi afisorul 7 segmente integrat in placuta Nexys A7.

```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SSD1 is
    Port ( cat : out STD_LOGIC_VECTOR(6 downto 0);
           digits : in STD_LOGIC_VECTOR(31 downto 0);
           an : out STD_LOGIC_VECTOR(7 downto 0);
           clk : in STD_LOGIC);
end SSD1;

architecture Behavioral of SSD1 is

signal digit : STD_LOGIC_VECTOR(3 downto 0);
signal cnt : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
signal sel : STD_LOGIC_VECTOR(2 downto 0);

begin

    counter : process(clk) 
    begin
        if rising_edge(clk) then
            cnt <= cnt + 1;
        end if;
    end process;

    sel <= cnt(16 downto 14);

    muxCat : process(sel, digits)
    begin
        case sel is
            when "000" => digit <= digits(3 downto 0);
            when "001" => digit <= digits(7 downto 4);
            when "010" => digit <= digits(11 downto 8);
            when "011" => digit <= digits(15 downto 12);
            when "100" => digit <= digits(19 downto 16);
            when "101" => digit <= digits(23 downto 20);
            when "110" => digit <= digits(27 downto 24);
            when "111" => digit <= digits(31 downto 28);
            when others => digit <= (others => 'X');
        end case;
    end process;

    muxAn : process(sel)
    begin
        case sel is
            when "000" => an <= "11111110";
            when "001" => an <= "11111101";
            when "010" => an <= "11111011";
            when "011" => an <= "11110111";
            when "100" => an <= "11101111";
            when "101" => an <= "11011111";
            when "110" => an <= "10111111";
            when "111" => an <= "01111111";
            when others => an <= (others => 'X');
        end case;
    end process;

    with digit SELect
        cat <= "1000000" when "0000",   -- 0
               "1111001" when "0001",   -- 1
               "0100100" when "0010",   -- 2
               "0110000" when "0011",   -- 3
               "0011001" when "0100",   -- 4
               "0010010" when "0101",   -- 5
               "0000010" when "0110",   -- 6
               "1111000" when "0111",   -- 7
               "0000000" when "1000",   -- 8
               "0010000" when "1001",   -- 9
               "0001000" when "1010",   -- A
               "0000011" when "1011",   -- b
               "1000110" when "1100",   -- C
               "0100001" when "1101",   -- d
               "0000110" when "1110",   -- E
               "0001110" when "1111",   -- F
               (others => 'X') when others;

end Behavioral;
```

Explicatii legate de cod:
   - Este un fel de **decodificator**, deci prin urmare functioneaza in **logica negativa**.
   - Fiecare cifra este alcatuita din 8 segmente, notate cu litere de la a la g. Fiecare **litera* are propriul loc   

   5) **MPG**
      - modul **VHDL** care are ca scop implementarea unui **Mono Pulse Generator**.


```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MPG is
    Port ( enable : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal cnt_int : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
signal Q1, Q2, Q3 : STD_LOGIC;

begin

    enable <= Q2 and (not Q3);

    process(clk)
    begin
        if clk='1' and clk'event then
            cnt_int <= cnt_int + 1;
        end if;
    end process;

    process(clk)
    begin
        if clk'event and clk='1' then
            if cnt_int(17 downto 0) = "111111111111111111" then
                Q1 <= btn;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if clk'event and clk='1' then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
    end process;

end Behavioral;
```

   6) **Modulul de testare**

      - In acest modul am legat toate componentele descrise mai sus.
     
```
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
```




[Back to the start](https://github.com/4lac1vica/MIPS-UNIC-CYCLE/tree/main)

