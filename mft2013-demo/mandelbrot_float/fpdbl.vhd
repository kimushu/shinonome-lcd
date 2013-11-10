--------------------------------------------------------------------------------
-- Single precision float doubler (IEEE754)
-- (C) kimu_shu
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fpdbl is
  generic (
    LATENCY : integer range 2 to 15 := 2
  );
  port (
    clock   : in  std_logic;
    data    : in  std_logic_vector(31 downto 0);
    result  : out std_logic_vector(31 downto 0)
  );
end entity fpdbl;

architecture structure of fpdbl is

  subtype float is std_logic_vector(31 downto 0);
  type float_vector is array (Natural range <>) of float;

  signal latch_r  : float;
  signal buffer_r : float_vector(2 to LATENCY);
  signal exp_p1_w : std_logic_vector(7 downto 0);
  signal limit_w  : std_logic;
  signal infnan_w : std_logic;
  signal zerosn_w : std_logic;

  alias sign_w    : std_logic is latch_r(31);
  alias exp_w     : std_logic_vector(7 downto 0) is latch_r(30 downto 23);
  alias frac_w    : std_logic_vector(22 downto 0) is latch_r(22 downto 0);

begin -- structure

  exp_p1_w <= std_logic_vector(unsigned(exp_w) + 1);
  limit_w  <= '1' when (exp_w = X"FE") else '0';
  infnan_w <= '1' when (exp_w = X"FF") else '0';
  zerosn_w <= '1' when (exp_w = X"00") else '0';

  process (clock) begin
    if (rising_edge(clock)) then
      latch_r <= data;
      if (zerosn_w = '1' or infnan_w = '1') then
        -- Zero / Subnormal / Infinity / NaN
        buffer_r(2) <=
          sign_w &
          exp_w(7 downto 1) & (exp_w(0) and zerosn_w) &
          frac_w(21 downto 0) & (frac_w(22) and infnan_w);
      else
        -- Normal
        buffer_r(2) <=
          sign_w &
          exp_p1_w &
          (limit_w or frac_w(22)) & frac_w(21 downto 0);
      end if;
      for i in 3 to LATENCY loop
        buffer_r(i) <= buffer_r(i-1);
      end loop;
    end if;
  end process;

  result <= buffer_r(LATENCY);

end structure;

