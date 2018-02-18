library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
    port (
        clk: in std_ulogic;
        clken: in std_ulogic := '1';
        -- 
        din: in std_ulogic;
        dout: out std_ulogic
    );
end entity;

architecture debouncer_a of debouncer is
    constant SR_LENGTH: positive := 16;
    subtype sreg_t is std_ulogic_vector(SR_LENGTH-1 downto 0);
    signal sreg_in: std_ulogic;
    signal sreg: sreg_t := (others=>'0');
    signal load_sr: std_ulogic;
begin
    load_sr <= din xor sreg(sreg'high);
    sreg_in <= din when (load_sr = '1') else sreg(sreg'high);
    sreg_p: process(clk) is begin
        if rising_edge(clk) then
            if (load_sr = '1') and (clken = '1') then
                sreg <= sreg(sreg'high-1 downto sreg'low) & sreg_in;
            end if;
        end if;
    end process;
    dout <= sreg(sreg'high);
end architecture;
