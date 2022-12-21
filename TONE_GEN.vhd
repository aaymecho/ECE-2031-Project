-- Simple DDS tone generator.
-- 5-bit tuning word
-- 9-bit phase register
-- 256 x 8-bit ROM.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY ALTERA_MF;
USE ALTERA_MF.ALTERA_MF_COMPONENTS.ALL;


ENTITY TONE_GEN IS 
	PORT
	(
		CMD        : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		CS         : IN  STD_LOGIC;
		SAMPLE_CLK : IN  STD_LOGIC;
		RESETN     : IN  STD_LOGIC;
		L_DATA     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		R_DATA     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END TONE_GEN;

ARCHITECTURE gen OF TONE_GEN IS 

	SIGNAL phase_register : STD_LOGIC_VECTOR(14 DOWNTO 0);
	SIGNAL tuning_word    : STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL sounddata      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL note           : STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL next_addr      : STD_LOGIC_VECTOR(14 DOWNTO 0);
	SIGNAL rom_out        : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL rom_in         : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL volume         : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	TYPE STATE_TYPE IS (pos_Wave, pos_back, neg_wave, neg_back);
	SIGNAL STATE : STATE_TYPE;
	
BEGIN

	-- ROM to hold the waveform
	SOUND_LUT : altsyncram
	GENERIC MAP (
		lpm_type => "altsyncram",
		width_a => 8,
		widthad_a => 6,
		numwords_a => 64,
		init_file => "SOUND_SINE.mif",
		intended_device_family => "Cyclone II",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		operation_mode => "ROM",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		power_up_uninitialized => "FALSE"
	)
	PORT MAP (
		clock0 => NOT(SAMPLE_CLK),
		-- In this design, one bit of the phase register is a fractional bit
		address_a => rom_in,
		q_a => rom_out -- output is amplitude
	);
	
	WITH STATE SELECT rom_in <=
		"111111" - phase_register(14 downto 9) when pos_back, 
		"111111" - phase_register(14 downto 9) when neg_back,
		phase_register(14 downto 9) when OTHERS;
	
	wITH STATE SELECT sounddata <=
		not(rom_out) + "000001" when neg_wave,
		not(rom_out) + "000001" when neg_back,
		rom_out when OTHERS;
	
	-- 8-bit sound data is used as bits 12-5 of the 16-bit output.
	-- This is to prevent the output from being too loud.
		L_DATA <= (sounddata&"00000000") when volume = "00" else
			sounddata(7)&sounddata&"0000000" when volume = "01" else
			sounddata(7)&sounddata(7)&sounddata&"000000" when volume = "10" else
			"0000000000000000";
				
		R_DATA <= sounddata&"00000000" when volume = "00" else
			sounddata(7)&sounddata&"0000000" when volume = "01" else
			sounddata(7)&sounddata(7)&sounddata&"000000" when volume = "10" else
			"0000000000000000";
	
	-- process to perform DDS
	PROCESS(RESETN, SAMPLE_CLK) BEGIN
		IF RESETN = '0' THEN
			phase_register <= "000000000000000";
			state <= pos_wave;
		ELSIF RISING_EDGE(SAMPLE_CLK) THEN
			IF tuning_word = "00000" THEN  -- if command is 0, return to 0 output.
				phase_register <= "000000000000000";
				state <= pos_wave;
			ELSE
				-- Increment the phase register by the tuning word.
				phase_register <= phase_register + ("0" & tuning_word);
			END IF;
			next_addr <= phase_register + ("0" & tuning_word);
			IF phase_register(14 DOWNTO 7) < "01000000" THEN
				STATE <= pos_wave;
			ELSIF phase_register(14 DOWNTO 7) < "10000000" THEN
				STATE <= pos_back;
			ELSIF phase_register(14 DOWNTO 7) < "11000000" THEN
				STATE <= neg_wave;
			ELSE
				STATE <= neg_back;
			END IF;
		END IF;
	END PROCESS;

	-- process to latch command data from SCOMP
	PROCESS(RESETN, CS) BEGIN
		IF RESETN = '0' THEN
			tuning_word <= "00000000000000";
		ELSIF RISING_EDGE(CS) THEN
			volume <= CMD(8 downto 7);
			IF CMD(3 downto 0) = "0000" THEN
				note <= "00000001000111";
			ELSIF CMD(3 downto 0) = "0001" THEN
				note <= "00000001001011";
			ELSIF CMD(3 downto 0) = "0010" THEN
				note <= "00000001010000";
			ELSIF CMD(3 downto 0) = "0011" THEN
				note <= "00000001010100";
			ELSIF CMD(3 downto 0) = "0100" THEN
				note <= "00000001011001";
			ELSIF CMD(3 downto 0) = "0101" THEN
				note <= "00000001011111";	
			ELSIF CMD(3 downto 0) = "0110" THEN
				note <= "00000001100100";
			ELSIF CMD(3 downto 0) = "0111" THEN
				note <= "00000001101010";	
			ELSIF CMD(3 downto 0) = "1000" THEN
				note <= "00000001110001";
			ELSIF CMD(3 downto 0) = "1001" THEN
				note <= "00000001110111";
			ELSIF CMD(3 downto 0) = "1010" THEN
				note <= "00000001111110";
			ELSIF CMD(3 downto 0) = "1011" THEN
				note <= "00000010000110";	
			ELSE
				note <= "00000000000000";
			END IF;
			IF CMD(6 downto 4) = "001" THEN
				tuning_word <= note(12 downto 0) & "0";
			ELSIF CMD(6 downto 4) = "010" THEN
				tuning_word <= note(11 downto 0) & "00";
			ELSIF CMD(6 downto 4) = "011" THEN
				tuning_word <= note(10 downto 0) & "000";
			ELSIF CMD(6 downto 4) = "100" THEN
				tuning_word <= note(9 downto 0) & "0000";
			ELSIF CMD(6 downto 4) = "101" THEN
				tuning_word <= note(8 downto 0) & "00000";
			ELSIF CMD(6 downto 4) = "110" THEN
				tuning_word <= note(7 downto 0) & "000000";
			ELSE
				tuning_word <= note;
			END IF;
		END IF;
	END PROCESS;
END gen;