```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        button  : in  STD_LOGIC;
        pwm_out : out STD_LOGIC
    );
end pwm;

architecture Behavioral of pwm is

    -- 100 MHz / 1 kHz = 100000 cuentas
    constant PERIOD : integer := 100;

    signal counter : integer range 0 to PERIOD-1 := 0;

    -- 0 = 0%
    -- 1 = 25%
    -- 2 = 50%
    -- 3 = 75%
    -- 4 = 100%
    signal duty_select : integer range 0 to 4 := 0;

    signal button_old : STD_LOGIC := '0';

begin

    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then

                counter     <= 0;
                duty_select <= 0;
                button_old  <= '0';

            else

                -- Contador PWM
                if counter = PERIOD-1 then
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;

                -- Detectar flanco ascendente del pulsador
                if button = '1' and button_old = '0' then

                    if duty_select = 4 then
                        duty_select <= 0;
                    else
                        duty_select <= duty_select + 1;
                    end if;

                end if;

                button_old <= button;

            end if;

        end if;
    end process;


    -- Generación del PWM

    pwm_out <= '0' when duty_select = 0 else

               '1' when duty_select = 4 else

               '1' when duty_select = 1 and counter < 25 else

               '1' when duty_select = 2 and counter < 50 else

               '1' when duty_select = 3 and counter < 75 else

               '0';


end Behavioral;
```
