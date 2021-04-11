library ieee;
use ieee.std_logic_1164.all;

entity combinationclcoktestbench is
end combinationclcoktestbench;

architecture behavior of combinationclcoktestbench is

  signal clk_sig : std_logic := '0';
  signal rst_sig : std_logic := '0';
  signal in1tb,in2tb,in3tb,in4tb : std_logic;
  signal activatetb : std_logic;
  --signal ctrl_lock : std_logic;
  constant Tperiod : time := 10 ns;
  
  begin
  
    process(clk_sig)
      begin
        clk_sig <= not clk_sig after Tperiod/2;
    end process;
  --solution in4 in1 in3 in2
  rst_sig <= '0', '1' after 2 ns, '0' after 4 ns;
  
	in1tb <= '1';
	in2tb <= '0';
	in3tb <= '1';
	in4tb <= '1';
	
	--in1tb <= '1', '1' after 140 ns, '1' after 180 ns, '1' after 260 ns;
	--in2tb <= '1' after 20 ns, '1' after 80  ns, '1' after 200 ns, '1' after 300 ns;
	--in3tb <= '1' after 40 ns, '1' after 100 ns, '1' after 220 ns,	'1' after 280 ns, '1' after 340 ns; --relock
	--in4tb <= '1' after 60 ns, '1' after 120 ns, '1' after 160 ns, '1' after 240 ns;
	--activatetb <= '1' after 320 ns;  
  
      
    -- this is the component instantiation for the
    -- DUT - the device we are testing
    DUT : entity work.combinationlock(structural)
      port map(clk => clk_sig, reset => rst_sig,
               in1 => in1tb, in2 => in2tb, in3 => in3tb,in4 => in4tb, activate => activatetb);

    monitor : process      
      begin      
        wait;
    end process monitor;
end behavior;