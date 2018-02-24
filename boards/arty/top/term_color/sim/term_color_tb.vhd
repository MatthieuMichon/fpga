library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity term_color_tb is
    generic(
        TB_DURATION_US: positive
    );
end entity;

architecture term_color_a of term_color_tb is
    constant PERIOD: time := 10 ns;
    signal tb_run: boolean := true;
    signal gclk100: std_ulogic := '0';
    signal btn0: std_ulogic;
begin
    tb_run_p: process is begin
        tb_run <= false after TB_DURATION_US * 1 us;
        wait;
    end process;

    clk_p: process is begin
        while tb_run loop
            gclk100 <= not gclk100;
            wait for PERIOD/2;
        end loop;
        wait;
    end process;
    
    btn0 <= '0', '1' after 3 us, '0' after 21 us, '1' after 24 us;

    term_color_i: entity work.term_color
        generic map (
            SIMULATION => true
        ) port map (
            -- UART (DCE side)
            uart_rxd_out => open,
            -- Buttons
            btn0 => btn0,
            -- Switches
            sw0 => '0',
            sw1 => '0',
            sw2 => '0',
            sw3 => '0',
            -- LEDs
            led4 => open,
            -- Reset Button
            rst => '1',
            -- Oscillator
            gclk100 => gclk100
        );
end architecture;
