ENTITY merahkuninghijau IS
  PORT (
    clk, interrupt : IN  BIT;
    merah, kuning, hijau : OUT BIT
  );
END merahkuninghijau;

ARCHITECTURE behavior OF merahkuninghijau IS
  TYPE state_type IS (red1, red2, red3, yellow1, green1, green2, green3);
  SIGNAL state, next_state : state_type;

BEGIN
PROCESS (clk)
BEGIN
    IF clk'event AND clk = '1' THEN
        state <= next_state;
    END IF;
END PROCESS;

  PROCESS (state, interrupt)
  BEGIN
    CASE state IS
      WHEN red1 =>
        IF interrupt = '1' THEN
          next_state <= red3;
        ELSE
          next_state <= red2;
        END IF;

      WHEN red2 =>
        IF interrupt = '1' THEN
          next_state <= red3;
        ELSE
          next_state <= red3;
        END IF;

      WHEN red3 =>
        IF interrupt = '1' THEN
          next_state <= red3;
        ELSE
          next_state <= yellow1;
        END IF;

      WHEN yellow1 =>
        IF interrupt = '1' THEN
          next_state <= red3;
        ELSE
          next_state <= green1;
        END IF;

      WHEN green1 =>
        IF interrupt = '1' THEN
          next_state <= red3;
        ELSE
          next_state <= green2;
        END IF;

      WHEN green2 =>
        IF interrupt = '1' THEN
          next_state <= red3;
        ELSE
          next_state <= green3;
        END IF;

      WHEN green3 =>
        IF interrupt = '1' THEN
          next_state <= red3;
        ELSE
          next_state <= red1;
        END IF;
    END CASE;
  END PROCESS;

  PROCESS (state)
  BEGIN
    CASE state IS
      WHEN red1 | red2 | red3 =>
        merah <= '1';
        kuning <= '0';
        hijau <= '0';

      WHEN yellow1 =>
        merah <= '0';
        kuning <= '1';
        hijau <= '0';

      WHEN green1 | green2 | green3 =>
        merah <= '0';
        kuning <= '0';
        hijau <= '1';

      WHEN OTHERS =>
        merah <= '0';
        kuning <= '0';
        hijau <= '0';
    END CASE;
  END PROCESS;
END behavior;
