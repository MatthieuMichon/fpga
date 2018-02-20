library ieee;
use ieee.std_logic_1164.all;

entity uart_tx is
    generic (
        -- Do not override
        CHAR_WIDTH: positive := 8
    );
    port (
        clk: in std_ulogic;
        clken: in std_ulogic;
        -- Parallel Interface
        tx_ready: out std_ulogic;
        tx_char: in std_ulogic_vector(CHAR_WIDTH-1 downto 0);
        tx_valid: in std_ulogic;
        -- Serial Interface
        tx_bit: out std_ulogic
    );
end entity;

architecture uart_tx_a of uart_tx is
    subtype frame_t is std_ulogic_vector(CHAR_WIDTH+2-1 downto 0);
    signal ready_sr: frame_t := (others=>'0');
    signal frame: frame_t := (others=>'1');
begin
    ready_p: process(clk) is begin
        if rising_edge(clk) then
            if (clken = '1') then
                if (tx_valid = '1') then
                    ready_sr <= (others=>'0');
                else
                    ready_sr <= '1' & ready_sr(ready_sr'high downto ready_sr'low+1);
                end if;
            end if;
        end if;
    end process;

    tx_ready <= ready_sr(ready_sr'low);

    serializer_p: process(clk) is begin
        if rising_edge(clk) then
            if (clken = '1') then
                if (tx_valid = '1') then
                    frame <= '1' & tx_char & '0';
                else
                    frame <= '1' & frame(frame'high downto frame'low+1);
                end if;
            end if;
        end if;
    end process;

    tx_bit <= frame(frame'low);
end architecture;
