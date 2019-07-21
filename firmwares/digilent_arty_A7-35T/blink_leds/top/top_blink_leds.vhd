/* VHDL-2008 */
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

entity top_blink_leds is
    port (
        -- LEDs
        led0_b: out std_ulogic;
        led0_g: out std_ulogic;
        led0_r: out std_ulogic;
        led1_b: out std_ulogic;
        led1_g: out std_ulogic;
        led1_r: out std_ulogic;
        led2_b: out std_ulogic;
        led2_g: out std_ulogic;
        led2_r: out std_ulogic;
        led3_b: out std_ulogic;
        led3_g: out std_ulogic;
        led3_r: out std_ulogic;
        led4: out std_ulogic;
        led5: out std_ulogic;
        led6: out std_ulogic;
        led7: out std_ulogic;
        -- Reset Button
        rstb: in std_ulogic; -- '1': released
        -- Oscillator
        gclk100: in std_ulogic
    );
end entity;

architecture a_top_blink_leds of top_blink_leds is
    signal counter: std_ulogic_vector(32-1 downto 0) := (others=>'0');
begin
    counter <= counter + 1 when rising_edge(gclk100) and (rstb = '1');

    (led0_b, led0_g, led0_r, led1_b, led1_g, led1_r, led2_b, led2_g, led2_r,
        led3_b, led3_g, led3_r, led4, led5, led6, led7) <=
        counter(counter'high downto counter'high-20+1);
end architecture;
