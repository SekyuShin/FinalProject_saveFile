LIBRARY ieee; 
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY lcd_display IS
		port( clk, resetn :in std_logic;
				e, rs, rw :out std_logic;
				lcd_data : out std_logic_vector(7 downto 0) );

END lcd_display;

 

ARCHITECTURE sample of lcd_display IS
	COMPONENT lcd
		port(clk		:in std_logic;
				strobe:in std_logic;
				address:in std_logic_vector(6 downto 0);
				data:in std_logic_vector(7 downto 0);
				e, rs, rw, busy: out std_logic;
				lcd_data : out std_logic_vector(7 downto 0));
	END COMPONENT;

	SIGNAL	busy_pre, busy, strobe: std_logic;
	SIGNAL	data	:std_logic_vector(7 downto 0);
	SIGNAL	count	:std_logic_vector(6 downto 0);
	
	
	SIGNAL	cnt	:integer RANGE 0 to 999;
	TYPE	lcd_disp IS ARRAY(0 to 1, 0 to 15) of std_logic_vector(7 downto 0);
	
	SIGNAL	msg : lcd_disp := ((X"51", X"65", X"78", X"74", X"20", X"4C", X"43", X"44"
											,X"20", X"45", X"78", X"61", X"6D", X"70", X"6C", X"65"),
											(X"20", X"20", X"20", X"20", X"54", X"45", X"53", X"54",
											X"49", X"4E", X"47", X"21", X"20", X"20", X"20", X"20"));

	BEGIN
		lcd_control : lcd PORT MAP(clk, strobe, count, data, e, rs, rw, busy, lcd_data );
		
		P_VAL : PROCESS(clk, resetn)

		BEGIN
			IF resetn = '0' THEN
				cnt <=0;
			ELSIF clk'EVENT AND clk='1' THEN
				IF cnt /=999 THEN
					cnt<= cnt +1;
				ELSE
					cnt <=0;
					
				END IF;
			END IF;
		END PROCESS;

		P_ADD : PROCESS(clk, resetn)

		BEGIN
			IF resetn = '0' THEN
				strobe <= '1';
				count <= "0000000";
			ELSIF clk'event and clk = '1' THEN
					busy_pre <=busy;
					IF busy = '0' and busy_pre = '1' THEN
						IF count = "1001111" THEN
							strobe <= '0';
						ELSE
							strobe <= '1';
							count <= count +1;
						END IF;
					ELSE
						IF cnt = 999 THEN
							strobe<= '1';
							count <= "1000000";
						ELSE
							strobe <= '0';
						END IF;
					END IF;
			END IF;
		END PROCESS;

		P_DATA : PROCESS(count)
			VARIABLE col_add :integer range 0 to 63;
			VARIABLE row_add :integer range 0 to 1;
			
		BEGIN
			col_add := to_integer(unsigned(count(5 downto 0)));
			row_add := to_integer(unsigned(count(6 downto 6)));
			
				IF col_add > 15 THEN
					data <= X"20";
				ELSE
					data <= msg(row_add, col_add);
				END IF;
			
		END process;

END sample;