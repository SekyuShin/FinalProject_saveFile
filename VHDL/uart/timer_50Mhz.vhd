
library ieee;
use ieee.std_logic_1164.all;

entity timer_50Mhz is
   
 port(
--50Mhz를 카운팅 할수 있게 최대를 50 * 10^6을 선언하였다. default값을 2로 주어  50Mhz를 절반으로 줄여 25Mhz 만들게끔 선언하였다
				clock_in : in  STD_LOGIC;
            clock_out : out  STD_LOGIC);
end timer_50Mhz;


architecture Behavioral of timer_50Mhz is

begin

 process(clock_in)
 variable count : integer range 0 to 5000000 := 50000;
 variable temp :integer range 0 to 5000000 := 0; 
 begin
  if(rising_edge(clock_in)) then --상승모서리 동작 (clock_in'event and clock_in='1')로 바꿔도 된다.
   if(temp = count-1) then -- temp가 count - 1 에서 clock_out 값이 high가 되고 temp가 0으로 초기화
    temp :=0;
    clock_out <='1';
   else
    temp := temp + 1;        -- 이외의 경우 clock_out 값이 low되고 temp가 1씩증가
    clock_out <='0';
   end if;
  end if;
 end process;
 

end Behavioral;