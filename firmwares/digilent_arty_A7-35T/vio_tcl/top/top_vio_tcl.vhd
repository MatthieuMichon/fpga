/* VHDL-2008 */
library ieee;
use ieee.numeric_std_unsigned.all;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;

entity top_vio_tcl is
    port (
        -- MII
        eth_col: in std_ulogic;
        eth_crs: in std_ulogic;
        eth_mdc: out std_ulogic;
        eth_mdio: inout std_ulogic;
        eth_ref_clk: out std_ulogic;
        eth_rstn: out std_ulogic;
        eth_rx_clk: in std_ulogic;
        eth_rx_dv: in std_ulogic;
        eth_rxd: in std_ulogic_vector(4-1 downto 0);
        eth_rxerr: in std_ulogic;
        eth_tx_clk: in std_ulogic;
        eth_tx_en: out std_ulogic;
        eth_txd: out std_ulogic_vector(4-1 downto 0);
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
        -- switches
        sw0: in std_ulogic;
        sw1: in std_ulogic;
        sw2: in std_ulogic;
        sw3: in std_ulogic;
        -- push buttons
        btn0: in std_ulogic;
        btn1: in std_ulogic;
        btn2: in std_ulogic;
        btn3: in std_ulogic;
        -- Reset Button
        rstb: in std_ulogic; -- '1': released
        -- Oscillator
        gclk100: in std_ulogic
    );
end entity;

architecture a_top_vio_tcl of top_vio_tcl is
    signal sw: std_logic_vector(4-1 downto 0);
    signal btn: std_logic_vector(4-1 downto 0);
    signal led0: std_logic_vector(3-1 downto 0);
    signal led1: std_logic_vector(3-1 downto 0);
    signal led2: std_logic_vector(3-1 downto 0);
    signal led3: std_logic_vector(3-1 downto 0);
    signal rstb_slv: std_logic_vector(0 downto 0);
    signal led4_slv: std_logic_vector(0 downto 0);
    signal led5_slv: std_logic_vector(0 downto 0);
    signal led6_slv: std_logic_vector(0 downto 0);
    signal led7_slv: std_logic_vector(0 downto 0);
    signal mii_vio: std_ulogic_vector(3-1 downto 0);

    signal eth_rx_clk_bufg: std_ulogic;
    signal eth_tx_clk_bufg: std_ulogic;
    signal mmcm0_fb: std_ulogic;
    signal mmcm1_fb: std_ulogic;
    signal mmcm2_fb: std_ulogic;
    signal mmcm_rst: std_ulogic;
    signal mmcm0_locked: std_ulogic;
    signal mmcm1_locked: std_ulogic;
    signal mmcm2_locked: std_ulogic;
    signal mmcm1_clk25: std_ulogic;
    signal mmcm2_clk25: std_ulogic;

begin
    sw <= (sw3, sw2, sw1, sw0);
    btn <= (btn3, btn2, btn1, btn0);
    mii_vio <= (mmcm0_locked, mmcm1_locked, mmcm2_locked);
    led0 <= (led0_r, led0_g, led0_b);
    led1 <= (led1_r, led1_g, led1_b);
    led2 <= (led2_r, led2_g, led2_b);
    led3 <= (led3_r, led3_g, led3_b);
    rstb_slv(0) <= rstb;
    led4 <= led4_slv(0);
    led5 <= led5_slv(0);
    led6 <= led6_slv(0);
    led7 <= led7_slv(0);
    i_vio_arty: vio_arty port map (
        clk => gclk100,
        probe_in0 => rstb_slv,
        probe_in1 => sw,
        probe_in2 => btn,
        probe_in3 => mii_vio,
        probe_out0 => led0,
        probe_out1 => led1,
        probe_out2 => led2,
        probe_out3 => led3,
        probe_out4 => led4_slv,
        probe_out5 => led5_slv,
        probe_out6 => led6_slv,
        probe_out7 => led7_slv
    );

    mmcm_rst <= not rstb;

    mmcme2_base_mii_ref_clk: mmcme2_base
        generic map (
            CLKIN1_PERIOD => 10.0,
            CLKFBOUT_MULT_F => 10.0, -- 2..64
            CLKOUT1_DIVIDE => 40 -- 1..128
        )
        port map (
            clkin1 => gclk100,
            clkfbin => mmcm0_fb,
            clkfbout => mmcm0_fb,
            clkout1 => eth_ref_clk,
            locked => mmcm0_locked,
            rst => mmcm_rst,
            pwrdwn => '0'
        );

    bufg_rx_clk: bufg
        port map (
            i => eth_rx_clk,
            o => eth_rx_clk_bufg
        );

    mmcme2_base_mii_rx_clk: mmcme2_base
        generic map (
            CLKIN1_PERIOD => 40.0,
            CLKFBOUT_MULT_F => 32.0,
            CLKOUT1_DIVIDE => 32
        )
        port map (
            clkin1 => eth_rx_clk_bufg,
            clkfbin => mmcm1_fb,
            clkfbout => mmcm1_fb,
            clkout1 => mmcm1_clk25,
            locked => mmcm1_locked,
            rst => mmcm_rst,
            pwrdwn => '0'
        );

    bufg_tx_clk: bufg
        port map (
            i => eth_tx_clk,
            o => eth_tx_clk_bufg
        );

    mmcme2_base_mii_tx_clk: mmcme2_base
        generic map (
            CLKIN1_PERIOD => 40.0,
            CLKFBOUT_MULT_F => 32.0,
            CLKOUT1_DIVIDE => 32
        )
        port map (
            clkin1 => eth_tx_clk_bufg,
            clkfbin => mmcm2_fb,
            clkfbout => mmcm2_fb,
            clkout1 => mmcm2_clk25,
            locked => mmcm2_locked,
            rst => mmcm_rst,
            pwrdwn => '0'
        );
end architecture;
