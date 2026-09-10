```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pwm_tb is
end pwm_tb;

architecture Behavioral of pwm_tb is

    -- Señales para conectar al DUT
    signal clk     : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '1';
    signal button  : STD_LOGIC := '0';
    signal pwm_out : STD_LOGIC;

    -- Período del reloj
    constant CLK_PERIOD : time := 10 ns;

begin

    ----------------------------------------------------------------
    -- Instancia del circuito que estamos probando
    ----------------------------------------------------------------

    DUT: entity work.pwm
        port map (
            clk     => clk,
            reset   => reset,
            button  => button,
            pwm_out => pwm_out
        );


    ----------------------------------------------------------------
    -- Generador de reloj
    ----------------------------------------------------------------

    clk_process : process
    begin

        while true loop

            clk <= '0';
            wait for CLK_PERIOD / 2;

            clk <= '1';
            wait for CLK_PERIOD / 2;

        end loop;

    end process;


    ----------------------------------------------------------------
    -- Estímulos
    ----------------------------------------------------------------

    stimulus : process
    begin

        -- Inicialmente tenemos RESET activo
        reset <= '1';
        button <= '0';

        wait for 50 ns;


        -- Quitamos RESET
        reset <= '0';

        wait for 100 ns;


        --==========================================================
        -- PRIMERA PULSACIÓN
        -- 0% -> 25%
        --==========================================================

        button <= '1';
        wait for CLK_PERIOD;

        button <= '0';

        wait for 200 ns;


        --==========================================================
        -- SEGUNDA PULSACIÓN
        -- 25% -> 50%
        --==========================================================

        button <= '1';
        wait for CLK_PERIOD;

        button <= '0';

        wait for 200 ns;


        --==========================================================
        -- TERCERA PULSACIÓN
        -- 50% -> 75%
        --==========================================================

        button <= '1';
        wait for CLK_PERIOD;

        button <= '0';

        wait for 200 ns;


        --==========================================================
        -- CUARTA PULSACIÓN
        -- 75% -> 100%
        --==========================================================

        button <= '1';
        wait for CLK_PERIOD;

        button <= '0';

        wait for 200 ns;


        --==========================================================
        -- QUINTA PULSACIÓN
        -- 100% -> 0%
        --==========================================================

        button <= '1';
        wait for CLK_PERIOD;

        button <= '0';

        wait for 200 ns;


        -- Fin de los estímulos
        wait;

    end process;

end Behavioral;
```
