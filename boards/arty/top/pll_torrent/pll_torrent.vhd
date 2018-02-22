library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;

entity pll_torrent is
    port (
        -- RGB LEDs
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
        -- Reset Button
        rst: in std_ulogic; -- '1': released
        -- Oscillator
        gclk100: in std_ulogic
    );
end entity;

architecture pll_torrent_a of pll_torrent is
begin
    clocking_b: block is
        constant MMCM_INSTANCES: positive := 5; -- device limited
        type real_array_t is array (0 to MMCM_INSTANCES-1) of real;
        constant CLKIN_PERIOD_LIST: real_array_t := (10.0, 5.0, 5.0, 5.0, 5.0);

        signal clk_chain: std_ulogic_vector(MMCM_INSTANCES downto 0);
        signal locked_chain: std_ulogic_vector(MMCM_INSTANCES downto 0);
        signal reset: std_ulogic;
        signal mmcm0_fb: std_ulogic;
        signal mmcm_xxx_clk: std_ulogic;
    begin
        reset <= not rst;

        clk_chain(0) <= gclk100;
        locked_chain(0) <= rst;

        mmcm_chain_g: for i in 0 to MMCM_INSTANCES-1 generate
            signal clk_chain_bufg: std_ulogic;
            signal mmcm_fb: std_ulogic;
            signal mmcm_reset: std_ulogic;
        begin
            --assert false report "";

            mmcm_reset <= not locked_chain(i);

            -- IMPORTANT: bufg primitives must be instantiated between MMCMs to
            -- avoid the following error during placement:
            --
            -- ERROR: [Place 30-157] Sub-optimal placement for an MMCM-MMCM
            -- cascade pair. If this sub optimal condition is acceptable for
            -- this design, you may use the CLOCK_DEDICATED_ROUTE constraint
            -- in the .xdc file to demote this message to a WARNING. However,
            -- the use of this override is highly discouraged. These examples
            -- can be used directly in the .xdc file to override this clock
            -- rule.

            bufg_i: bufg
                port map (
                    i => clk_chain(i),
                    o => clk_chain_bufg
                );

            mmcme2_base_i: mmcme2_base
                generic map (
                    CLKIN1_PERIOD => CLKIN_PERIOD_LIST(i),
                    CLKFBOUT_MULT_F => CLKIN_PERIOD_LIST(i) * 1.2,
                    CLKOUT1_DIVIDE => 6
                )
                port map (
                    clkin1 => clk_chain_bufg,
                    clkfbin => mmcm_fb,
                    clkfbout => mmcm_fb,
                    clkout1 => clk_chain(i+1),
                    locked => locked_chain(i+1),
                    rst => mmcm_reset,
                    pwrdwn => '0'
                );
        end generate;

        led0_b <= locked_chain(1);
        led0_g <= locked_chain(2);
        led0_r <= locked_chain(3);
        led1_b <= locked_chain(4);
        led1_g <= locked_chain(5);
    end block;
end architecture;
