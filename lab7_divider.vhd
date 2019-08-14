----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:01 09/23/2017 
-- Design Name: 
-- Module Name:    lab7_divider - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab7_divider is
port(divisor,dividend:in std_logic_vector(7 downto 0);
	output_valid,input_invalid:out std_logic;
	load_inputs,clk,sim_mode: in std_logic;
	anode:out std_logic_vector(3 downto 0);
	cathode:out std_logic_vector(6 downto 0));
	
end lab7_divider;

architecture Behavioral of lab7_divider is

component twos_comp_ad 
port(a_1,b_1:in std_logic_vector(7 downto 0);
		b_inv:in std_logic;
		s_out1: out std_logic_vector(7 downto 0));
end component;

component display 
port (to_display:in std_logic_vector(15 downto 0);
		pushbutton:in std_logic;
		cathod:out std_logic_vector(6 downto 0);
		anodd:out std_logic_vector(3 downto 0);
		clock: in std_logic);
end component;

signal remainder:std_logic_vector(15 downto 0);
signal remainder_to_display:std_logic_vector(15 downto 0);
signal inter_dividend : std_logic_vector(7 downto 0);
signal inter_divisor : std_logic_vector(7 downto 0);
signal most_sig: std_logic_vector(7 downto 0):="10000000";
signal one: std_logic_vector(15 downto 0):="0000000000000001";
signal invalid: std_logic;
signal load_inp: std_logic;
begin
--remainder(15 downto 8 )<="00000000";
invalid <= '1' when divisor="00000000" else
                 '0';
input_invalid <= invalid;
BCD: twos_comp_ad
 port map(a_1=>"00000000",
			b_1=>dividend,
			b_inv=>'1',
			s_out1=>inter_dividend);
			
ABC: twos_comp_ad
 port map(a_1=>"00000000",
			b_1=>divisor,
			b_inv=>'1',
			s_out1=>inter_divisor);			
--remainder(7 downto 0)<=inter_dividend(7 downto 0);
process(remainder,clk)	
begin
      if (clk='1' and clk'event) then     
            if (load_inputs ='1') then 
                remainder(15 downto 8 )<="00000000";    
                remainder(7 downto 0)<=inter_dividend(7 downto 0);
					 load_inp<='0';
            else     
                 if (invalid='0') then  
                    for i in 0 to 7 loop
                       remainder(15 downto 0) <= remainder(14 downto 0) & '0';
                       if (to_integer(unsigned(remainder(15 downto 8)))>=to_integer(unsigned(inter_divisor(7 downto 0)))) then
                            remainder(15 downto 8)<= std_logic_vector(unsigned(remainder(15 downto 8))-unsigned(inter_divisor(7 downto 0)));
                            remainder(15 downto 0)<= std_logic_vector(unsigned(remainder(15 downto 0))+unsigned(one));
                        end if;
                    end loop;
                    if (dividend(7)='1') then
                       remainder(15 downto 8) <=  std_logic_vector(unsigned(most_sig(7 downto 0)) -unsigned(remainder(15 downto 8))) ;
                    end if;
                    if ((dividend(7)='1' and divisor(7)='0')or(dividend(7)='0'and divisor(7)='1')) then
                       remainder(7 downto 0) <=  std_logic_vector(unsigned(most_sig(7 downto 0)) -unsigned(remainder(7 downto 0))) ;
                    end if;
                    output_valid<='1';
                 else
                    remainder <= "0000000000000000";
                 end if;
                 remainder_to_display(7 downto 0)<=remainder(15 downto 8);
                 remainder_to_display(15 downto 8)<=remainder(7 downto 0);
             end if;
      end if;
end process;	

disp:display 
port map(to_display=>remainder_to_display,
		pushbutton=>sim_mode,
		cathod=>cathode,
		anodd=>anode,
		clock=> clk);


end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:38:31 09/23/2017 
-- Design Name: 
-- Module Name:    bit_16_adder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bit_16_adder is
port(inp:in std_logic_vector(15 downto 0);
		outpu:out std_logic_vector(15 downto 0));
end bit_16_adder;

architecture Behavioral of bit_16_adder is

begin
outpu(15 downto 1)<=inp(14 downto 0);
outpu(0)<='0';

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:19 09/18/2017 
-- Design Name: 
-- Module Name:    twos_comp_ad - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity twos_comp_ad is
port(a_1,b_1:in std_logic_vector(7 downto 0);
		b_inv:in std_logic;
		s_out1: out std_logic_vector(7 downto 0));
end twos_comp_ad;

architecture Behavioral of twos_comp_ad is
component  full_adder_1_1_8_bit
port(a1 ,b1 :in std_logic_vector(7 downto 0 );
		c1:in std_logic;
		s1:out std_logic_vector(7 downto 0);
		c_out_8 : out std_logic);
end component;

component comp_mux 
port( selector:in std_logic;
		inpu:in std_logic_vector(7 downto 0);
		outp : out std_logic_vector(7 downto 0));
end component;
signal sel_dividend : std_logic_vector(7 downto 0):= "00000001";
signal mid_dividend : std_logic_vector(7 downto 0);
signal gar:std_logic;
signal car:std_logic:='1';
begin
Complementor:	comp_mux 
	port map(selector=>b_1(7),
				inpu=>b_1,
				outp=>mid_dividend);
process (b_1)
begin	
	if (b_1(7)='1') then 
		sel_dividend<="00000001";
	else
		sel_dividend<="00000000";
	end if;
end process;
Adder : full_adder_1_1_8_bit
port map(a1=>sel_dividend,
			b1=>mid_dividend,
			c1=>'0',
			s1=>s_out1,
			c_out_8=>gar);

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:59:40 09/15/2017 
-- Design Name: 
-- Module Name:    full_adder_1_1_8_bit - Behavioral_1 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity  full_adder_1_1_8_bit is 
port(a1 ,b1 :in std_logic_vector(7 downto 0 );
		c1:in std_logic;
		s1:out std_logic_vector(7 downto 0);
		c_out_8 : out std_logic);
end full_adder_1_1_8_bit;

architecture Behavioral_1 of full_adder_1_1_8_bit is

signal c_1 :std_logic;	  
signal c_2 :std_logic;
signal c_3 :std_logic;
signal c_4 :std_logic;
signal c_5 :std_logic;
signal c_6 :std_logic;
signal c_7 :std_logic;


component full_adder_1 
	port( a:in std_logic;
			b:in std_logic;
			c:in std_logic;
			s:out std_logic;
			c_out:out std_logic);
end component;

begin

 full_adder_1_1_0 : full_adder_1
 port map(a => a1(0),
			b => b1(0),
			c => c1,
			s => s1(0),
			c_out => c_1);
			
 full_adder_1_1_1 : full_adder_1
 port map(a=>a1(1),
			b=>b1(1),
			c=>c_1,
			s=>s1(1),
			c_out=>c_2);
 full_adder_1_1_2 : full_adder_1
 port map(a=>a1(2),
			b=>b1(2),
			c=>c_2,
			s=>s1(2),
			c_out=>c_3);
			
 full_adder_1_1_3 : full_adder_1
 port map(a=>a1(3),
			b=>b1(3),
			c=>c_3,
			s=>s1(3),
			c_out=>c_4);
 full_adder_1_1_4 : full_adder_1
 port map(a=>a1(4),
			b=>b1(4),
			c=>c_4,
			s=>s1(4),
			c_out=>c_5);
			
 full_adder_1_1_5 : full_adder_1
 port map(a=>a1(5),
			b=>b1(5),
			c=>c_5,
			s=>s1(5),
			c_out=>c_6);
			
 full_adder_1_1_6 : full_adder_1
 port map(a=>a1(6),
			b=>b1(6),
			c=>c_6,
			s=>s1(6),
			c_out=>c_7);
 full_adder_1_1_7 : full_adder_1
 port map(a=>a1(7),
			b=>b1(7),
			c=>c_7,
			s=>s1(7),
			c_out => c_out_8);			

end Behavioral_1;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:33:57 09/15/2017 
-- Design Name: 
-- Module Name:    full_adder_1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_adder_1 is
port( a,b,c : IN std_logic;
		s,c_out:OUT std_logic);
end full_adder_1;

architecture Behavioral of full_adder_1 is

begin
	s<=(a xor b xor c);
	c_out<=((a and b) or (b and c) or (c and a));
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:57:59 09/18/2017 
-- Design Name: 
-- Module Name:    comp_mux - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comp_mux is
port( selector:in std_logic;
		inpu:in std_logic_vector(7 downto 0);
		outp : out std_logic_vector(7 downto 0));
end comp_mux;

architecture Behavioral of comp_mux is

begin
process(selector)
begin	
	if (selector='1') then
		outp(0) <= not inpu(0);
		outp(1) <= not inpu(1);
		outp(2) <= not inpu(2);
		outp(3) <= not inpu(3);
		outp(4) <= not inpu(4);
		outp(5) <= not inpu(5);
		outp(6) <= not inpu(6);
		outp(7) <= not inpu(7);
	elsif (selector='0') then
		outp(0) <= inpu(0);
		outp(1) <= inpu(1);
		outp(2) <= inpu(2);
		outp(3) <= inpu(3);
		outp(4) <= inpu(4);
		outp(5) <= inpu(5);
		outp(6) <= inpu(6);
		outp(7) <= inpu(7);
	end if;
end process;				  
				
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
port (to_display:in std_logic_vector(15 downto 0);
		pushbutton:in std_logic;
		cathod:out std_logic_vector(6 downto 0);
		anodd:out std_logic_vector(3 downto 0);
		clock: in std_logic);
end display;

architecture Behavioral of display is
signal reduced_clock,selected_clock:std_logic;
signal temp_anode:std_logic_vector(3 downto 0);
signal to_displ:std_logic_vector(3 downto 0);
component clock_reducer is
       Port (
           clk_in : in  STD_LOGIC;
           clk_out: out STD_LOGIC);
end component;

component cat_disp 
port(to_disp:in std_logic_vector(3 downto 0);
		cathode:out std_logic_vector(6 downto 0));
end component;

component anode_selector 
port(clk_input: in std_logic;
		anod: out std_logic_vector(3 downto 0));
end component;



begin

frquency_reducer : clock_reducer
         port map (clk_in=> clock,
                clk_out => reduced_clock );
selected_clock<= (pushbutton and clock ) or ((not pushbutton) and reduced_clock);

anode_output: anode_selector
				port map (clk_input=>selected_clock,
							anod=>temp_anode);
anodd<=temp_anode;
process(temp_anode)
	begin
		case temp_anode is
			 when "1110" => to_displ(3 downto 0)<= to_display(3 downto 0);
			 when "1101" => to_displ(3 downto 0)<= to_display(7 downto 4) ;
			 when "1011" => to_displ(3 downto 0)<= to_display(11 downto 8) ;
			 when others => to_displ(3 downto 0)<= to_display(15 downto 12) ;
		end case;
	end process;	
cathode_displayer: cat_disp 
	port map(to_disp=>to_displ,
				cathode=>cathod);
	

end Behavioral;

------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_reducer is
Port (
        clk_in : in  STD_LOGIC;
        
        clk_out: out STD_LOGIC
    );
end clock_reducer;

architecture Behavioral of clock_reducer is
    signal temporal :std_logic :='0';
    signal counter : integer range 0 to 131075 := 0;
begin
    process ( clk_in) begin
        
        if rising_edge(clk_in) then
            if (counter = 131072) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clk_out <= temporal;
end Behavioral;
------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity anode_selector is
port(clk_input: in std_logic;
		anod: out std_logic_vector(3 downto 0));
end anode_selector;

architecture Behavioral of anode_selector is

signal temp : std_logic_vector(3 downto 0):="0111"; 
begin
process(clk_input)
	begin
		if (clk_input='1' and clk_input'event) then
			if (temp="0111") then 
				temp<="1011";
			elsif (temp="1011") then 
				temp<="1101";
			elsif (temp="1101") then 
				temp<="1110";
			elsif (temp="1110") then 
				temp<="0111";
			end if;
		end if;	
	end process;
anod<=temp;	
		

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:23:53 09/17/2017 
-- Design Name: 
-- Module Name:    cat_disp - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cat_disp is
port(to_disp:in std_logic_vector(3 downto 0);
		cathode:out std_logic_vector(6 downto 0));
end cat_disp;

architecture Behavioral of cat_disp is
component cat_a_new_2_MUSER_lab4_seven_segment_display
      port ( A         : in    std_logic; 
             B         : in    std_logic; 
             C         : in    std_logic; 
             cat_a_new : out   std_logic; 
             D         : in    std_logic);
   end component;
 component cat_b_MUSER_lab4_seven_segment_display
      port ( A     : in    std_logic; 
             B     : in    std_logic; 
             C     : in    std_logic; 
             cat_B : out   std_logic; 
             D     : in    std_logic);
   end component;
   
   component cat_c_MUSER_lab4_seven_segment_display
      port ( A     : in    std_logic; 
             B     : in    std_logic; 
             C     : in    std_logic; 
             cat_c : out   std_logic; 
             D     : in    std_logic);
   end component;
   
   component cat_d_MUSER_lab4_seven_segment_display
      port ( A     : in    std_logic; 
             B     : in    std_logic; 
             C     : in    std_logic; 
             cat_d : out   std_logic; 
             D     : in    std_logic);
   end component;
   
   component cat_e_MUSER_lab4_seven_segment_display
      port ( A     : in    std_logic; 
             B     : in    std_logic; 
             C     : in    std_logic; 
             cat_e : out   std_logic; 
             D     : in    std_logic);
   end component;
   
   component cat_f_MUSER_lab4_seven_segment_display
      port ( A     : in    std_logic; 
             B     : in    std_logic; 
             C     : in    std_logic; 
             cat_f : out   std_logic; 
             D     : in    std_logic);
   end component;
   
   component cat_g_MUSER_lab4_seven_segment_display
      port ( A     : in    std_logic; 
             B     : in    std_logic; 
             C     : in    std_logic; 
             cat_g : out   std_logic; 
             D     : in    std_logic);
   end component;
begin
   XLXI_31 : cat_a_new_2_MUSER_lab4_seven_segment_display
      port map (A=>to_disp(3),
                B=>to_disp(2),
                C=>to_disp(1),
                D=>to_disp(0),
                cat_a_new=>cathode(0));   
  
  XLXI_6 : cat_b_MUSER_lab4_seven_segment_display
      port map (A=>to_disp(3),
                B=>to_disp(2),
                C=>to_disp(1),
                D=>to_disp(0),
                cat_B=>cathode(1));
   
   XLXI_7 : cat_c_MUSER_lab4_seven_segment_display
      port map (A=>to_disp(3),
                B=>to_disp(2),
                C=>to_disp(1),
                D=>to_disp(0),
                cat_c=>cathode(2));
   
   XLXI_8 : cat_d_MUSER_lab4_seven_segment_display
      port map (A=>to_disp(3),
                B=>to_disp(2),
                C=>to_disp(1),
                D=>to_disp(0),
                cat_d=>cathode(3));
   
   XLXI_9 : cat_e_MUSER_lab4_seven_segment_display
      port map (A=>to_disp(3),
                B=>to_disp(2),
                C=>to_disp(1),
                D=>to_disp(0),
                cat_e=>cathode(4));
   
   XLXI_10 : cat_f_MUSER_lab4_seven_segment_display
      port map (A=>to_disp(3),
                B=>to_disp(2),
                C=>to_disp(1),
                D=>to_disp(0),
                cat_f=>cathode(5));
   
   XLXI_11 : cat_g_MUSER_lab4_seven_segment_display
      port map (A=>to_disp(3),
                B=>to_disp(2),
                C=>to_disp(1),
                D=>to_disp(0),
                cat_g=>cathode(6));

end Behavioral;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity cat_a_new_2_MUSER_lab4_seven_segment_display is
   port ( A         : in    std_logic; 
          B         : in    std_logic; 
          C         : in    std_logic; 
          D         : in    std_logic; 
          cat_a_new : out   std_logic);
end cat_a_new_2_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of cat_a_new_2_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_29   : std_logic;
   signal XLXN_30   : std_logic;
   signal XLXN_31   : std_logic;
   signal XLXN_32   : std_logic;
   component AND4B3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B3 : component is "BLACK_BOX";
   
   component AND4B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B1 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
begin
   XLXI_7 : AND4B3
      port map (I0=>C,
                I1=>B,
                I2=>A,
                I3=>D,
                O=>XLXN_29);
   
   XLXI_8 : AND4B3
      port map (I0=>C,
                I1=>A,
                I2=>D,
                I3=>B,
                O=>XLXN_30);
   
   XLXI_9 : AND4B1
      port map (I0=>B,
                I1=>D,
                I2=>A,
                I3=>C,
                O=>XLXN_31);
   
   XLXI_10 : AND4B1
      port map (I0=>C,
                I1=>D,
                I2=>B,
                I3=>A,
                O=>XLXN_32);
   
   XLXI_11 : OR4
      port map (I0=>XLXN_32,
                I1=>XLXN_31,
                I2=>XLXN_30,
                I3=>XLXN_29,
                O=>cat_a_new);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity cat_g_MUSER_lab4_seven_segment_display is
   port ( A     : in    std_logic; 
          B     : in    std_logic; 
          C     : in    std_logic; 
          D     : in    std_logic; 
          cat_g : out   std_logic);
end cat_g_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of cat_g_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   signal XLXN_13 : std_logic;
   component AND3B3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3B3 : component is "BLACK_BOX";
   
   component AND4B2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B2 : component is "BLACK_BOX";
   
   component AND4B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B1 : component is "BLACK_BOX";
   
   component OR3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR3 : component is "BLACK_BOX";
   
begin
   XLXI_3 : AND3B3
      port map (I0=>C,
                I1=>B,
                I2=>A,
                O=>XLXN_11);
   
   XLXI_4 : AND4B2
      port map (I0=>D,
                I1=>C,
                I2=>B,
                I3=>A,
                O=>XLXN_12);
   
   XLXI_5 : AND4B1
      port map (I0=>A,
                I1=>D,
                I2=>C,
                I3=>B,
                O=>XLXN_13);
   
   XLXI_6 : OR3
      port map (I0=>XLXN_13,
                I1=>XLXN_12,
                I2=>XLXN_11,
                O=>cat_g);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity cat_f_MUSER_lab4_seven_segment_display is
   port ( A     : in    std_logic; 
          B     : in    std_logic; 
          C     : in    std_logic; 
          D     : in    std_logic; 
          cat_f : out   std_logic);
end cat_f_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of cat_f_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_13 : std_logic;
   signal XLXN_14 : std_logic;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
   component AND3B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3B1 : component is "BLACK_BOX";
   
   component AND4B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B1 : component is "BLACK_BOX";
   
   component AND4B3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B3 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND3B1
      port map (I0=>A,
                I1=>D,
                I2=>C,
                O=>XLXN_13);
   
   XLXI_2 : AND4B1
      port map (I0=>C,
                I1=>D,
                I2=>B,
                I3=>A,
                O=>XLXN_14);
   
   XLXI_3 : AND4B3
      port map (I0=>D,
                I1=>B,
                I2=>A,
                I3=>C,
                O=>XLXN_15);
   
   XLXI_5 : AND4B3
      port map (I0=>C,
                I1=>B,
                I2=>A,
                I3=>D,
                O=>XLXN_16);
   
   XLXI_6 : OR4
      port map (I0=>XLXN_16,
                I1=>XLXN_15,
                I2=>XLXN_14,
                I3=>XLXN_13,
                O=>cat_f);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity cat_e_MUSER_lab4_seven_segment_display is
   port ( A     : in    std_logic; 
          B     : in    std_logic; 
          C     : in    std_logic; 
          D     : in    std_logic; 
          cat_e : out   std_logic);
end cat_e_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of cat_e_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_13 : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;
   component AND2B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2B1 : component is "BLACK_BOX";
   
   component AND4B3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B3 : component is "BLACK_BOX";
   
   component AND4B2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B2 : component is "BLACK_BOX";
   
   component OR3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR3 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2B1
      port map (I0=>A,
                I1=>D,
                O=>XLXN_13);
   
   XLXI_2 : AND4B3
      port map (I0=>D,
                I1=>C,
                I2=>A,
                I3=>B,
                O=>XLXN_16);
   
   XLXI_3 : AND4B2
      port map (I0=>C,
                I1=>B,
                I2=>D,
                I3=>A,
                O=>XLXN_17);
   
   XLXI_4 : OR3
      port map (I0=>XLXN_17,
                I1=>XLXN_16,
                I2=>XLXN_13,
                O=>cat_e);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity cat_d_MUSER_lab4_seven_segment_display is
   port ( A     : in    std_logic; 
          B     : in    std_logic; 
          C     : in    std_logic; 
          D     : in    std_logic; 
          cat_d : out   std_logic);
end cat_d_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of cat_d_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_18 : std_logic;
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
   component AND4B2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B2 : component is "BLACK_BOX";
   
   component AND4B3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B3 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND3
      port map (I0=>D,
                I1=>C,
                I2=>B,
                O=>XLXN_15);
   
   XLXI_2 : AND4B2
      port map (I0=>D,
                I1=>B,
                I2=>C,
                I3=>A,
                O=>XLXN_16);
   
   XLXI_3 : AND4B3
      port map (I0=>C,
                I1=>B,
                I2=>A,
                I3=>D,
                O=>XLXN_17);
   
   XLXI_4 : AND4B3
      port map (I0=>D,
                I1=>C,
                I2=>A,
                I3=>B,
                O=>XLXN_18);
   
   XLXI_5 : OR4
      port map (I0=>XLXN_18,
                I1=>XLXN_17,
                I2=>XLXN_16,
                I3=>XLXN_15,
                O=>cat_d);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity cat_c_MUSER_lab4_seven_segment_display is
   port ( A     : in    std_logic; 
          B     : in    std_logic; 
          C     : in    std_logic; 
          D     : in    std_logic; 
          cat_c : out   std_logic);
end cat_c_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of cat_c_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_10 : std_logic;
   signal XLXN_13 : std_logic;
   signal XLXN_15 : std_logic;
   component AND3B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3B1 : component is "BLACK_BOX";
   
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
   component AND4B3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B3 : component is "BLACK_BOX";
   
   component OR3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR3 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND3B1
      port map (I0=>D,
                I1=>B,
                I2=>A,
                O=>XLXN_10);
   
   XLXI_2 : AND3
      port map (I0=>C,
                I1=>B,
                I2=>A,
                O=>XLXN_13);
   
   XLXI_3 : AND4B3
      port map (I0=>D,
                I1=>B,
                I2=>A,
                I3=>C,
                O=>XLXN_15);
   
   XLXI_5 : OR3
      port map (I0=>XLXN_15,
                I1=>XLXN_13,
                I2=>XLXN_10,
                O=>cat_c);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity cat_b_MUSER_lab4_seven_segment_display is
   port ( A     : in    std_logic; 
          B     : in    std_logic; 
          C     : in    std_logic; 
          D     : in    std_logic; 
          cat_B : out   std_logic);
end cat_b_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of cat_b_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_43 : std_logic;
   signal XLXN_44 : std_logic;
   signal XLXN_45 : std_logic;
   signal XLXN_46 : std_logic;
   component AND3B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3B1 : component is "BLACK_BOX";
   
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
   component AND4B2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B2 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
begin
   XLXI_11 : AND3B1
      port map (I0=>D,
                I1=>C,
                I2=>B,
                O=>XLXN_43);
   
   XLXI_12 : AND3B1
      port map (I0=>D,
                I1=>B,
                I2=>A,
                O=>XLXN_44);
   
   XLXI_13 : AND3
      port map (I0=>C,
                I1=>B,
                I2=>A,
                O=>XLXN_45);
   
   XLXI_14 : AND4B2
      port map (I0=>C,
                I1=>A,
                I2=>D,
                I3=>B,
                O=>XLXN_46);
   
   XLXI_15 : OR4
      port map (I0=>XLXN_46,
                I1=>XLXN_45,
                I2=>XLXN_44,
                I3=>XLXN_43,
                O=>cat_B);
   
end BEHAVIORAL;









