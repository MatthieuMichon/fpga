library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;

entity button_uart_tx is
    port (
        -- UART (DCE side)
        uart_rxd_out: out std_ulogic;
        -- Buttons
        btn0: in std_ulogic;
        btn1: in std_ulogic;
        btn2: in std_ulogic;
        btn3: in std_ulogic;
        -- LEDs
        led4: out std_ulogic;
        led5: out std_ulogic;
        led6: out std_ulogic;
        -- Reset Button
        rst: in std_ulogic; -- '1': released
        -- Oscillator
        gclk100: in std_ulogic
    );
end entity;

architecture button_uart_tx_a of button_uart_tx is
    constant BUTTONS: positive := 4;
    subtype buttons_t is std_ulogic_vector(BUTTONS-1 downto 0);
    signal async_btns: buttons_t;
    signal clean_btns: buttons_t;
    signal clean_btns_r: buttons_t;
    signal clk200: std_ulogic;
    signal clken_115khz: std_ulogic;
begin
    clocking_b: block is
        constant CLKEN_115KHZ_CNT: positive := 1736;
        signal clken_cnt: natural range 0 to CLKEN_115KHZ_CNT := 0; 
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
    end block;

    wiring_b: block is begin
        async_btns <= btn3 & btn2 & btn1 & btn0;
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
                    ce => clken_115khz,
                    d => async_btns(i),
                    q => sync_btns(i)
                );

            debouncer_i_uart_in: entity work.debouncer
                port map (
                    clk => clk200,
                    clken => clken_115khz,
                    din => sync_btns(i),
                    dout => clean_btns(i)
                );
        end generate;

        clean_btns_r <= clean_btns when rising_edge(clk200) and (clken_115khz = '1');
    end block;

    uart_loopback_b: block is
        signal uart_txd_in_clean: std_ulogic;
        signal tx_valid: std_ulogic;
        signal tx_ready: std_ulogic;
    begin
        led5 <= clean_btns_r(0);
        led6 <= '1'; --tx_ready;

        capture_btn0_p: process(clk200) is begin
            if rising_edge(clk200) then
                if (clken_115khz = '1') then
                    if (clean_btns(0) = '1') and (clean_btns_r(0) = '0') then
                        tx_valid <= tx_ready;
                    else
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
                tx_char => X"41",
                tx_valid => tx_valid,
                -- Serial Interface
                tx_bit => uart_rxd_out
            );
    end block;
end architecture;
