----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:17:49 10/28/2017 
-- Design Name: 
-- Module Name:    Reflex_test - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Reflex_test is
port(
		start:in std_logic;
		stop : in std_logic;
		reset:in std_logic;
		clk : in std_logic;
		output_led:out std_logic_vector(15 downto 0);
		anode:out std_logic_vector(3 downto 0);
		cathode:out std_logic_vector(6 downto 0);
		pushbutton:in std_logic);
end Reflex_test;

architecture Behavioral of Reflex_test is
	
component display 
port (to_display:in std_logic_vector(15 downto 0);
		pushbutton:in std_logic;
		cathod:out std_logic_vector(6 downto 0);
		anodd:out std_logic_vector(3 downto 0);
		clock: in std_logic);
end component;
	
	
	signal counter 		       : integer range 0 to 2000000000       := 0;
    signal time_counter 	       : integer range 0 to 2000000000   := 0;
	signal random_number 	       : integer range 0 to 1000000000  := 2;
	signal go_its_started 	       : integer range 0 to 1000000000  := 2;
	signal my_generated_random_bit  : std_logic_vector(31 downto 0);
	signal dont_display_hi        :  bit := '0';
	signal reaction_time  : std_logic_vector(15 downto 0) ;
	signal ten 	       : integer range 0 to 1000000000  := 10;
	signal to_display : std_logic_vector(15 downto 0);
	signal ten_to_six : integer   :=  100000; --1000000;
	signal ten_to_seven : integer :=  1000000;--10000000;
	signal ten_to_eight : integer :=  10000000; --100000000;
	signal ten_to_nine : integer  :=  100000000;--1000000000;
	signal one : std_logic_vector(3 downto 0) ;
	--signal to_display: std_logic_vector(15 downto 0);
begin

---component of display;			/// initialize the input to it as the hi message;
one<="0001";

process(clk)
begin	
	--if (reset = '1') then
		--counter<=0;							---	/// For Output LED;
		--time_counter<=0;
		--random_number<=1;		--	/// The Random_Nmber
		--dont_display_hi <= '0';
		--output_led(15 downto 0) <= "0000000000000001";
		--my_generated_random_bit(15 downto 0) <= "0000000000000001";
	--go_its_started <= 1; 
	--end if;
	if (rising_edge(clk)) then---elsif (rising_edge(clk)) then
       if (reset = '1') then
            counter<=0;                            ---    /// For Output LED;
            time_counter<=0;
            random_number<=1;        --    /// The Random_Nmber
            dont_display_hi <= '0';
            output_led(15 downto 0) <= "0000000000000000";
            my_generated_random_bit(31 downto 0) <= "00000000000000000000000000000001";
            go_its_started <= 1; 
        --end if;
       
       
       elsif (go_its_started=1) then   
                if (start = '1') then 
                    output_led <= "0000000000000000";
                   -- if (counter=0) then
                     --   counter <= counter+1;	
                    --end if;
                    --my_generated_random_bit <= std_logic_vector(random_number);
                    counter<=1 ; -- remove it
                    go_its_started<=0;
                    --random_number<=0;
                    --my_generated_random_bit  <= "0000000000000000";
                elsif (not(my_generated_random_bit="00000000000000000000000000000000")) then
                    ---random_number<=random_number+1;
                    my_generated_random_bit <= std_logic_vector(unsigned(my_generated_random_bit)+unsigned(one));
                    if (random_number=9999) then
                        random_number <= 2000;
                    else 
                     random_number<= random_number+ 1;
                    end if;
                end if;
	    elsif (go_its_started = 0) then
            
           -- if (not(counter=0) and random_number=0) then
                    
                    if (counter = random_number*100000) then ---random_number*1000000) then --to_integer(unsigned(my_generated_random_bit))) then 
                        case my_generated_random_bit(3 downto 0) is
                            when "0000" => output_led(15 downto 0) <= "0000000000000001";       -- //// The position of 1 is determined by sum of last two digits of my_gen_ran;
                            when "0001" => output_led(15 downto 0) <= "0000000000000010";
                            when "0010" => output_led(15 downto 0) <= "0000000000000100";
                            when "0011" => output_led(15 downto 0) <= "0000000000001000";
                            when "0100" => output_led(15 downto 0) <= "0000000000010000";
                            when "0101" => output_led(15 downto 0) <= "0000000000100000";
                            when "0110" => output_led(15 downto 0) <= "0000000001000000";
                            when "0111" => output_led(15 downto 0) <= "0000000010000000";
                            when "1000" => output_led(15 downto 0) <= "0000000100000000";
                            when "1001" => output_led(15 downto 0) <= "0000001000000000";
                            when "1010" => output_led(15 downto 0) <= "0000010000000000";
                            when "1011" => output_led(15 downto 0) <= "0000100000000000";
                            when "1100" => output_led(15 downto 0) <= "0001000000000000";
                            when "1101" => output_led(15 downto 0) <= "0010000000000000";
                            when "1110" => output_led(15 downto 0) <= "0100000000000000";
                            when others => output_led(15 downto 0) <= "1000000000000000";
                        end case;
                        counter<=0;
                        my_generated_random_bit(31 downto 0) <="00000000000000000000000000000000";
                        random_number<=0;
                        time_counter <= time_counter+1;
                        go_its_started <=3;
                    else
                        counter <= counter+1 ;
                    end if;
           
            --end if;
       
         elsif(go_its_started=3) then
       -- end if;
                   -- if (stop = '1' and random_number=0 and counter = 0 ) then 
                     --   output_led<="0000000000000000";
                       -- case (time_counter mod ten_to_six) is
                         --   when 0 => reaction_time(3 downto 0)<="0000";
                           -- when 1 => reaction_time(3 downto 0)<="0001";
                            --when 2 => reaction_time(3 downto 0)<="0010";
                            --when 3 => reaction_time(3 downto 0)<="0011";
                            --when 4 => reaction_time(3 downto 0)<="0100";
                            --when 5 => reaction_time(3 downto 0)<="0101";
                           -- when 6 => reaction_time(3 downto 0)<="0110";
                            --when 7 => reaction_time(3 downto 0)<="0111";
                           -- when 8 => reaction_time(3 downto 0)<="1000";
                    -- 
                           if (stop = '1' and random_number=0 and counter = 0 ) then 
                                                   if (time_counter < 1000000000) then
                                                          output_led<="0000000000000000";
                                                          case (((((time_counter/ten_to_six)mod ten)mod ten)mod ten)mod ten) is
                                                               when 0 => reaction_time(3 downto 0)<="0000";
                                                               when 1 => reaction_time(3 downto 0)<="0001";
                                                               when 2 => reaction_time(3 downto 0)<="0010";
                                                               when 3 => reaction_time(3 downto 0)<="0011";
                                                               when 4 => reaction_time(3 downto 0)<="0100";
                                                               when 5 => reaction_time(3 downto 0)<="0101";
                                                               when 6 => reaction_time(3 downto 0)<="0110";
                                                               when 7 => reaction_time(3 downto 0)<="0111";
                                                               when 8 => reaction_time(3 downto 0)<="1000";
                                                               when others => reaction_time(3 downto 0)<="1001";
                                                           end case;
                                                           case (((((time_counter/ten_to_seven)mod ten)mod ten)mod ten)mod ten) is
                                                               when 0 => reaction_time(7 downto 4)<="0000";
                                                               when 1 => reaction_time(7 downto 4)<="0001";
                                                               when 2 => reaction_time(7 downto 4)<="0010";
                                                               when 3 => reaction_time(7 downto 4)<="0011";
                                                               when 4 => reaction_time(7 downto 4)<="0100";
                                                               when 5 => reaction_time(7 downto 4)<="0101";
                                                               when 6 => reaction_time(7 downto 4)<="0110";
                                                               when 7 => reaction_time(7 downto 4)<="0111";
                                                               when 8 => reaction_time(7 downto 4)<="1000";
                                                               when others => reaction_time(7 downto 4)<="1001";
                                                           end case;
                                                           case (((((time_counter/ten_to_eight)mod ten)mod ten)mod ten)mod ten) is
                                                               when 0 => reaction_time(11 downto 8)<="0000";
                                                               when 1 => reaction_time(11 downto 8)<="0001";
                                                               when 2 => reaction_time(11 downto 8)<="0010";
                                                               when 3 => reaction_time(11 downto 8)<="0011";
                                                               when 4 => reaction_time(11 downto 8)<="0100";
                                                               when 5 => reaction_time(11 downto 8)<="0101";
                                                               when 6 => reaction_time(11 downto 8)<="0110";
                                                               when 7 => reaction_time(11 downto 8)<="0111";
                                                               when 8 => reaction_time(11 downto 8)<="1000";
                                                               when others => reaction_time(11 downto 8)<="1001";
                                                           end case;
                                                           case (((((time_counter/ten_to_nine)mod ten)mod ten)mod ten)mod ten) is
                                                               when 0 => reaction_time(15 downto 12)<="0000";
                                                               when 1 => reaction_time(15 downto 12)<="0001";
                                                               when 2 => reaction_time(15 downto 12)<="0010";
                                                               when 3 => reaction_time(15 downto 12)<="0011";
                                                               when 4 => reaction_time(15 downto 12)<="0100";
                                                               when 5 => reaction_time(15 downto 12)<="0101";
                                                               when 6 => reaction_time(15 downto 12)<="0110";
                                                               when 7 => reaction_time(15 downto 12)<="0111";
                                                               when 8 => reaction_time(15 downto 12)<="1000";
                                                               when others => reaction_time(15 downto 12)<="1001";
                                                           end case;
                                                           dont_display_hi <= '1';
                                                           --time_counter <= 0;
                                                           go_its_started<=4;
                                                 else
                                                       output_led<="0000000000000000";
                                                        dont_display_hi <= '1';
                                                          go_its_started<=4;
                                                          reaction_time(15 downto 0) <="1100110011001100";
                                                 end if;
                                                 
                             elsif (stop='0' and my_generated_random_bit = "00000000000000000000000000000000" and not(time_counter=0)) then
                                                   time_counter <= time_counter+1;
                                                    
                             end if;  
		
		end if;
	end if;
	if (dont_display_hi = '0') then
		to_display(15 downto 0) <= "1100101010111100";
	else
		to_display(15 downto 0) <= reaction_time(15 downto 0);
	end if;
end process;

dispo: display  
port map(to_display =>to_display ,
		pushbutton=>pushbutton,
		cathod=>cathode,
		anodd=>anode,
		clock=>clk);    

end Behavioral;

