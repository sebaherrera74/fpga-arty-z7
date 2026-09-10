
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        button_up   : in  STD_LOGIC;
        button_down : in  STD_LOGIC;
        button_freq : in  STD_LOGIC;
        pwm_out     : out STD_LOGIC
    );
end pwm;

architecture Behavioral of pwm is

    -- Reloj de la Arty Z7 = 125 MHz
    -- 125 MHz / 1 kHz = 125000 cuentas
    constant PERIOD : integer := 125000;

    -- Contador del PWM
    signal counter : integer range 0 to PERIOD-1 := 0;

    -- Duty:
    -- 0  = 0%
    -- 1  = 10%
    -- 2  = 20%
    -- ...
    -- 10 = 100%
    signal duty_select : integer range 0 to 10 := 0;

    -- Memoria del estado anterior de cada botón
    signal button_up_old   : STD_LOGIC := '0';
    signal button_down_old : STD_LOGIC := '0';
    signal button_freq_old : STD_LOGIC := '0';

begin

    process(clk)
    begin

        if rising_edge(clk) then

            if reset = '1' then

                counter         <= 0;
                duty_select     <= 0;

                button_up_old   <= '0';
                button_down_old <= '0';
                button_freq_old <= '0';

            else

                ------------------------------------------------
                -- CONTADOR PWM
                ------------------------------------------------

                if counter = PERIOD-1 then
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;


                ------------------------------------------------
                -- BOTON BTN0: AUMENTAR DUTY
                ------------------------------------------------

                if button_up = '1' and button_up_old = '0' then

                    if duty_select = 10 then
                        duty_select <= 0;
                    else
                        duty_select <= duty_select + 1;
                    end if;

                end if;


                ------------------------------------------------
                -- BOTON BTN1: DISMINUIR DUTY
                ------------------------------------------------

                if button_down = '1' and button_down_old = '0' then

                    if duty_select = 0 then
                        duty_select <= 10;
                    else
                        duty_select <= duty_select - 1;
                    end if;

                end if;


                ------------------------------------------------
                -- BTN2: RESERVADO PARA CAMBIAR FRECUENCIA
                ------------------------------------------------

                -- Por ahora no hacemos nada con button_freq.


                ------------------------------------------------
                -- GUARDAR ESTADO ANTERIOR DE LOS BOTONES
                ------------------------------------------------

                button_up_old   <= button_up;
                button_down_old <= button_down;
                button_freq_old <= button_freq;

            end if;

        end if;

    end process;


    ------------------------------------------------------------
    -- GENERACION DEL PWM
    ------------------------------------------------------------
    pwm_out <= '0' when duty_select = 0 else

               '1' when duty_select = 10 else

               '1' when duty_select = 1  and counter < 12500 else

               '1' when duty_select = 2  and counter < 25000 else

               '1' when duty_select = 3  and counter < 37500 else

               '1' when duty_select = 4  and counter < 50000 else

               '1' when duty_select = 5  and counter < 62500 else

               '1' when duty_select = 6  and counter < 75000 else

               '1' when duty_select = 7  and counter < 87500 else

               '1' when duty_select = 8  and counter < 100000 else

               '1' when duty_select = 9  and counter < 112500 else

               '0';

end Behavioral;



