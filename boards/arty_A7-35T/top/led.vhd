library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;

entity led is
    port (
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

architecture led_a of led is
begin
    clocking_b: block is
        signal reset: std_ulogic;
        signal mmcm0_fb: std_ulogic;
        signal mmcm_xxx_clk: std_ulogic;
    begin
        reset <= not rst;

        mmcme2_base_i_0: mmcme2_base
            generic map (
                CLKIN1_PERIOD => 10.0,
                CLKFBOUT_MULT_F => 12.0,
                CLKOUT1_DIVIDE => 6
            )
            port map (
                clkin1 => gclk100,
                clkfbin => mmcm0_fb,
                clkfbout => mmcm0_fb,
                clkout1 => mmcm_xxx_clk,
                locked => led4,
                rst => reset,
                pwrdwn => '0'
            );
    end block;
end architecture;
