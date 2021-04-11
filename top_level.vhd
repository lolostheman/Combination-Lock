library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
   port(CLK100MHZ       : in std_logic;
		BTNC            : in std_logic;
		BTNU            : in std_logic;
		BTNR            : in std_logic;
		BTNL            : in std_logic;
		BTND            : in std_logic;
		CPU_RESETN      : in std_logic;
		LED             : out std_logic_vector(15 downto 0)
	    );
end top_level;

architecture structural of top_level is
	component SwitchDebouncer is
        port(clk        : in std_logic;
             reset      : in std_logic;
             switchIn   : in std_logic;
             switchOut  : out std_logic);
    end component;
    component clock_divider is
        port(mclk       : in std_logic;
             sclk       : out std_logic);
	end component;
	
	component combinationlock is
		port(in1,in2,in3,in4 : in std_logic;
			 activate		 : in std_logic;
			 lock_ctrl		 : out std_logic;
			 reset, clk 	 : in std_logic);
	end component;
	
	for all : SwitchDebouncer use entity work.SwitchDebouncer(Behavioral);
    for all : clock_divider use entity work.clock_divider(behavior);
	for all : combinationlock use entity work.combination(sturctural);
	signal activate,in1,in2,in3,in4,reset,clk : std_logic;
		begin	
		    sclk : clock_divider port map(mclk => CLK100MHZ, sclk => clk);
			
		    actv : SwitchDebouncer port map(clk => CLK100MHZ, reset => CPU_RESETN, 
											switchIn => BTNC, switchOut => activate);
            firstinput : SwitchDebouncer port map(clk => CLK100MHZ, reset => CPU_RESETN,
												  switchIn => BTNU, switchOut => in1);
            secondinput : SwitchDebouncer port map(clk => CLK100MHZ, reset => CPU_RESETN,
												   switchIn => BTNR, switchOut => in2);
            thirdinput : SwitchDebouncer port map(clk => CLK100MHZ, reset => CPU_RESETN,
												  switchIn => BTNL, switchOut => in3);
            fourthinput : SwitchDebouncer port map(clk => CLK100MHZ, reset => CPU_RESETN,
												   switchIn => BTND, switchOut => in4);
			statemachine : combinationlock port map(in1 => in1, in2 => in2, in3 => in3,
													in4 => in4, activate => activate,
													reset => CPU_RESETN, clk => clk,
													lock_ctrl => LED(0));
	end structural;
	
	
	    
	
	
	
	
	
	
	
	
	
	