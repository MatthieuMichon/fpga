-- transmit a string via UART on button press

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;

entity term_color is
    generic (
        SIMULATION: boolean := false
    );
    port (
        -- UART (DCE side)
        uart_rxd_out: out std_ulogic;
        -- Buttons
        btn0: in std_ulogic;
        -- Switches
        sw0: in std_ulogic;
        sw1: in std_ulogic;
        sw2: in std_ulogic;
        sw3: in std_ulogic;
        -- LEDs
        led4: out std_ulogic;
        -- Reset Button
        rst: in std_ulogic; -- '1': released
        -- Oscillator
        gclk100: in std_ulogic
    );
end entity;
 
architecture term_color_a of term_color is
    function simulation_speed_up return natural is begin
        if SIMULATION then
            return 100;
        end if;
        return 1;
    end function;

    constant BUTTONS: positive := 1;
    subtype buttons_t is std_ulogic_vector(BUTTONS-1 downto 0);
    signal async_btns: buttons_t;
    signal clean_btns: buttons_t;

    constant SWITCHES: positive := 4;
    subtype switches_t is std_ulogic_vector(SWITCHES-1 downto 0);
    signal async_sws: switches_t;
    signal clean_sws: switches_t;

    signal clk200: std_ulogic;
begin
    clocking_b: block is
        signal reset: std_ulogic;
        signal mmcm0_fb: std_ulogic;
    begin
        reset <= not rst;

        mmcme2_base_i: mmcme2_base
            generic map (
                CLKIN1_PERIOD => 10.0,
                CLKFBOUT_MULT_F => 12.0,
                CLKOUT1_DIVIDE => 6
            )
            port map (
                clkin1 => gclk100,
                clkfbin => mmcm0_fb,
                clkfbout => mmcm0_fb,
                clkout1 => clk200,
                locked => led4,
                rst => reset,
                pwrdwn => '0'
            );
    end block;

    --assert (simulation_speed_up = 1) severity failure;

    wiring_b: block is begin
        async_btns(0) <= btn0;
        async_sws(0) <= sw0;
        async_sws(1) <= sw1;
        async_sws(2) <= sw2;
        async_sws(3) <= sw3;
    end block;
 
    buttons_b: block is
        signal sync_btns: buttons_t;
    begin
        per_btn_g: for i in buttons_t'range generate
            sync_i_btn: entity work.sync
                generic map (
                    STAGES => 2
                )
                port map (
                    c => clk200,
                    ce => '1',
                    d => async_btns(i),
                    q => sync_btns(i)
                );

            debouncer_i_uart_in: entity work.debouncer
                port map (
                    clk => clk200,
                    din => sync_btns(i),
                    dout => clean_btns(i)
                );   
        end generate;

        -- switches do not trigger anything, thus no debounce
        per_sw_g: for i in switches_t'range generate
            sync_i_sw: entity work.sync
                generic map (
                    STAGES => 2
                )
                port map (
                    c => clk200,
                    ce => '1',
                    d => async_sws(i),
                    q => clean_sws(i)
                );
        end generate;
    end block;

    uart_loopback_b: block is
        constant CLKEN_115KHZ_CNT: positive := 1736 / simulation_speed_up;
        signal clken_cnt: natural range 0 to CLKEN_115KHZ_CNT := 0; 
        signal clken_115khz: std_ulogic;

        signal clean_btns_r: buttons_t;
        signal pressed_btn: buttons_t := (others=>'0');

        --constant CR: character := character'val(16#0A#);
        --constant LF: character := character'val(16#0A#);
        --constant ESC: character := character'val(16#1B#);
        constant DUMMY_STR: string := "sw- position: " & (ESC & "[44m") & "---" & (ESC & "[49m") & CR & LF & NUL;
        constant STR_LEN: positive := DUMMY_STR'length;
        signal str_ptr: natural range 0 to STR_LEN := 0;
        signal tx_char: std_ulogic_vector(8-1 downto 0) := (others=>'0');
        signal tx_valid: std_ulogic;
        signal tx_ready: std_ulogic;

        function get_switch_position(index: natural; position: std_ulogic) return string is  
            variable position_str: string(1 to 3) := "---";
        begin
            if (position = '0') then
                position_str := "bot";
            else
                position_str := "top";
            end if;
            return "sw" & natural'image(index) & " position: " & (ESC & "[44m") & position_str & (ESC & "[49m") & CR & LF & NUL;
        end function;
    begin
        clken_cnt_p: process(clk200) is begin
            if rising_edge(clk200) then
                if (clken_cnt = CLKEN_115KHZ_CNT) then
                    clken_cnt <= 0;
                    clken_115khz <= '1';
                else
                    clken_cnt <= clken_cnt + 1;
                    clken_115khz <= '0';
                end if;
            end if;
        end process;

        button_g: for i in clean_btns'range generate
            capture_btn0_p: process(clk200) is begin
                if rising_edge(clk200) then
                    if (clken_115khz = '1') then
                        if (clean_btns(i) = '1') and (clean_btns_r(i) = '0') then
                            pressed_btn(i) <= '1';
                        else
                            pressed_btn(i) <= '0';
                        end if;
                        clean_btns_r(i) <= clean_btns(i);
                    end if;
                end if;
            end process;
        end generate;

        string_tx_p: process(clk200) is
            variable str: string(DUMMY_STR'range);
        begin
            if rising_edge(clk200) then
                if (clken_115khz = '1') then
                    str := get_switch_position(0, clean_sws(0));
                    tx_char <= std_ulogic_vector(to_unsigned(character'pos(str(str_ptr+1)), tx_char'length));
                    if (tx_ready = '1') and (tx_valid = '0') then
                        if (str_ptr = 0) then
                            if (pressed_btn(0) = '1') then
                                str_ptr <= 1 + str_ptr;
                                tx_valid <= '1';
                            else
                                tx_valid <= '0';
                            end if;
                        elsif (str_ptr+1 < str'high) then
                            str_ptr <= 1 + str_ptr;
                            tx_valid <= '1';
                        else
                            -- idle
                            str_ptr <= 0;
                            tx_valid <= '0';
                        end if;
                    else
                        -- transmit in progress or issued a command in last cycle
                        tx_valid <= '0';
                    end if;
                end if;
            end if;
        end process;

        uart_tx_i: entity work.uart_tx
            port map (
                -- Parallel Interface
                clk => clk200,
                clken => clken_115khz,
                -- Parallel Interface
                tx_ready => tx_ready,
                tx_char => tx_char,
                tx_valid => tx_valid,
                -- Serial Interface
                tx_bit => uart_rxd_out
            );
    end block;
end architecture;
