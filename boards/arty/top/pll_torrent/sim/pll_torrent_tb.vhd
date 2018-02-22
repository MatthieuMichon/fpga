library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pll_torrent_tb is
    generic(
        TB_DURATION_US: positive
    );
end entity;

architecture pll_torrent_a of pll_torrent_tb is
    constant PERIOD: time := 10 ns;
    signal tb_run: boolean := true;
    signal gclk100: std_ulogic := '0';
    signal rst: std_ulogic;
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
    
    rst <= '1', '0' after 10 us, '1' after 11 us;

    pll_torrent_i: entity work.pll_torrent
        port map (
            -- Reset Button
            rst => rst,
            -- Oscillator
            gclk100 => gclk100
        );
end architecture;
