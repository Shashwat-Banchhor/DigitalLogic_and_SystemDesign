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
process(temp_anode,to_display)
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
    signal XLXN_310   : std_logic;
     signal XLXN_311   : std_logic;

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
   
    component AND4B2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B2 : component is "BLACK_BOX";
 
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic;
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             O : out    std_logic); 

   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
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
                
     XLXI_91 : AND4B2
                    port map (I0=>B,
                              I1=>D,
                              I2=>A,
                              I3=>C,
                              O=>XLXN_311);
   
        XLXI_92 : AND4B2
                  port map (I0=>C,
                             I1=>D,
                              I2=>A,
                             I3=>B,
                           O=>XLXN_310);
   
   
   XLXI_11 : OR5
      port map (I0=>XLXN_31,
                I1=>XLXN_30,
                I2=>XLXN_29,
                I3=>XLXN_310,
                I4=>XLXN_311,
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
    signal XLXN_122 : std_logic;
   signal XLXN_13 : std_logic;

   

   
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
     
        component AND4B4
         port ( I0 : in    std_logic; 
                I1 : in    std_logic; 
                I2 : in    std_logic; 
                I3 : in    std_logic; 
                O  : out   std_logic);
      end component;
      attribute BOX_TYPE of AND4B4 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic;
              I3 : in    std_logic;
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
begin
   XLXI_3 : AND4B3
      port map (I0=>C,
                I1=>B,
                I2=>A,
                I3=>D,
                O=>XLXN_11);
   
   XLXI_4 : AND4B1
      port map (I0=>A,
                I1=>C,
                I2=>B,
                I3=>D,
                O=>XLXN_12);
    XLXI_41 : AND4B1
                     port map (I0=>B,
                               I1=>D,
                               I2=>A,
                               I3=>C,
                               O=>XLXN_122);
   
   XLXI_5 : AND4B4
      port map (I0=>B,
                I1=>D,
                I2=>C,
                I3=>A,
                O=>XLXN_13);
   
   XLXI_6 : OR4
      port map (I0=>XLXN_13,
                I1=>XLXN_12,
                I2=>XLXN_11,
                I3=>XLXN_122,
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
     signal XLXN_12 : std_logic;

   signal XLXN_13 : std_logic;
   signal XLXN_14 : std_logic;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
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
             I3 : in std_logic;
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
begin
 
   
   XLXI_2 : AND4B1
      port map (I0=>A,
                I1=>D,
                I2=>B,
                I3=>C,
                O=>XLXN_14);
   
   XLXI_3 : AND4B2
      port map (I0=>A,
                I1=>B,
                I2=>D,
                I3=>C,
                O=>XLXN_15);
      XLXI_51 : AND4B3
                   port map (I0=>A,
                             I1=>D,
                             I2=>B,
                             I3=>C,
                             O=>XLXN_12);
   XLXI_5 : AND4B2
      port map (I0=>D,
                I1=>C,
                I2=>A,
                I3=>B,
                O=>XLXN_16);
    
   
   XLXI_6 : OR4
      port map (I0=>XLXN_16,
                I1=>XLXN_15,
                I2=>XLXN_14,
                I3=>XLXN_12 ,           
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
      signal XLXN_132 : std_logic;
         signal XLXN_131 : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;

    component AND3B2
        port ( I0 : in    std_logic; 
               I1 : in    std_logic; 
               I2 : in    std_logic;  
               O  : out   std_logic);
     end component;
     attribute BOX_TYPE of AND3B2 : component is "BLACK_BOX";
   
   component AND4B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B1 : component is "BLACK_BOX";
   
   component AND4B2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B2 : component is "BLACK_BOX";
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
              I3 : in    std_logic; 
              I4 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND4B2
      port map (I0=>A,
                I1=>B,
                I2=>C,
                I3=>D,
                O=>XLXN_13);
     XLXI_11 : AND3B2
                     port map (I0=>A,
                               I1=>C,
                               I2=>B,
                               O=>XLXN_131);
   XLXI_2 : AND4B1
      port map (I0=>A,
                I1=>C,
                I2=>B,
                I3=>D,
                O=>XLXN_16);
   
   XLXI_3 : AND4B2
      port map (I0=>C,
                I1=>B,
                I2=>D,
                I3=>A,
                O=>XLXN_17);
   XLXI_32 : AND4B2
                   port map (I0=>C,
                             I1=>D,
                             I2=>B,
                             I3=>A,
                             O=>XLXN_132);
   
   XLXI_4 : OR5
      port map (I0=>XLXN_17,
                I1=>XLXN_16,
                I2=>XLXN_13,
                I3=>XLXN_132,
                I4=>XLXN_131,
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
    signal XLXN_161 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_18 : std_logic;

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
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic;
             I4 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
begin
 
      XLXI_1 : AND4B1
   port map (I0=>A,
             I1=>B,
             I2=>C,
             I3=>D,
             O=>XLXN_15);
   
   XLXI_2 : AND4B2
      port map (I0=>C,
                I1=>D,
                I2=>B,
                I3=>A,
                O=>XLXN_16);
                
         XLXI_21: AND3B1
                   port map (I0=>B,
                             I1=>A,
                             I2=>C,
                             
                             O=>XLXN_161);
   
   XLXI_3 : AND4B3
      port map (I0=>C,
                I1=>D,
                I2=>A,
                I3=>B,
                O=>XLXN_17);
   
   XLXI_4 : AND4B3
      port map (I0=>B,
                I1=>C,
                I2=>A,
                I3=>D,
                O=>XLXN_18);
   
   XLXI_5 : OR5
      port map (I0=>XLXN_18,
                I1=>XLXN_17,
                I2=>XLXN_16,
                I3=>XLXN_15,
                I4=>XLXN_161,
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
   signal XLXN_131 : std_logic;
   signal XLXN_15 : std_logic;

      component AND4B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4B1 : component is "BLACK_BOX";
   
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
   
   component OR3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR3 : component is "BLACK_BOX";
   
begin
   XLXI_32 : AND4B3
      port map (I0=>B,
                I1=>C,
                I2=>A,
                I3=>D,
                O=>XLXN_13);
    XLXI_322 : AND4B3
                     port map (I0=>B,
                               I1=>D,
                               I2=>A,
                               I3=>C,
                               O=>XLXN_131);
  XLXI_31 : AND4B2
                     port map (I0=>C,
                               I1=>D,
                               I2=>A,
                               I3=>B,
                               O=>XLXN_10);  
 
   XLXI_3 : AND4B1
      port map (I0=>B,
                I1=>D,
                I2=>A,
                I3=>C,
                O=>XLXN_15);
   
   XLXI_5 : OR4
      port map (I0=>XLXN_15,
                I1=>XLXN_13,
                I2=>XLXN_10,
                I3=>XLXN_131,             
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
	signal added:std_logic;
	signal added_2:std_logic;
	signal added_1:std_logic;
   component AND4B1
       port ( I0 : in    std_logic; 
              I1 : in    std_logic; 
              I2 : in    std_logic; 
              I3 : in    std_logic; 
              O  : out   std_logic);
    end component;
    attribute BOX_TYPE of AND4B1 : component is "BLACK_BOX";

   

   
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
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
              I3 : in    std_logic; 
            I4:in std_logic;
            
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
begin

      XLXI_141 : AND4B2
      port map (I0=>C,
                I1=>A,
                I2=>D,
                I3=>B,
                O=>XLXN_45);
   
   XLXI_14 : AND4B3
      port map (I0=>B,
                I1=>A,
                I2=>C,
                I3=>D,
                O=>XLXN_46);
					 
   aded_1 : AND4B2
                                   port map (I0=>D,
                                             I1=>C,
                                             I2=>A,
                                             I3=>B,
                                             
                                             O=>added);

   aded : AND4B2
                      port map (I0=>D,
                                I1=>A,
                                I2=>C,
                                I3=>B,
                                
                                O=>added_1);
   aded_2 : AND4B1
                                                     port map (I0=>B,
                                                               I1=>D,
                                                               I2=>C,
                                                               I3=>A,
                                                              
                                                               O=>added_2);
   
   XLXI_15 : OR5
      port map (I0=>XLXN_46,
                I1=>XLXN_45,
                I2=>added,
                I3=>added_1,
                I4=>added_2,
                O=>cat_B);
   
end BEHAVIORAL;









