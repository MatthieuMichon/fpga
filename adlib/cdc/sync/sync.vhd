library ieee;
use ieee.std_logic_1164.all;

entity sync is
    generic (
        STAGES: positive
    );
    port (
        c: in std_ulogic;
        ce: in std_ulogic := '1';
        d: in std_ulogic;
        q: out std_ulogic
    );
end entity;

architecture sync_a of sync is
    subtype regs_t is std_ulogic_vector(STAGES-1 downto 0);
    signal regs: regs_t;
    attribute ASYNC_REG: string;
    attribute ASYNC_REG of regs: signal is "true";
begin
    regs <= regs(regs'high-1 downto 0) & d when rising_edge(c) and (ce = '1');
    q <= regs(regs'high);
end architecture;
