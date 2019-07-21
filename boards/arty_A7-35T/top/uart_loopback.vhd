library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;

entity uart_loopback is
    port (
        -- UART (DCE side)
        uart_txd_in: in std_ulogic;
        uart_rxd_out: out std_ulogic;
        -- LEDs
        led4: out std_ulogic;
        led5: out std_ulogic;
        led6: out std_ulogic;
        led7: out std_ulogic;
        -- Reset Button
        rst: in std_ulogic; -- '1': released
        -- Oscillator
        gclk100: in std_ulogic
    );
end entity;

architecture uart_loopback_a of uart_loopback is
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

    uart_loopback_b: block is
        constant CLKEN_1851KHZ_CNT_CYCLES: positive := 107;
        signal clken_1851khz_cnt: natural range 0 to 128-1 := 0;
        signal clken_1851khz: std_ulogic;
        signal uart_txd_in_clean: std_ulogic;
    begin
        clken_1851khz_p: process(clk200) is begin
            if rising_edge(clk200) then
                if (clken_1851khz_cnt = CLKEN_1851KHZ_CNT_CYCLES) then
                    clken_1851khz_cnt <= 0;
                    clken_1851khz <= '1';
                else
                    clken_1851khz_cnt <= clken_1851khz_cnt + 1;
                    clken_1851khz <= '1';
                end if;
            end if;
        end process;

        sync_i_uart_in: entity work.sync
            generic map (
                STAGES => 2
            )
            port map (
                c => clk200,
                ce => clken_1851khz,
                -- 
                d => uart_txd_in,
                q => uart_txd_in_clean
            );

        debouncer_i_uart_in: entity work.debouncer
            port map (
                clk => clk200,
                clken => clken_1851khz,
                -- 
                din => uart_txd_in_clean,
                dout => uart_rxd_out
            );
    end block;
end architecture;
