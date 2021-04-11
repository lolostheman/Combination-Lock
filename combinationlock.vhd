library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity combinationlock is
   port(in1,in2,in3,in4 : in std_logic;
		activate        : in std_logic;
		lock_ctrl       : out std_logic;
		reset, clk    : in std_logic   
	);
end combinationlock;


architecture structural of combinationlock is
	type state_type is (b1,b2,b3,b4,solved,unlocked);
	signal present_state, next_state : state_type;
	--constant switch debouncers
	--solution in4 in1 in3 in2
			 
	begin
	clocked : process(clk,reset)
		begin
			if(reset = '1') then
				present_state <= b1;
			elsif(rising_edge(clk)) then
				present_state <= next_state;
			end if;
	end process clocked;
		
		--LED(0) <= lock_ctrl;
		
	 nextstate : process(present_state,in1,in2,in3,in4,activate)
		begin
			case present_state is
				when b1 =>
					if(in4 = '1') then
						next_state <= b2;
					elsif(in4 = '1') then
						next_state <= b2;
					else
						next_state <= b1;
					end if;
				when b2 =>
					if(in1 = '1') then
						next_state <= b3;
					elsif(in4 = '1') then
						next_state <= b2;
					else
						next_state <= b1;
					end if;
				when b3 =>
					if(in3 = '1') then
						next_state <= b4;
					elsif(in4 = '1') then
						next_state <= b2;
					else
						next_state <= b1;
					end if;
				when b4 =>
					if(in2 = '1') then
						next_state <= solved;
					elsif(in4 = '1') then
						next_state <= b2;
					else
						next_state <= b1;
					end if;
				when solved =>
					if(in1 = '1' or in2 = '1' or in3 = '1') then
						next_state <= b1;
					elsif(in4 = '1') then
						next_state <= b2;
					elsif(activate = '1') then
						next_state <= unlocked;
					end if;
				when unlocked =>
					if(in1 = '1' or in2 = '1' or in3 = '1' or in4 = '1') then
						next_state <= b1;
					else
						next_state <= unlocked;
					end if;	
			end case;
		end process nextstate;
		
		output : process(present_state,activate)
			begin
				case present_state is
					when b1 =>
						lock_ctrl <= '0';
					when b2 =>
						lock_ctrl <= '0';
					when b3 =>
						lock_ctrl <= '0';
					when b4 =>
						lock_ctrl <= '0';
					when solved =>
						lock_ctrl <= '0';
					when unlocked =>
						lock_ctrl <= '1';
				end case;
		end process output;
				
		
end architecture structural;
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
			
			