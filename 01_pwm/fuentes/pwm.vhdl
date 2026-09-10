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
    constant CLK_FREQ : integer := 125000000;

    -- Selección de frecuencia:
    -- 0 = 1 kHz
    -- 1 = 2 kHz
    -- 2 = 5 kHz
    signal freq_select : integer range 0 to 2 := 0;

    -- Período del PWM
    signal period : integer range 0 to 125000 := 125000;

    -- Contador del PWM
    signal counter : integer range 0 to 124999 := 0;

    -- Duty:
    -- 0  = 0%
    -- 1  = 10%
    -- ...
    -- 10 = 100%
    signal duty_select : integer range 0 to 10 := 0;

    -- Memoria de estado anterior de los botones
    signal button_up_old   : STD_LOGIC := '0';
    signal button_down_old : STD_LOGIC := '0';
    signal button_freq_old : STD_LOGIC := '0';

begin

    ------------------------------------------------------------
    -- SELECCIÓN DEL PERÍODO
    ------------------------------------------------------------

    period <= 125000 when freq_select = 0 else
              62500  when freq_select = 1 else
              25000;


    ------------------------------------------------------------
    -- CONTADOR Y BOTONES
    ------------------------------------------------------------

    process(clk)
    begin

        if rising_edge(clk) then

            if reset = '1' then

                counter         <= 0;
                duty_select     <= 0;
                freq_select     <= 0;

                button_up_old   <= '0';
                button_down_old <= '0';
                button_freq_old <= '0';

            else

                ------------------------------------------------
                -- CONTADOR PWM
                ------------------------------------------------

                if counter >= period - 1 then
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;


                ------------------------------------------------
                -- BTN0: AUMENTAR DUTY
                ------------------------------------------------

                if button_up = '1' and button_up_old = '0' then

                    if duty_select = 10 then
                        duty_select <= 0;
                    else
                        duty_select <= duty_select + 1;
                    end if;

                end if;


                ------------------------------------------------
                -- BTN1: DISMINUIR DUTY
                ------------------------------------------------

                if button_down = '1' and button_down_old = '0' then

                    if duty_select = 0 then
                        duty_select <= 10;
                    else
                        duty_select <= duty_select - 1;
                    end if;

                end if;


                ------------------------------------------------
                -- BTN2: CAMBIAR FRECUENCIA
                ------------------------------------------------

                if button_freq = '1' and button_freq_old = '0' then

                    if freq_select = 2 then
                        freq_select <= 0;
                    else
                        freq_select <= freq_select + 1;
                    end if;

                    counter <= 0;

                end if;


                ------------------------------------------------
                -- GUARDAR ESTADO ANTERIOR
                ------------------------------------------------

                button_up_old   <= button_up;
                button_down_old <= button_down;
                button_freq_old <= button_freq;

            end if;

        end if;

    end process;


    ------------------------------------------------------------
    -- GENERACIÓN DEL PWM
    ------------------------------------------------------------

    pwm_out <= '0' when duty_select = 0 else

               '1' when duty_select = 10 else

               '1' when duty_select = 1 and counter < period * 1 / 10 else

               '1' when duty_select = 2 and counter < period * 2 / 10 else

               '1' when duty_select = 3 and counter < period * 3 / 10 else

               '1' when duty_select = 4 and counter < period * 4 / 10 else

               '1' when duty_select = 5 and counter < period * 5 / 10 else

               '1' when duty_select = 6 and counter < period * 6 / 10 else

               '1' when duty_select = 7 and counter < period * 7 / 10 else

               '1' when duty_select = 8 and counter < period * 8 / 10 else

               '1' when duty_select = 9 and counter < period * 9 / 10 else

               '0';

end Behavioral;