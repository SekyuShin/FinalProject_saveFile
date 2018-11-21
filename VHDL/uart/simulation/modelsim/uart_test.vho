-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 15.1.0 Build 185 10/21/2015 SJ Lite Edition"

-- DATE "11/21/2018 20:12:17"

-- 
-- Device: Altera EP4CE30F23C8 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	uart_test IS
    PORT (
	clk_50m : IN std_logic;
	resetn : IN std_logic;
	send_req : IN std_logic;
	rx : IN std_logic;
	tx : BUFFER std_logic;
	rcv_data : BUFFER std_logic_vector(7 DOWNTO 0)
	);
END uart_test;

-- Design Ports Information
-- tx	=>  Location: PIN_B3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rcv_data[0]	=>  Location: PIN_P7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rcv_data[1]	=>  Location: PIN_N7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rcv_data[2]	=>  Location: PIN_M7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rcv_data[3]	=>  Location: PIN_L8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rcv_data[4]	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rcv_data[5]	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rcv_data[6]	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rcv_data[7]	=>  Location: PIN_K7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rx	=>  Location: PIN_B4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- resetn	=>  Location: PIN_E4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_50m	=>  Location: PIN_AB11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send_req	=>  Location: PIN_J4,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF uart_test IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk_50m : std_logic;
SIGNAL ww_resetn : std_logic;
SIGNAL ww_send_req : std_logic;
SIGNAL ww_rx : std_logic;
SIGNAL ww_tx : std_logic;
SIGNAL ww_rcv_data : std_logic_vector(7 DOWNTO 0);
SIGNAL \send_req~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk_50m~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \rx~input_o\ : std_logic;
SIGNAL \tx~output_o\ : std_logic;
SIGNAL \rcv_data[0]~output_o\ : std_logic;
SIGNAL \rcv_data[1]~output_o\ : std_logic;
SIGNAL \rcv_data[2]~output_o\ : std_logic;
SIGNAL \rcv_data[3]~output_o\ : std_logic;
SIGNAL \rcv_data[4]~output_o\ : std_logic;
SIGNAL \rcv_data[5]~output_o\ : std_logic;
SIGNAL \rcv_data[6]~output_o\ : std_logic;
SIGNAL \rcv_data[7]~output_o\ : std_logic;
SIGNAL \clk_50m~input_o\ : std_logic;
SIGNAL \clk_50m~inputclkctrl_outclk\ : std_logic;
SIGNAL \send_req~input_o\ : std_logic;
SIGNAL \pre_send_req~feeder_combout\ : std_logic;
SIGNAL \resetn~input_o\ : std_logic;
SIGNAL \pre_send_req~q\ : std_logic;
SIGNAL \UART_inst|Add2~1\ : std_logic;
SIGNAL \UART_inst|Add2~3\ : std_logic;
SIGNAL \UART_inst|Add2~4_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_counter[2]~8_combout\ : std_logic;
SIGNAL \UART_inst|Add2~5\ : std_logic;
SIGNAL \UART_inst|Add2~6_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_counter~3_combout\ : std_logic;
SIGNAL \UART_inst|Add2~7\ : std_logic;
SIGNAL \UART_inst|Add2~8_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_counter~2_combout\ : std_logic;
SIGNAL \UART_inst|Add2~9\ : std_logic;
SIGNAL \UART_inst|Add2~10_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_counter~1_combout\ : std_logic;
SIGNAL \UART_inst|Add2~11\ : std_logic;
SIGNAL \UART_inst|Add2~12_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_counter[6]~7_combout\ : std_logic;
SIGNAL \UART_inst|Add2~13\ : std_logic;
SIGNAL \UART_inst|Add2~14_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_counter~0_combout\ : std_logic;
SIGNAL \UART_inst|Add2~15\ : std_logic;
SIGNAL \UART_inst|Add2~16_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_counter[8]~6_combout\ : std_logic;
SIGNAL \UART_inst|Equal2~0_combout\ : std_logic;
SIGNAL \UART_inst|Add2~2_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_counter~4_combout\ : std_logic;
SIGNAL \UART_inst|Equal2~1_combout\ : std_logic;
SIGNAL \UART_inst|Add2~0_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_counter~5_combout\ : std_logic;
SIGNAL \UART_inst|Equal2~2_combout\ : std_logic;
SIGNAL \UART_inst|oversample_baud_tick~q\ : std_logic;
SIGNAL \UART_inst|baud_counter[0]~0_combout\ : std_logic;
SIGNAL \UART_inst|Add0~1_combout\ : std_logic;
SIGNAL \UART_inst|Add0~0_combout\ : std_logic;
SIGNAL \UART_inst|Add0~2_combout\ : std_logic;
SIGNAL \UART_inst|baud_tick~0_combout\ : std_logic;
SIGNAL \UART_inst|baud_tick~1_combout\ : std_logic;
SIGNAL \UART_inst|baud_tick~2_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_state.send_start_bit~0_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_state.send_start_bit~q\ : std_logic;
SIGNAL \UART_inst|uart_tx_count[0]~2_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_data_block[2]~5_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_count[1]~1_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_count[2]~0_combout\ : std_logic;
SIGNAL \UART_inst|Selector11~2_combout\ : std_logic;
SIGNAL \UART_inst|Selector11~4_combout\ : std_logic;
SIGNAL \UART_inst|Selector10~0_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_state.transmit_data~q\ : std_logic;
SIGNAL \UART_inst|Selector11~3_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_state.send_stop_bit~q\ : std_logic;
SIGNAL \UART_inst|Selector7~0_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_state.idle~q\ : std_logic;
SIGNAL \UART_inst|uart_tx_data_block[2]~2_combout\ : std_logic;
SIGNAL \UART_inst|uart_rx_data_in_ack~q\ : std_logic;
SIGNAL \uart_data_in_stb~0_combout\ : std_logic;
SIGNAL \uart_data_in_stb~q\ : std_logic;
SIGNAL \UART_inst|Selector8~2_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_state.wait_for_tick~q\ : std_logic;
SIGNAL \UART_inst|Selector12~0_combout\ : std_logic;
SIGNAL \send_req~inputclkctrl_outclk\ : std_logic;
SIGNAL \send_char[0]~8_combout\ : std_logic;
SIGNAL \send_char[4]~17\ : std_logic;
SIGNAL \send_char[5]~18_combout\ : std_logic;
SIGNAL \~GND~combout\ : std_logic;
SIGNAL \send_char[5]~19\ : std_logic;
SIGNAL \send_char[6]~20_combout\ : std_logic;
SIGNAL \send_char[6]~21\ : std_logic;
SIGNAL \send_char[7]~22_combout\ : std_logic;
SIGNAL \LessThan0~0_combout\ : std_logic;
SIGNAL \LessThan0~1_combout\ : std_logic;
SIGNAL \send_char[0]~9\ : std_logic;
SIGNAL \send_char[1]~10_combout\ : std_logic;
SIGNAL \send_char[1]~11\ : std_logic;
SIGNAL \send_char[2]~12_combout\ : std_logic;
SIGNAL \send_char[2]~13\ : std_logic;
SIGNAL \send_char[3]~14_combout\ : std_logic;
SIGNAL \send_char[3]~15\ : std_logic;
SIGNAL \send_char[4]~16_combout\ : std_logic;
SIGNAL \uart_data_in[4]~feeder_combout\ : std_logic;
SIGNAL \P_TRANS~0_combout\ : std_logic;
SIGNAL \uart_data_in[7]~feeder_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_data_block[7]~4_combout\ : std_logic;
SIGNAL \uart_data_in[6]~0_combout\ : std_logic;
SIGNAL \UART_inst|Selector0~0_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_data_block[2]~3_combout\ : std_logic;
SIGNAL \uart_data_in[5]~feeder_combout\ : std_logic;
SIGNAL \UART_inst|Selector1~0_combout\ : std_logic;
SIGNAL \UART_inst|Selector2~0_combout\ : std_logic;
SIGNAL \uart_data_in[3]~feeder_combout\ : std_logic;
SIGNAL \UART_inst|Selector3~0_combout\ : std_logic;
SIGNAL \uart_data_in[2]~feeder_combout\ : std_logic;
SIGNAL \UART_inst|Selector4~0_combout\ : std_logic;
SIGNAL \UART_inst|Selector5~0_combout\ : std_logic;
SIGNAL \uart_data_in[0]~feeder_combout\ : std_logic;
SIGNAL \UART_inst|Selector6~0_combout\ : std_logic;
SIGNAL \UART_inst|Selector12~1_combout\ : std_logic;
SIGNAL \UART_inst|Selector12~2_combout\ : std_logic;
SIGNAL \UART_inst|uart_tx_data~q\ : std_logic;
SIGNAL send_char : std_logic_vector(7 DOWNTO 0);
SIGNAL \UART_inst|baud_counter\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \UART_inst|uart_tx_data_block\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \UART_inst|uart_tx_count\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \UART_inst|oversample_baud_counter\ : std_logic_vector(8 DOWNTO 0);
SIGNAL uart_data_in : std_logic_vector(7 DOWNTO 0);
SIGNAL \UART_inst|ALT_INV_uart_tx_data~q\ : std_logic;

BEGIN

ww_clk_50m <= clk_50m;
ww_resetn <= resetn;
ww_send_req <= send_req;
ww_rx <= rx;
tx <= ww_tx;
rcv_data <= ww_rcv_data;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\send_req~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \send_req~input_o\);

\clk_50m~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk_50m~input_o\);
\UART_inst|ALT_INV_uart_tx_data~q\ <= NOT \UART_inst|uart_tx_data~q\;

-- Location: IOOBUF_X5_Y43_N9
\tx~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \UART_inst|ALT_INV_uart_tx_data~q\,
	devoe => ww_devoe,
	o => \tx~output_o\);

-- Location: IOOBUF_X0_Y7_N16
\rcv_data[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \rcv_data[0]~output_o\);

-- Location: IOOBUF_X0_Y7_N9
\rcv_data[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \rcv_data[1]~output_o\);

-- Location: IOOBUF_X0_Y11_N2
\rcv_data[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \rcv_data[2]~output_o\);

-- Location: IOOBUF_X0_Y31_N23
\rcv_data[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \rcv_data[3]~output_o\);

-- Location: IOOBUF_X0_Y12_N23
\rcv_data[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \rcv_data[4]~output_o\);

-- Location: IOOBUF_X0_Y11_N16
\rcv_data[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \rcv_data[5]~output_o\);

-- Location: IOOBUF_X0_Y11_N9
\rcv_data[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \rcv_data[6]~output_o\);

-- Location: IOOBUF_X0_Y30_N16
\rcv_data[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \rcv_data[7]~output_o\);

-- Location: IOIBUF_X36_Y0_N15
\clk_50m~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_50m,
	o => \clk_50m~input_o\);

-- Location: CLKCTRL_G19
\clk_50m~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk_50m~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk_50m~inputclkctrl_outclk\);

-- Location: IOIBUF_X0_Y29_N15
\send_req~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_send_req,
	o => \send_req~input_o\);

-- Location: LCCOMB_X1_Y35_N28
\pre_send_req~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \pre_send_req~feeder_combout\ = \send_req~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \send_req~input_o\,
	combout => \pre_send_req~feeder_combout\);

-- Location: IOIBUF_X0_Y39_N1
\resetn~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_resetn,
	o => \resetn~input_o\);

-- Location: FF_X1_Y35_N29
pre_send_req : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \pre_send_req~feeder_combout\,
	ena => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pre_send_req~q\);

-- Location: LCCOMB_X1_Y38_N0
\UART_inst|Add2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add2~0_combout\ = \UART_inst|oversample_baud_counter\(0) $ (VCC)
-- \UART_inst|Add2~1\ = CARRY(\UART_inst|oversample_baud_counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \UART_inst|oversample_baud_counter\(0),
	datad => VCC,
	combout => \UART_inst|Add2~0_combout\,
	cout => \UART_inst|Add2~1\);

-- Location: LCCOMB_X1_Y38_N2
\UART_inst|Add2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add2~2_combout\ = (\UART_inst|oversample_baud_counter\(1) & (\UART_inst|Add2~1\ & VCC)) # (!\UART_inst|oversample_baud_counter\(1) & (!\UART_inst|Add2~1\))
-- \UART_inst|Add2~3\ = CARRY((!\UART_inst|oversample_baud_counter\(1) & !\UART_inst|Add2~1\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(1),
	datad => VCC,
	cin => \UART_inst|Add2~1\,
	combout => \UART_inst|Add2~2_combout\,
	cout => \UART_inst|Add2~3\);

-- Location: LCCOMB_X1_Y38_N4
\UART_inst|Add2~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add2~4_combout\ = (\UART_inst|oversample_baud_counter\(2) & (\UART_inst|Add2~3\ $ (GND))) # (!\UART_inst|oversample_baud_counter\(2) & ((GND) # (!\UART_inst|Add2~3\)))
-- \UART_inst|Add2~5\ = CARRY((!\UART_inst|Add2~3\) # (!\UART_inst|oversample_baud_counter\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \UART_inst|oversample_baud_counter\(2),
	datad => VCC,
	cin => \UART_inst|Add2~3\,
	combout => \UART_inst|Add2~4_combout\,
	cout => \UART_inst|Add2~5\);

-- Location: LCCOMB_X1_Y38_N20
\UART_inst|oversample_baud_counter[2]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|oversample_baud_counter[2]~8_combout\ = !\UART_inst|Add2~4_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \UART_inst|Add2~4_combout\,
	combout => \UART_inst|oversample_baud_counter[2]~8_combout\);

-- Location: FF_X1_Y38_N21
\UART_inst|oversample_baud_counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|oversample_baud_counter[2]~8_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_counter\(2));

-- Location: LCCOMB_X1_Y38_N6
\UART_inst|Add2~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add2~6_combout\ = (\UART_inst|oversample_baud_counter\(3) & (\UART_inst|Add2~5\ & VCC)) # (!\UART_inst|oversample_baud_counter\(3) & (!\UART_inst|Add2~5\))
-- \UART_inst|Add2~7\ = CARRY((!\UART_inst|oversample_baud_counter\(3) & !\UART_inst|Add2~5\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \UART_inst|oversample_baud_counter\(3),
	datad => VCC,
	cin => \UART_inst|Add2~5\,
	combout => \UART_inst|Add2~6_combout\,
	cout => \UART_inst|Add2~7\);

-- Location: LCCOMB_X1_Y38_N28
\UART_inst|oversample_baud_counter~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|oversample_baud_counter~3_combout\ = (\UART_inst|Add2~6_combout\ & ((\UART_inst|oversample_baud_counter\(0)) # ((!\UART_inst|Equal2~0_combout\) # (!\UART_inst|Equal2~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(0),
	datab => \UART_inst|Equal2~1_combout\,
	datac => \UART_inst|Equal2~0_combout\,
	datad => \UART_inst|Add2~6_combout\,
	combout => \UART_inst|oversample_baud_counter~3_combout\);

-- Location: FF_X1_Y38_N29
\UART_inst|oversample_baud_counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|oversample_baud_counter~3_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_counter\(3));

-- Location: LCCOMB_X1_Y38_N8
\UART_inst|Add2~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add2~8_combout\ = (\UART_inst|oversample_baud_counter\(4) & ((GND) # (!\UART_inst|Add2~7\))) # (!\UART_inst|oversample_baud_counter\(4) & (\UART_inst|Add2~7\ $ (GND)))
-- \UART_inst|Add2~9\ = CARRY((\UART_inst|oversample_baud_counter\(4)) # (!\UART_inst|Add2~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101010101111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(4),
	datad => VCC,
	cin => \UART_inst|Add2~7\,
	combout => \UART_inst|Add2~8_combout\,
	cout => \UART_inst|Add2~9\);

-- Location: LCCOMB_X1_Y38_N30
\UART_inst|oversample_baud_counter~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|oversample_baud_counter~2_combout\ = (\UART_inst|Add2~8_combout\ & ((\UART_inst|oversample_baud_counter\(0)) # ((!\UART_inst|Equal2~0_combout\) # (!\UART_inst|Equal2~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(0),
	datab => \UART_inst|Equal2~1_combout\,
	datac => \UART_inst|Add2~8_combout\,
	datad => \UART_inst|Equal2~0_combout\,
	combout => \UART_inst|oversample_baud_counter~2_combout\);

-- Location: FF_X1_Y38_N31
\UART_inst|oversample_baud_counter[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|oversample_baud_counter~2_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_counter\(4));

-- Location: LCCOMB_X1_Y38_N10
\UART_inst|Add2~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add2~10_combout\ = (\UART_inst|oversample_baud_counter\(5) & (\UART_inst|Add2~9\ & VCC)) # (!\UART_inst|oversample_baud_counter\(5) & (!\UART_inst|Add2~9\))
-- \UART_inst|Add2~11\ = CARRY((!\UART_inst|oversample_baud_counter\(5) & !\UART_inst|Add2~9\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(5),
	datad => VCC,
	cin => \UART_inst|Add2~9\,
	combout => \UART_inst|Add2~10_combout\,
	cout => \UART_inst|Add2~11\);

-- Location: LCCOMB_X2_Y38_N20
\UART_inst|oversample_baud_counter~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|oversample_baud_counter~1_combout\ = (\UART_inst|Add2~10_combout\ & ((\UART_inst|oversample_baud_counter\(0)) # ((!\UART_inst|Equal2~0_combout\) # (!\UART_inst|Equal2~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(0),
	datab => \UART_inst|Equal2~1_combout\,
	datac => \UART_inst|Equal2~0_combout\,
	datad => \UART_inst|Add2~10_combout\,
	combout => \UART_inst|oversample_baud_counter~1_combout\);

-- Location: FF_X2_Y38_N21
\UART_inst|oversample_baud_counter[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|oversample_baud_counter~1_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_counter\(5));

-- Location: LCCOMB_X1_Y38_N12
\UART_inst|Add2~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add2~12_combout\ = (\UART_inst|oversample_baud_counter\(6) & (\UART_inst|Add2~11\ $ (GND))) # (!\UART_inst|oversample_baud_counter\(6) & ((GND) # (!\UART_inst|Add2~11\)))
-- \UART_inst|Add2~13\ = CARRY((!\UART_inst|Add2~11\) # (!\UART_inst|oversample_baud_counter\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \UART_inst|oversample_baud_counter\(6),
	datad => VCC,
	cin => \UART_inst|Add2~11\,
	combout => \UART_inst|Add2~12_combout\,
	cout => \UART_inst|Add2~13\);

-- Location: LCCOMB_X1_Y38_N24
\UART_inst|oversample_baud_counter[6]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|oversample_baud_counter[6]~7_combout\ = !\UART_inst|Add2~12_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \UART_inst|Add2~12_combout\,
	combout => \UART_inst|oversample_baud_counter[6]~7_combout\);

-- Location: FF_X1_Y38_N25
\UART_inst|oversample_baud_counter[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|oversample_baud_counter[6]~7_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_counter\(6));

-- Location: LCCOMB_X1_Y38_N14
\UART_inst|Add2~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add2~14_combout\ = (\UART_inst|oversample_baud_counter\(7) & (\UART_inst|Add2~13\ & VCC)) # (!\UART_inst|oversample_baud_counter\(7) & (!\UART_inst|Add2~13\))
-- \UART_inst|Add2~15\ = CARRY((!\UART_inst|oversample_baud_counter\(7) & !\UART_inst|Add2~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(7),
	datad => VCC,
	cin => \UART_inst|Add2~13\,
	combout => \UART_inst|Add2~14_combout\,
	cout => \UART_inst|Add2~15\);

-- Location: LCCOMB_X1_Y38_N22
\UART_inst|oversample_baud_counter~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|oversample_baud_counter~0_combout\ = (\UART_inst|Add2~14_combout\ & ((\UART_inst|oversample_baud_counter\(0)) # ((!\UART_inst|Equal2~0_combout\) # (!\UART_inst|Equal2~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(0),
	datab => \UART_inst|Equal2~1_combout\,
	datac => \UART_inst|Add2~14_combout\,
	datad => \UART_inst|Equal2~0_combout\,
	combout => \UART_inst|oversample_baud_counter~0_combout\);

-- Location: FF_X1_Y38_N23
\UART_inst|oversample_baud_counter[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|oversample_baud_counter~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_counter\(7));

-- Location: LCCOMB_X1_Y38_N16
\UART_inst|Add2~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add2~16_combout\ = \UART_inst|Add2~15\ $ (!\UART_inst|oversample_baud_counter\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \UART_inst|oversample_baud_counter\(8),
	cin => \UART_inst|Add2~15\,
	combout => \UART_inst|Add2~16_combout\);

-- Location: LCCOMB_X1_Y38_N18
\UART_inst|oversample_baud_counter[8]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|oversample_baud_counter[8]~6_combout\ = !\UART_inst|Add2~16_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \UART_inst|Add2~16_combout\,
	combout => \UART_inst|oversample_baud_counter[8]~6_combout\);

-- Location: FF_X1_Y38_N19
\UART_inst|oversample_baud_counter[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|oversample_baud_counter[8]~6_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_counter\(8));

-- Location: LCCOMB_X2_Y38_N18
\UART_inst|Equal2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Equal2~0_combout\ = (!\UART_inst|oversample_baud_counter\(5) & (\UART_inst|oversample_baud_counter\(8) & (\UART_inst|oversample_baud_counter\(6) & !\UART_inst|oversample_baud_counter\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(5),
	datab => \UART_inst|oversample_baud_counter\(8),
	datac => \UART_inst|oversample_baud_counter\(6),
	datad => \UART_inst|oversample_baud_counter\(7),
	combout => \UART_inst|Equal2~0_combout\);

-- Location: LCCOMB_X1_Y38_N26
\UART_inst|oversample_baud_counter~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|oversample_baud_counter~4_combout\ = (\UART_inst|Add2~2_combout\ & ((\UART_inst|oversample_baud_counter\(0)) # ((!\UART_inst|Equal2~1_combout\) # (!\UART_inst|Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(0),
	datab => \UART_inst|Equal2~0_combout\,
	datac => \UART_inst|Add2~2_combout\,
	datad => \UART_inst|Equal2~1_combout\,
	combout => \UART_inst|oversample_baud_counter~4_combout\);

-- Location: FF_X1_Y38_N27
\UART_inst|oversample_baud_counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|oversample_baud_counter~4_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_counter\(1));

-- Location: LCCOMB_X2_Y38_N28
\UART_inst|Equal2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Equal2~1_combout\ = (!\UART_inst|oversample_baud_counter\(1) & (!\UART_inst|oversample_baud_counter\(3) & (\UART_inst|oversample_baud_counter\(2) & !\UART_inst|oversample_baud_counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(1),
	datab => \UART_inst|oversample_baud_counter\(3),
	datac => \UART_inst|oversample_baud_counter\(2),
	datad => \UART_inst|oversample_baud_counter\(4),
	combout => \UART_inst|Equal2~1_combout\);

-- Location: LCCOMB_X2_Y38_N30
\UART_inst|oversample_baud_counter~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|oversample_baud_counter~5_combout\ = (\UART_inst|Add2~0_combout\ & ((\UART_inst|oversample_baud_counter\(0)) # ((!\UART_inst|Equal2~0_combout\) # (!\UART_inst|Equal2~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_counter\(0),
	datab => \UART_inst|Equal2~1_combout\,
	datac => \UART_inst|Add2~0_combout\,
	datad => \UART_inst|Equal2~0_combout\,
	combout => \UART_inst|oversample_baud_counter~5_combout\);

-- Location: FF_X1_Y38_N3
\UART_inst|oversample_baud_counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	asdata => \UART_inst|oversample_baud_counter~5_combout\,
	clrn => \resetn~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_counter\(0));

-- Location: LCCOMB_X2_Y36_N10
\UART_inst|Equal2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Equal2~2_combout\ = (!\UART_inst|oversample_baud_counter\(0) & (\UART_inst|Equal2~0_combout\ & \UART_inst|Equal2~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \UART_inst|oversample_baud_counter\(0),
	datac => \UART_inst|Equal2~0_combout\,
	datad => \UART_inst|Equal2~1_combout\,
	combout => \UART_inst|Equal2~2_combout\);

-- Location: FF_X2_Y36_N11
\UART_inst|oversample_baud_tick\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Equal2~2_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|oversample_baud_tick~q\);

-- Location: LCCOMB_X2_Y36_N16
\UART_inst|baud_counter[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|baud_counter[0]~0_combout\ = !\UART_inst|baud_counter\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \UART_inst|baud_counter\(0),
	combout => \UART_inst|baud_counter[0]~0_combout\);

-- Location: FF_X2_Y36_N17
\UART_inst|baud_counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|baud_counter[0]~0_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|oversample_baud_tick~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|baud_counter\(0));

-- Location: LCCOMB_X2_Y36_N26
\UART_inst|Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add0~1_combout\ = \UART_inst|baud_counter\(1) $ (\UART_inst|baud_counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \UART_inst|baud_counter\(1),
	datad => \UART_inst|baud_counter\(0),
	combout => \UART_inst|Add0~1_combout\);

-- Location: FF_X2_Y36_N27
\UART_inst|baud_counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Add0~1_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|oversample_baud_tick~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|baud_counter\(1));

-- Location: LCCOMB_X2_Y36_N28
\UART_inst|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add0~0_combout\ = \UART_inst|baud_counter\(2) $ (((\UART_inst|baud_counter\(1) & \UART_inst|baud_counter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|baud_counter\(1),
	datab => \UART_inst|baud_counter\(0),
	datac => \UART_inst|baud_counter\(2),
	combout => \UART_inst|Add0~0_combout\);

-- Location: FF_X2_Y36_N29
\UART_inst|baud_counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Add0~0_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|oversample_baud_tick~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|baud_counter\(2));

-- Location: LCCOMB_X2_Y36_N0
\UART_inst|Add0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Add0~2_combout\ = \UART_inst|baud_counter\(3) $ (((\UART_inst|baud_counter\(1) & (\UART_inst|baud_counter\(0) & \UART_inst|baud_counter\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|baud_counter\(1),
	datab => \UART_inst|baud_counter\(0),
	datac => \UART_inst|baud_counter\(3),
	datad => \UART_inst|baud_counter\(2),
	combout => \UART_inst|Add0~2_combout\);

-- Location: FF_X2_Y36_N1
\UART_inst|baud_counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Add0~2_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|oversample_baud_tick~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|baud_counter\(3));

-- Location: LCCOMB_X2_Y36_N6
\UART_inst|baud_tick~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|baud_tick~0_combout\ = (\resetn~input_o\ & (\UART_inst|baud_counter\(2) & (\UART_inst|baud_counter\(1) & \UART_inst|baud_counter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \resetn~input_o\,
	datab => \UART_inst|baud_counter\(2),
	datac => \UART_inst|baud_counter\(1),
	datad => \UART_inst|baud_counter\(0),
	combout => \UART_inst|baud_tick~0_combout\);

-- Location: LCCOMB_X2_Y36_N4
\UART_inst|baud_tick~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|baud_tick~1_combout\ = (\UART_inst|oversample_baud_tick~q\ & (\UART_inst|baud_counter\(3) & \UART_inst|baud_tick~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|oversample_baud_tick~q\,
	datab => \UART_inst|baud_counter\(3),
	datad => \UART_inst|baud_tick~0_combout\,
	combout => \UART_inst|baud_tick~1_combout\);

-- Location: LCCOMB_X2_Y36_N14
\UART_inst|baud_tick~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|baud_tick~2_combout\ = (\UART_inst|baud_counter\(3) & \UART_inst|oversample_baud_tick~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \UART_inst|baud_counter\(3),
	datad => \UART_inst|oversample_baud_tick~q\,
	combout => \UART_inst|baud_tick~2_combout\);

-- Location: LCCOMB_X3_Y36_N24
\UART_inst|uart_tx_state.send_start_bit~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|uart_tx_state.send_start_bit~0_combout\ = (\UART_inst|baud_tick~2_combout\ & ((\UART_inst|baud_tick~0_combout\ & ((\UART_inst|uart_tx_state.wait_for_tick~q\))) # (!\UART_inst|baud_tick~0_combout\ & 
-- (\UART_inst|uart_tx_state.send_start_bit~q\)))) # (!\UART_inst|baud_tick~2_combout\ & (((\UART_inst|uart_tx_state.send_start_bit~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|baud_tick~2_combout\,
	datab => \UART_inst|baud_tick~0_combout\,
	datac => \UART_inst|uart_tx_state.send_start_bit~q\,
	datad => \UART_inst|uart_tx_state.wait_for_tick~q\,
	combout => \UART_inst|uart_tx_state.send_start_bit~0_combout\);

-- Location: FF_X3_Y36_N25
\UART_inst|uart_tx_state.send_start_bit\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|uart_tx_state.send_start_bit~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_state.send_start_bit~q\);

-- Location: LCCOMB_X1_Y36_N8
\UART_inst|uart_tx_count[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|uart_tx_count[0]~2_combout\ = \UART_inst|uart_tx_count\(0) $ (((\UART_inst|uart_tx_state.transmit_data~q\ & (\UART_inst|baud_tick~2_combout\ & \UART_inst|baud_tick~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.transmit_data~q\,
	datab => \UART_inst|baud_tick~2_combout\,
	datac => \UART_inst|uart_tx_count\(0),
	datad => \UART_inst|baud_tick~0_combout\,
	combout => \UART_inst|uart_tx_count[0]~2_combout\);

-- Location: FF_X1_Y36_N9
\UART_inst|uart_tx_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|uart_tx_count[0]~2_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_count\(0));

-- Location: LCCOMB_X1_Y36_N6
\UART_inst|uart_tx_data_block[2]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|uart_tx_data_block[2]~5_combout\ = (((!\UART_inst|baud_tick~0_combout\) # (!\UART_inst|oversample_baud_tick~q\)) # (!\UART_inst|baud_counter\(3))) # (!\UART_inst|uart_tx_state.transmit_data~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.transmit_data~q\,
	datab => \UART_inst|baud_counter\(3),
	datac => \UART_inst|oversample_baud_tick~q\,
	datad => \UART_inst|baud_tick~0_combout\,
	combout => \UART_inst|uart_tx_data_block[2]~5_combout\);

-- Location: LCCOMB_X1_Y36_N30
\UART_inst|uart_tx_count[1]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|uart_tx_count[1]~1_combout\ = \UART_inst|uart_tx_count\(1) $ (((\UART_inst|uart_tx_count\(0) & !\UART_inst|uart_tx_data_block[2]~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \UART_inst|uart_tx_count\(0),
	datac => \UART_inst|uart_tx_count\(1),
	datad => \UART_inst|uart_tx_data_block[2]~5_combout\,
	combout => \UART_inst|uart_tx_count[1]~1_combout\);

-- Location: FF_X1_Y36_N31
\UART_inst|uart_tx_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|uart_tx_count[1]~1_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_count\(1));

-- Location: LCCOMB_X1_Y36_N16
\UART_inst|uart_tx_count[2]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|uart_tx_count[2]~0_combout\ = \UART_inst|uart_tx_count\(2) $ (((\UART_inst|uart_tx_count\(1) & (\UART_inst|uart_tx_count\(0) & !\UART_inst|uart_tx_data_block[2]~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_count\(1),
	datab => \UART_inst|uart_tx_count\(0),
	datac => \UART_inst|uart_tx_count\(2),
	datad => \UART_inst|uart_tx_data_block[2]~5_combout\,
	combout => \UART_inst|uart_tx_count[2]~0_combout\);

-- Location: FF_X1_Y36_N17
\UART_inst|uart_tx_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|uart_tx_count[2]~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_count\(2));

-- Location: LCCOMB_X1_Y36_N14
\UART_inst|Selector11~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector11~2_combout\ = (\UART_inst|uart_tx_count\(0) & (\UART_inst|uart_tx_count\(1) & \UART_inst|uart_tx_count\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \UART_inst|uart_tx_count\(0),
	datac => \UART_inst|uart_tx_count\(1),
	datad => \UART_inst|uart_tx_count\(2),
	combout => \UART_inst|Selector11~2_combout\);

-- Location: LCCOMB_X2_Y36_N2
\UART_inst|Selector11~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector11~4_combout\ = (\UART_inst|baud_tick~0_combout\ & (\UART_inst|baud_counter\(3) & (\UART_inst|oversample_baud_tick~q\ & \UART_inst|Selector11~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|baud_tick~0_combout\,
	datab => \UART_inst|baud_counter\(3),
	datac => \UART_inst|oversample_baud_tick~q\,
	datad => \UART_inst|Selector11~2_combout\,
	combout => \UART_inst|Selector11~4_combout\);

-- Location: LCCOMB_X2_Y36_N30
\UART_inst|Selector10~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector10~0_combout\ = (\UART_inst|baud_tick~1_combout\ & ((\UART_inst|uart_tx_state.send_start_bit~q\) # ((\UART_inst|uart_tx_state.transmit_data~q\ & !\UART_inst|Selector11~4_combout\)))) # (!\UART_inst|baud_tick~1_combout\ & 
-- (((\UART_inst|uart_tx_state.transmit_data~q\ & !\UART_inst|Selector11~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|baud_tick~1_combout\,
	datab => \UART_inst|uart_tx_state.send_start_bit~q\,
	datac => \UART_inst|uart_tx_state.transmit_data~q\,
	datad => \UART_inst|Selector11~4_combout\,
	combout => \UART_inst|Selector10~0_combout\);

-- Location: FF_X2_Y36_N31
\UART_inst|uart_tx_state.transmit_data\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector10~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_state.transmit_data~q\);

-- Location: LCCOMB_X2_Y36_N8
\UART_inst|Selector11~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector11~3_combout\ = (\UART_inst|uart_tx_state.transmit_data~q\ & ((\UART_inst|Selector11~4_combout\) # ((!\UART_inst|baud_tick~1_combout\ & \UART_inst|uart_tx_state.send_stop_bit~q\)))) # (!\UART_inst|uart_tx_state.transmit_data~q\ & 
-- (!\UART_inst|baud_tick~1_combout\ & (\UART_inst|uart_tx_state.send_stop_bit~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.transmit_data~q\,
	datab => \UART_inst|baud_tick~1_combout\,
	datac => \UART_inst|uart_tx_state.send_stop_bit~q\,
	datad => \UART_inst|Selector11~4_combout\,
	combout => \UART_inst|Selector11~3_combout\);

-- Location: FF_X2_Y36_N9
\UART_inst|uart_tx_state.send_stop_bit\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector11~3_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_state.send_stop_bit~q\);

-- Location: LCCOMB_X1_Y36_N24
\UART_inst|Selector7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector7~0_combout\ = (\UART_inst|uart_tx_state.send_stop_bit~q\ & (!\UART_inst|baud_tick~1_combout\ & ((\uart_data_in_stb~q\) # (\UART_inst|uart_tx_state.idle~q\)))) # (!\UART_inst|uart_tx_state.send_stop_bit~q\ & ((\uart_data_in_stb~q\) # 
-- ((\UART_inst|uart_tx_state.idle~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.send_stop_bit~q\,
	datab => \uart_data_in_stb~q\,
	datac => \UART_inst|uart_tx_state.idle~q\,
	datad => \UART_inst|baud_tick~1_combout\,
	combout => \UART_inst|Selector7~0_combout\);

-- Location: FF_X1_Y36_N25
\UART_inst|uart_tx_state.idle\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector7~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_state.idle~q\);

-- Location: LCCOMB_X1_Y36_N18
\UART_inst|uart_tx_data_block[2]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|uart_tx_data_block[2]~2_combout\ = (\uart_data_in_stb~q\ & !\UART_inst|uart_tx_state.idle~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart_data_in_stb~q\,
	datad => \UART_inst|uart_tx_state.idle~q\,
	combout => \UART_inst|uart_tx_data_block[2]~2_combout\);

-- Location: FF_X1_Y36_N19
\UART_inst|uart_rx_data_in_ack\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|uart_tx_data_block[2]~2_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_rx_data_in_ack~q\);

-- Location: LCCOMB_X1_Y36_N28
\uart_data_in_stb~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \uart_data_in_stb~0_combout\ = (\pre_send_req~q\ & (!\UART_inst|uart_rx_data_in_ack~q\ & (\uart_data_in_stb~q\))) # (!\pre_send_req~q\ & ((\send_req~input_o\) # ((!\UART_inst|uart_rx_data_in_ack~q\ & \uart_data_in_stb~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pre_send_req~q\,
	datab => \UART_inst|uart_rx_data_in_ack~q\,
	datac => \uart_data_in_stb~q\,
	datad => \send_req~input_o\,
	combout => \uart_data_in_stb~0_combout\);

-- Location: FF_X1_Y36_N29
uart_data_in_stb : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \uart_data_in_stb~0_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \uart_data_in_stb~q\);

-- Location: LCCOMB_X2_Y36_N18
\UART_inst|Selector8~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector8~2_combout\ = (\UART_inst|uart_tx_state.idle~q\ & (((!\UART_inst|baud_tick~1_combout\ & \UART_inst|uart_tx_state.wait_for_tick~q\)))) # (!\UART_inst|uart_tx_state.idle~q\ & (\uart_data_in_stb~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_data_in_stb~q\,
	datab => \UART_inst|baud_tick~1_combout\,
	datac => \UART_inst|uart_tx_state.wait_for_tick~q\,
	datad => \UART_inst|uart_tx_state.idle~q\,
	combout => \UART_inst|Selector8~2_combout\);

-- Location: FF_X2_Y36_N19
\UART_inst|uart_tx_state.wait_for_tick\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector8~2_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_state.wait_for_tick~q\);

-- Location: LCCOMB_X2_Y36_N22
\UART_inst|Selector12~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector12~0_combout\ = (\UART_inst|uart_tx_data~q\ & (((\UART_inst|uart_tx_state.send_stop_bit~q\)))) # (!\UART_inst|uart_tx_data~q\ & (!\UART_inst|uart_tx_state.wait_for_tick~q\ & (!\UART_inst|uart_tx_state.send_stop_bit~q\ & 
-- \UART_inst|uart_tx_state.idle~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_data~q\,
	datab => \UART_inst|uart_tx_state.wait_for_tick~q\,
	datac => \UART_inst|uart_tx_state.send_stop_bit~q\,
	datad => \UART_inst|uart_tx_state.idle~q\,
	combout => \UART_inst|Selector12~0_combout\);

-- Location: CLKCTRL_G0
\send_req~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \send_req~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \send_req~inputclkctrl_outclk\);

-- Location: LCCOMB_X2_Y35_N6
\send_char[0]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \send_char[0]~8_combout\ = send_char(0) $ (VCC)
-- \send_char[0]~9\ = CARRY(send_char(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => send_char(0),
	datad => VCC,
	combout => \send_char[0]~8_combout\,
	cout => \send_char[0]~9\);

-- Location: LCCOMB_X2_Y35_N14
\send_char[4]~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \send_char[4]~16_combout\ = (send_char(4) & (\send_char[3]~15\ $ (GND))) # (!send_char(4) & (!\send_char[3]~15\ & VCC))
-- \send_char[4]~17\ = CARRY((send_char(4) & !\send_char[3]~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => send_char(4),
	datad => VCC,
	cin => \send_char[3]~15\,
	combout => \send_char[4]~16_combout\,
	cout => \send_char[4]~17\);

-- Location: LCCOMB_X2_Y35_N16
\send_char[5]~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \send_char[5]~18_combout\ = (send_char(5) & (!\send_char[4]~17\)) # (!send_char(5) & ((\send_char[4]~17\) # (GND)))
-- \send_char[5]~19\ = CARRY((!\send_char[4]~17\) # (!send_char(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => send_char(5),
	datad => VCC,
	cin => \send_char[4]~17\,
	combout => \send_char[5]~18_combout\,
	cout => \send_char[5]~19\);

-- Location: LCCOMB_X3_Y35_N12
\~GND\ : cycloneive_lcell_comb
-- Equation(s):
-- \~GND~combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~GND~combout\);

-- Location: FF_X2_Y35_N17
\send_char[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \send_req~inputclkctrl_outclk\,
	d => \send_char[5]~18_combout\,
	asdata => \~GND~combout\,
	clrn => \resetn~input_o\,
	sload => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => send_char(5));

-- Location: LCCOMB_X2_Y35_N18
\send_char[6]~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \send_char[6]~20_combout\ = (send_char(6) & (\send_char[5]~19\ & VCC)) # (!send_char(6) & (!\send_char[5]~19\))
-- \send_char[6]~21\ = CARRY((!send_char(6) & !\send_char[5]~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => send_char(6),
	datad => VCC,
	cin => \send_char[5]~19\,
	combout => \send_char[6]~20_combout\,
	cout => \send_char[6]~21\);

-- Location: FF_X2_Y35_N19
\send_char[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \send_req~inputclkctrl_outclk\,
	d => \send_char[6]~20_combout\,
	asdata => \~GND~combout\,
	clrn => \resetn~input_o\,
	sload => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => send_char(6));

-- Location: LCCOMB_X2_Y35_N20
\send_char[7]~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \send_char[7]~22_combout\ = \send_char[6]~21\ $ (send_char(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => send_char(7),
	cin => \send_char[6]~21\,
	combout => \send_char[7]~22_combout\);

-- Location: FF_X2_Y35_N21
\send_char[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \send_req~inputclkctrl_outclk\,
	d => \send_char[7]~22_combout\,
	asdata => \~GND~combout\,
	clrn => \resetn~input_o\,
	sload => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => send_char(7));

-- Location: LCCOMB_X2_Y35_N28
\LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \LessThan0~0_combout\ = (((!send_char(2) & !send_char(1))) # (!send_char(3))) # (!send_char(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => send_char(2),
	datab => send_char(1),
	datac => send_char(4),
	datad => send_char(3),
	combout => \LessThan0~0_combout\);

-- Location: LCCOMB_X2_Y35_N2
\LessThan0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \LessThan0~1_combout\ = (send_char(7)) # ((!send_char(6) & ((send_char(5)) # (!\LessThan0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010011110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => send_char(6),
	datab => send_char(5),
	datac => send_char(7),
	datad => \LessThan0~0_combout\,
	combout => \LessThan0~1_combout\);

-- Location: FF_X2_Y35_N7
\send_char[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \send_req~inputclkctrl_outclk\,
	d => \send_char[0]~8_combout\,
	asdata => VCC,
	clrn => \resetn~input_o\,
	sload => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => send_char(0));

-- Location: LCCOMB_X2_Y35_N8
\send_char[1]~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \send_char[1]~10_combout\ = (send_char(1) & (!\send_char[0]~9\)) # (!send_char(1) & ((\send_char[0]~9\) # (GND)))
-- \send_char[1]~11\ = CARRY((!\send_char[0]~9\) # (!send_char(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => send_char(1),
	datad => VCC,
	cin => \send_char[0]~9\,
	combout => \send_char[1]~10_combout\,
	cout => \send_char[1]~11\);

-- Location: FF_X2_Y35_N9
\send_char[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \send_req~inputclkctrl_outclk\,
	d => \send_char[1]~10_combout\,
	asdata => \~GND~combout\,
	clrn => \resetn~input_o\,
	sload => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => send_char(1));

-- Location: LCCOMB_X2_Y35_N10
\send_char[2]~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \send_char[2]~12_combout\ = (send_char(2) & (\send_char[1]~11\ $ (GND))) # (!send_char(2) & (!\send_char[1]~11\ & VCC))
-- \send_char[2]~13\ = CARRY((send_char(2) & !\send_char[1]~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => send_char(2),
	datad => VCC,
	cin => \send_char[1]~11\,
	combout => \send_char[2]~12_combout\,
	cout => \send_char[2]~13\);

-- Location: FF_X2_Y35_N11
\send_char[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \send_req~inputclkctrl_outclk\,
	d => \send_char[2]~12_combout\,
	asdata => \~GND~combout\,
	clrn => \resetn~input_o\,
	sload => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => send_char(2));

-- Location: LCCOMB_X2_Y35_N12
\send_char[3]~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \send_char[3]~14_combout\ = (send_char(3) & (!\send_char[2]~13\)) # (!send_char(3) & ((\send_char[2]~13\) # (GND)))
-- \send_char[3]~15\ = CARRY((!\send_char[2]~13\) # (!send_char(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => send_char(3),
	datad => VCC,
	cin => \send_char[2]~13\,
	combout => \send_char[3]~14_combout\,
	cout => \send_char[3]~15\);

-- Location: FF_X2_Y35_N13
\send_char[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \send_req~inputclkctrl_outclk\,
	d => \send_char[3]~14_combout\,
	asdata => \~GND~combout\,
	clrn => \resetn~input_o\,
	sload => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => send_char(3));

-- Location: FF_X2_Y35_N15
\send_char[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \send_req~inputclkctrl_outclk\,
	d => \send_char[4]~16_combout\,
	asdata => \~GND~combout\,
	clrn => \resetn~input_o\,
	sload => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => send_char(4));

-- Location: LCCOMB_X2_Y35_N22
\uart_data_in[4]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \uart_data_in[4]~feeder_combout\ = send_char(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => send_char(4),
	combout => \uart_data_in[4]~feeder_combout\);

-- Location: LCCOMB_X1_Y35_N22
\P_TRANS~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \P_TRANS~0_combout\ = (\send_req~input_o\ & !\pre_send_req~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \send_req~input_o\,
	datad => \pre_send_req~q\,
	combout => \P_TRANS~0_combout\);

-- Location: FF_X2_Y35_N23
\uart_data_in[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \uart_data_in[4]~feeder_combout\,
	clrn => \resetn~input_o\,
	ena => \P_TRANS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => uart_data_in(4));

-- Location: LCCOMB_X2_Y35_N30
\uart_data_in[7]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \uart_data_in[7]~feeder_combout\ = send_char(7)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => send_char(7),
	combout => \uart_data_in[7]~feeder_combout\);

-- Location: FF_X2_Y35_N31
\uart_data_in[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \uart_data_in[7]~feeder_combout\,
	clrn => \resetn~input_o\,
	ena => \P_TRANS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => uart_data_in(7));

-- Location: LCCOMB_X2_Y36_N20
\UART_inst|uart_tx_data_block[7]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|uart_tx_data_block[7]~4_combout\ = (\UART_inst|uart_tx_state.idle~q\ & (((\UART_inst|uart_tx_data_block\(7))))) # (!\UART_inst|uart_tx_state.idle~q\ & ((\uart_data_in_stb~q\ & (uart_data_in(7))) # (!\uart_data_in_stb~q\ & 
-- ((\UART_inst|uart_tx_data_block\(7))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => uart_data_in(7),
	datab => \UART_inst|uart_tx_state.idle~q\,
	datac => \UART_inst|uart_tx_data_block\(7),
	datad => \uart_data_in_stb~q\,
	combout => \UART_inst|uart_tx_data_block[7]~4_combout\);

-- Location: FF_X2_Y36_N21
\UART_inst|uart_tx_data_block[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|uart_tx_data_block[7]~4_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_data_block\(7));

-- Location: LCCOMB_X2_Y35_N24
\uart_data_in[6]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \uart_data_in[6]~0_combout\ = !send_char(6)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => send_char(6),
	combout => \uart_data_in[6]~0_combout\);

-- Location: FF_X2_Y35_N25
\uart_data_in[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \uart_data_in[6]~0_combout\,
	clrn => \resetn~input_o\,
	ena => \P_TRANS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => uart_data_in(6));

-- Location: LCCOMB_X1_Y36_N4
\UART_inst|Selector0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector0~0_combout\ = (\UART_inst|uart_tx_state.transmit_data~q\ & (\UART_inst|uart_tx_data_block\(7))) # (!\UART_inst|uart_tx_state.transmit_data~q\ & ((uart_data_in(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.transmit_data~q\,
	datac => \UART_inst|uart_tx_data_block\(7),
	datad => uart_data_in(6),
	combout => \UART_inst|Selector0~0_combout\);

-- Location: LCCOMB_X1_Y36_N2
\UART_inst|uart_tx_data_block[2]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|uart_tx_data_block[2]~3_combout\ = (\UART_inst|uart_tx_data_block[2]~2_combout\) # ((\UART_inst|uart_tx_state.transmit_data~q\ & (\UART_inst|baud_tick~2_combout\ & \UART_inst|baud_tick~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.transmit_data~q\,
	datab => \UART_inst|uart_tx_data_block[2]~2_combout\,
	datac => \UART_inst|baud_tick~2_combout\,
	datad => \UART_inst|baud_tick~0_combout\,
	combout => \UART_inst|uart_tx_data_block[2]~3_combout\);

-- Location: FF_X1_Y36_N5
\UART_inst|uart_tx_data_block[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector0~0_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|uart_tx_data_block[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_data_block\(6));

-- Location: LCCOMB_X1_Y35_N12
\uart_data_in[5]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \uart_data_in[5]~feeder_combout\ = send_char(5)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => send_char(5),
	combout => \uart_data_in[5]~feeder_combout\);

-- Location: FF_X1_Y35_N13
\uart_data_in[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \uart_data_in[5]~feeder_combout\,
	clrn => \resetn~input_o\,
	ena => \P_TRANS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => uart_data_in(5));

-- Location: LCCOMB_X1_Y36_N10
\UART_inst|Selector1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector1~0_combout\ = (\UART_inst|uart_tx_state.transmit_data~q\ & (\UART_inst|uart_tx_data_block\(6))) # (!\UART_inst|uart_tx_state.transmit_data~q\ & ((uart_data_in(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.transmit_data~q\,
	datac => \UART_inst|uart_tx_data_block\(6),
	datad => uart_data_in(5),
	combout => \UART_inst|Selector1~0_combout\);

-- Location: FF_X1_Y36_N11
\UART_inst|uart_tx_data_block[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector1~0_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|uart_tx_data_block[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_data_block\(5));

-- Location: LCCOMB_X1_Y36_N12
\UART_inst|Selector2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector2~0_combout\ = (\UART_inst|uart_tx_state.transmit_data~q\ & ((\UART_inst|uart_tx_data_block\(5)))) # (!\UART_inst|uart_tx_state.transmit_data~q\ & (uart_data_in(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.transmit_data~q\,
	datac => uart_data_in(4),
	datad => \UART_inst|uart_tx_data_block\(5),
	combout => \UART_inst|Selector2~0_combout\);

-- Location: FF_X1_Y36_N13
\UART_inst|uart_tx_data_block[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector2~0_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|uart_tx_data_block[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_data_block\(4));

-- Location: LCCOMB_X2_Y35_N4
\uart_data_in[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \uart_data_in[3]~feeder_combout\ = send_char(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => send_char(3),
	combout => \uart_data_in[3]~feeder_combout\);

-- Location: FF_X2_Y35_N5
\uart_data_in[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \uart_data_in[3]~feeder_combout\,
	clrn => \resetn~input_o\,
	ena => \P_TRANS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => uart_data_in(3));

-- Location: LCCOMB_X1_Y36_N22
\UART_inst|Selector3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector3~0_combout\ = (\UART_inst|uart_tx_state.transmit_data~q\ & (\UART_inst|uart_tx_data_block\(4))) # (!\UART_inst|uart_tx_state.transmit_data~q\ & ((uart_data_in(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_data_block\(4),
	datac => \UART_inst|uart_tx_state.transmit_data~q\,
	datad => uart_data_in(3),
	combout => \UART_inst|Selector3~0_combout\);

-- Location: FF_X1_Y36_N23
\UART_inst|uart_tx_data_block[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector3~0_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|uart_tx_data_block[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_data_block\(3));

-- Location: LCCOMB_X2_Y35_N26
\uart_data_in[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \uart_data_in[2]~feeder_combout\ = send_char(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => send_char(2),
	combout => \uart_data_in[2]~feeder_combout\);

-- Location: FF_X2_Y35_N27
\uart_data_in[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \uart_data_in[2]~feeder_combout\,
	clrn => \resetn~input_o\,
	ena => \P_TRANS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => uart_data_in(2));

-- Location: LCCOMB_X1_Y36_N0
\UART_inst|Selector4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector4~0_combout\ = (\UART_inst|uart_tx_state.transmit_data~q\ & (\UART_inst|uart_tx_data_block\(3))) # (!\UART_inst|uart_tx_state.transmit_data~q\ & ((uart_data_in(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.transmit_data~q\,
	datac => \UART_inst|uart_tx_data_block\(3),
	datad => uart_data_in(2),
	combout => \UART_inst|Selector4~0_combout\);

-- Location: FF_X1_Y36_N1
\UART_inst|uart_tx_data_block[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector4~0_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|uart_tx_data_block[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_data_block\(2));

-- Location: FF_X1_Y35_N23
\uart_data_in[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	asdata => send_char(1),
	clrn => \resetn~input_o\,
	sload => VCC,
	ena => \P_TRANS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => uart_data_in(1));

-- Location: LCCOMB_X1_Y36_N20
\UART_inst|Selector5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector5~0_combout\ = (\UART_inst|uart_tx_state.transmit_data~q\ & (\UART_inst|uart_tx_data_block\(2))) # (!\UART_inst|uart_tx_state.transmit_data~q\ & ((uart_data_in(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \UART_inst|uart_tx_data_block\(2),
	datac => \UART_inst|uart_tx_state.transmit_data~q\,
	datad => uart_data_in(1),
	combout => \UART_inst|Selector5~0_combout\);

-- Location: FF_X1_Y36_N21
\UART_inst|uart_tx_data_block[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector5~0_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|uart_tx_data_block[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_data_block\(1));

-- Location: LCCOMB_X2_Y35_N0
\uart_data_in[0]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \uart_data_in[0]~feeder_combout\ = send_char(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => send_char(0),
	combout => \uart_data_in[0]~feeder_combout\);

-- Location: FF_X2_Y35_N1
\uart_data_in[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \uart_data_in[0]~feeder_combout\,
	clrn => \resetn~input_o\,
	ena => \P_TRANS~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => uart_data_in(0));

-- Location: LCCOMB_X1_Y36_N26
\UART_inst|Selector6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector6~0_combout\ = (\UART_inst|uart_tx_state.transmit_data~q\ & (\UART_inst|uart_tx_data_block\(1))) # (!\UART_inst|uart_tx_state.transmit_data~q\ & ((uart_data_in(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_state.transmit_data~q\,
	datab => \UART_inst|uart_tx_data_block\(1),
	datac => uart_data_in(0),
	combout => \UART_inst|Selector6~0_combout\);

-- Location: FF_X1_Y36_N27
\UART_inst|uart_tx_data_block[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector6~0_combout\,
	clrn => \resetn~input_o\,
	ena => \UART_inst|uart_tx_data_block[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_data_block\(0));

-- Location: LCCOMB_X2_Y36_N24
\UART_inst|Selector12~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector12~1_combout\ = (\UART_inst|uart_tx_state.transmit_data~q\ & ((\UART_inst|uart_tx_data_block\(0)) # ((!\UART_inst|baud_tick~1_combout\)))) # (!\UART_inst|uart_tx_state.transmit_data~q\ & (((!\UART_inst|baud_tick~1_combout\ & 
-- \UART_inst|uart_tx_state.send_start_bit~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111110001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|uart_tx_data_block\(0),
	datab => \UART_inst|uart_tx_state.transmit_data~q\,
	datac => \UART_inst|baud_tick~1_combout\,
	datad => \UART_inst|uart_tx_state.send_start_bit~q\,
	combout => \UART_inst|Selector12~1_combout\);

-- Location: LCCOMB_X2_Y36_N12
\UART_inst|Selector12~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \UART_inst|Selector12~2_combout\ = (\UART_inst|uart_tx_data~q\ & (((!\UART_inst|Selector12~0_combout\ & !\UART_inst|Selector12~1_combout\)) # (!\UART_inst|baud_tick~1_combout\))) # (!\UART_inst|uart_tx_data~q\ & (\UART_inst|Selector12~0_combout\ & 
-- ((!\UART_inst|Selector12~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000001111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \UART_inst|Selector12~0_combout\,
	datab => \UART_inst|baud_tick~1_combout\,
	datac => \UART_inst|uart_tx_data~q\,
	datad => \UART_inst|Selector12~1_combout\,
	combout => \UART_inst|Selector12~2_combout\);

-- Location: FF_X2_Y36_N13
\UART_inst|uart_tx_data\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_50m~inputclkctrl_outclk\,
	d => \UART_inst|Selector12~2_combout\,
	clrn => \resetn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \UART_inst|uart_tx_data~q\);

-- Location: IOIBUF_X7_Y43_N8
\rx~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rx,
	o => \rx~input_o\);

ww_tx <= \tx~output_o\;

ww_rcv_data(0) <= \rcv_data[0]~output_o\;

ww_rcv_data(1) <= \rcv_data[1]~output_o\;

ww_rcv_data(2) <= \rcv_data[2]~output_o\;

ww_rcv_data(3) <= \rcv_data[3]~output_o\;

ww_rcv_data(4) <= \rcv_data[4]~output_o\;

ww_rcv_data(5) <= \rcv_data[5]~output_o\;

ww_rcv_data(6) <= \rcv_data[6]~output_o\;

ww_rcv_data(7) <= \rcv_data[7]~output_o\;
END structure;


