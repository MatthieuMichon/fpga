library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity uart_tx_frame_buffer_tb is
end entity;

architecture uart_tx_frame_buffer_tb_a of uart_tx_frame_buffer_tb is
    constant PERIOD: time := 5 ns;
    constant CLK_EN_RATIO: positive := 1736;
    constant ADDR_WIDTH: positive := 4;
    constant CHAR_WIDTH: positive := 8;

    subtype byte_t is std_ulogic_vector(8-1 downto 0);

    signal tb_run: boolean := true;
    signal clk: std_ulogic;
    signal cycle_cnt: natural range 0 to CLK_EN_RATIO;
    signal tb_uut_byte: byte_t;
    signal tx_valid: std_ulogic;
    signal clk_en_115khz: std_ulogic;
    signal tx_ready: std_ulogic;
    signal tx_bit: std_ulogic;

    signal buf_addr: std_ulogic_vector(ADDR_WIDTH-1 downto 0);
    signal buf_data: std_ulogic_vector(CHAR_WIDTH downto 0);
    signal buf_wen: std_ulogic;
    signal fb_switch: std_ulogic;
begin
    tb_run_p: process is begin
        tb_run <= false after 20 us;
        wait;
    end process;

    clk_p: process is begin
        clk <= '0';
        wait for 100 fs;
        while tb_run loop
            clk <= not clk;
            wait for PERIOD/2;
        end loop;
        wait;
    end process;

    clk_en_p: process(clk) is begin
        if rising_edge(clk) then
            if (cycle_cnt = CLK_EN_RATIO) then
                cycle_cnt <= 0;
                clk_en_115khz <= '1';
            else
                cycle_cnt <= cycle_cnt + 1;
                clk_en_115khz <= '0';
            end if;
        end if;
    end process;

    tb_seq_p: process is begin
        -- wait for startup
        buf_addr <= (others=>'0');
        buf_data <= (others=>'0');
        buf_wen <= '0';
        fb_switch <= '0';

        for i in 0 to 3 loop wait until rising_edge(clk); end loop;

        -- clear RAM
        for i in 0 to 2**ADDR_WIDTH-1 loop
            buf_addr <= std_ulogic_vector(1 + unsigned(buf_addr));
            buf_data <= (others=>'0');
            buf_data(buf_data'high) <= '1';
            buf_wen <= '1';
            wait until rising_edge(clk);
        end loop;

        buf_addr <= (others=>'0');
        buf_data <= (others=>'0');
        buf_wen <= '0';
        for i in 0 to 3 loop wait until rising_edge(clk); end loop;
        fb_switch <= '1';

        wait until rising_edge(clk);
        fb_switch <= '0';
        wait;
    end process;

    uart_tx_frame_buffer_i: entity work.uart_tx_frame_buffer
        generic map (
            ADDR_WIDTH => ADDR_WIDTH
        ) port map (
            -- Parallel Interface
            clk => clk,
            reset => '0',
            -- Parallel Interface
            uart_ready => '1',
            uart_char => open,
            uart_valid => open,
            -- Serial Interface
            fb_ready => open,
            fb_switch => fb_switch,
            --
            buf_addr => buf_addr,
            buf_data => buf_data,
            buf_wen => buf_wen
        );
end architecture;
