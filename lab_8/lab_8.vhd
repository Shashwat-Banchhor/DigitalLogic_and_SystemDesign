
SHASHWAT BANCHHOR 2016CS10350
G.S.M. RISHIKESH REDDY 2016CS10338



-- We will be Implementing the Lift_System with the help of Finite_State_Machine

--The reset state would be the Idle state wherein each lift would be in the ground floor with doors open.

-- Each Lift moves from one state to another depending upon the requests made .

-- Slide Switches are used as buttons 1.e. if switched on then switched off immediately

-- After finishing any particular  request the lifts will go back to the idle state from wherein if there are requests made would handle them priority wise  .
-- Request Handler stores the requests when the lift is still handling a request and a request is made. 

entity Lab_8 
port(
		up_request(3:0) :in	
		down_request(3:0):in
		up_request_indicator(3:0):out
		down_request_indicator(3:0):out
		reset:in
		cathode(6:0):out
		anode(3:0):out
		door_open(1:0):in
		door_closed(1:0):in
		clk:in
		lift1_floor(3:0):in
		lift2_floor(3:0):in
		lift1_floor_indicator(3:0):out
		lift2_floor_indicator(3:0):out
		sim_mode:in;
	)
end Lab_8;

architecture Lift_System of Lab_8 is 

component Floor_buttons        
port(
		to_reset : in
		up_request_selector:in
		down_request_selector:in
	)
end component;

component Lift_buttons        -- Will make 2_components of this one for each lift;
port(
		floor_select(3 downto 0): in std_logic;
		keep_open : in ;
		keep_closed : in;		--- The requests made for the floor would be handled according to the priority;
	)
end component;

component display
port(
		-- Similar to the seven segment display code; With it's logic such that it can display the status in small letters;
	)
end component;

begin 

Lift_1: Lift_buttons --Will contain states inside it ;
port map(
			floor_select<=lift1_floor(3 downto 0),
			keep_open<=door_open(0);
			keep_closed<=door_closed(0);
		)

Lift_2: Lift_buttons 
port map(
			floor_select<=lift2_floor(3 downto 0),
			keep_open<=door_open(1);
			keep_closed<=door_closed(1);
		)
Floors  : Floor_buttons        
port map (
		to_reset <= reset
		up_request_selector <= up_request(3 downto 0);
		down_request_selector <= down_request(3 downto 0);
	)
end component;



Status Displayer: display
port map(
		-- Will Map the lift1 and lift2 status to its input;Which will be then displayed on SSD;  
	)

end architecture Lift_System;


entity Floor_buttons      
port{
		to_reset : in
		up_request_selector:in
		down_request_selector:in
	}
end Floor_buttons;
 
architecture floor_buttons of Floor_buttons is
begin
-- Will request for a lift in a particular floor;
end floor_buttons;

entity Lift_buttons        -- Will make 2_components of this one for each lift;
port(
		floor_select(3 downto 0): in std_logic;
		keep_open:in;
		keep_closed;
	)
end Lift_buttons;
 
architecture lift_buttons of Lift_buttons is
begin
TYPE state_type IS (Idle, Req_up, Req_down);			-- The lift will be in one of these three states at any particular time instant;
 SIGNAL state : state_type;

-- Will request the lift to go to a particular floor;

end lift_buttons;

entity display
port(
		-- Similar to the seven segment display code; 
	)
end display;

