library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library std;
--use std.textio.all;
library adlib;

entity uart_tx_frame_buffer is
    generic (
        ADDR_WIDTH: positive;
        -- Do not override
        CHAR_WIDTH: positive := 8
    );
    port (
        clk: in std_ulogic;
        reset: in std_ulogic;
        -- Outbound UART Channel
        uart_ready: in std_ulogic;
        uart_char: out std_ulogic_vector(CHAR_WIDTH-1 downto 0);
        uart_valid: out std_ulogic;
        -- Control
        fb_ready: out std_ulogic;
        fb_switch: in std_ulogic; -- ends on first buf_char with MSB bit set
        -- Frame Buffer Control
        buf_addr: in std_ulogic_vector(ADDR_WIDTH-1 downto 0);
        buf_data: in std_ulogic_vector(CHAR_WIDTH downto 0);
        buf_wen: in std_ulogic
    );
end entity;

architecture uart_tx_frame_buffer_a of uart_tx_frame_buffer is
    subtype addr_t is std_ulogic_vector(ADDR_WIDTH-1 downto 0);
    subtype char_t is std_ulogic_vector(CHAR_WIDTH-1 downto 0);
    subtype data_t is std_ulogic_vector(CHAR_WIDTH downto 0);

    signal fb_waddr: addr_t;
    signal fb_wdata: data_t;
    signal fb0_wen: std_ulogic;
    signal fb1_wen: std_ulogic;

    signal fb_raddr: addr_t;
    signal fb0_rdata: data_t;
    signal fb1_rdata: data_t;
    signal fb0_ren: std_ulogic;
    signal fb1_ren: std_ulogic;

    signal fb_sel: std_ulogic := '0';
begin
    fb_write_b: block is begin
        fb_waddr <= buf_addr when rising_edge(clk);
        fb_wdata <= buf_data when rising_edge(clk);
        fb0_wen <= (buf_wen and fb_sel)  when rising_edge(clk);
        fb1_wen <= (buf_wen and not fb_sel)  when rising_edge(clk);
    end block;

    dual_frame_buffer_b: block is begin
        dpram_i_fb0: entity adlib.dpram
            generic map (
                ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => CHAR_WIDTH + 1
            ) port map (
                clk => clk,
                -- Port A: frame buffer write
                addra => fb_waddr,
                dina => fb_wdata,
                wea => fb0_wen,
                ena => '0',
                rsta => '0',
                regcea => '1',
                douta => open,

                addrb => fb_raddr,
                dinb => (others=>'0'),
                web => '0',
                enb => fb0_ren,
                rstb => '0',
                regceb => '1',
                doutb => fb0_rdata
            );

        dpram_i_fb1: entity adlib.dpram
            generic map (
                ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => CHAR_WIDTH + 1
            ) port map (
                clk => clk,
                -- Port A: frame buffer write
                addra => fb_waddr,
                dina => fb_wdata,
                wea => fb1_wen,
                ena => '0',
                rsta => '0',
                regcea => '1',
                douta => open,

                addrb => fb_raddr,
                dinb => (others=>'0'),
                web => '0',
                enb => fb1_ren,
                rstb => '0',
                regceb => '1',
                doutb => fb1_rdata
            );
    end block;

    fb_ready_p: process(clk) is begin
        if rising_edge(clk) then
            if (fb_raddr = (fb_raddr'range=>'0'))
                    and (uart_ready = '1') and (fb_switch = '0') then
                fb_ready <= '1';
            else
                fb_ready <= '0';
            end if;
        end if;
    end process;

    fb_raddr_p: process(clk) is begin
        if rising_edge(clk) then
            if (uart_ready = '1') then
                if ((fb0_ren = '0') and (fb1_ren = '0')) then
                    -- idle
                    uart_valid <= '0';
                    if (fb_switch = '1') then
                        if (fb_sel = '0') then
                            fb0_ren <= '1';
                        else
                            fb1_ren <= '1';
                        end if;
                    end if;
                else
                    -- Read Pending
                    if (fb0_rdata(fb0_rdata'high) = '0') then
                        fb_raddr <= std_ulogic_vector(1 + unsigned(fb_raddr));
                        if (fb_sel = '0') then
                            uart_char <= fb0_rdata(uart_char'range);
                        else
                            uart_char <= fb1_rdata(uart_char'range);
                        end if;
                        uart_valid <= '1';
                    else
                        -- Reached end of frame
                        fb_raddr <= (others=>'0');
                        fb0_ren <= '0';
                        fb1_ren <= '0';
                        fb_sel <= not fb_sel;
                        uart_char <= std_ulogic_vector(
                            to_unsigned(character'pos(NUL), uart_char'length));
                        uart_valid <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;
end architecture;
