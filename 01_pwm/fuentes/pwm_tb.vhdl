library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pwm_tb is
end pwm_tb;

architecture Behavioral of pwm_tb is

    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal button_up   : STD_LOGIC := '0';
    signal button_down : STD_LOGIC := '0';
    signal button_freq : STD_LOGIC := '0';
    signal pwm_out     : STD_LOGIC;

    constant CLK_PERIOD : time := 8 ns;

begin

    -- Reloj
    clk <= not clk after CLK_PERIOD/2;


    -- Instancia del PWM
    DUT: entity work.pwm
        port map (
            clk         => clk,
            reset       => reset,
            button_up   => button_up,
            button_down => button_down,
            button_freq => button_freq,
            pwm_out     => pwm_out
        );


    -- Estímulos
    process
    begin

        -- Reset
        reset <= '1';
        wait for 100 ns;

        reset <= '0';
        wait for 200 ns;


        -- BTN0: aumentar duty
        button_up <= '1';
        wait for 100 ns;
        button_up <= '0';

        wait for 1 us;


        -- BTN0 nuevamente
        button_up <= '1';
        wait for 100 ns;
        button_up <= '0';

        wait for 1 us;


        -- BTN0 nuevamente
        button_up <= '1';
        wait for 100 ns;
        button_up <= '0';

        wait for 1 us;


        -- BTN1: disminuir duty
        button_down <= '1';
        wait for 100 ns;
        button_down <= '0';

        wait for 1 us;


        -- BTN1 nuevamente
        button_down <= '1';
        wait for 100 ns;
        button_down <= '0';

        wait for 1 us;


        -- BTN2: cambiar frecuencia
                -- 1 kHz -> 2 kHz
                button_freq <= '1';
                wait for 100 ns;
                button_freq <= '0';
        
                wait for 100 us;
        
        
                -- BTN2 nuevamente
                -- 2 kHz -> 5 kHz
                button_freq <= '1';
                wait for 100 ns;
                button_freq <= '0';
        
                wait for 100 us;
        
        
                -- BTN2 nuevamente
                -- 5 kHz -> 1 kHz
                button_freq <= '1';
                wait for 100 ns;
                button_freq <= '0';
        
                wait for 100 us;
        
        
                -- Finalizar simulación
                wait;

    end process;

end Behavioral;



