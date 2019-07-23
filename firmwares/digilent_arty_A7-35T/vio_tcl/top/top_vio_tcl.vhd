/* VHDL-2008 */
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std_unsigned.all;

entity top_vio_tcl is
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
--    COMPONENT vio_arty
--  PORT (
--    clk : IN STD_LOGIC;
--    probe_in0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    probe_in1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
--    probe_in2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
--    probe_out0 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
--    probe_out1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
--    probe_out2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
--    probe_out3 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
--    probe_out4 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
--    probe_out5 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
--    probe_out6 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
--    probe_out7 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
--  );
--END COMPONENT;
begin
    sw <= (sw3, sw2, sw1, sw0);
    btn <= (btn3, btn2, btn1, btn0);
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
        probe_out0 => led0,
        probe_out1 => led1,
        probe_out2 => led2,
        probe_out3 => led3,
        probe_out4 => led4_slv,
        probe_out5 => led5_slv,
        probe_out6 => led6_slv,
        probe_out7 => led7_slv
    );
end architecture;
