# MIPS Unic Cycle

# Quick Descripton


Tools : Xilinx Vivado 2024.1

Tested on Nexys A7. 

**ENGLISH READ ME** -> 

## RO 

Acest proiect a fost realizat pentru cursul de Arhitectura Calculatoarelor. Acest proiect are ca scop implementarea in VHDL a unui procesor MIPS pe 32 de biti, avand arhitectura de tip Unic Cycle.
Un astfel de procesor executa o instructiune complet la un singur ciclu de ceas. Arhitectura respecta modelul clasic de MIPS si include urmatoarele componente:

1) Instruction Fetch
   
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



3) Execute

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
