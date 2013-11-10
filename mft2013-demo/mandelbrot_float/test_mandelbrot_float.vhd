--------------------------------------------------------------------------------
-- Testbench for mandelbrot_float
-- (C) 2013 kimu_shu
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_mandelbrot_float is
end entity test_mandelbrot_float;

architecture behaviour of test_mandelbrot_float is

  component mandelbrot_float is
    generic (
      LCD_BASE            : std_logic_vector(31 downto 0) := X"00000000";
      ITER_WIDTH          : integer := 8
    );
    port (
      csi_s1_clk          : in  std_logic;
      rsi_s1_reset        : in  std_logic;
      avs_s1_address      : in  std_logic_vector(2 downto 0);
      avs_s1_write        : in  std_logic;
      avs_s1_writedata    : in  std_logic_vector(31 downto 0);
      avs_s1_read         : in  std_logic;
      avs_s1_readdata     : out std_logic_vector(31 downto 0);
      csi_m1_clk          : in  std_logic;
      rsi_m1_reset        : in  std_logic;
      avm_m1_address      : out std_logic_vector(31 downto 0);
      avm_m1_write        : out std_logic;
      avm_m1_writedata    : out std_logic_vector(7 downto 0);
      avm_m1_waitrequest  : in  std_logic
    );
  end component mandelbrot_float;

  function to_string (
    input : std_logic_vector
  ) return string is
    type std_logic_to_char_t is array(std_logic) of character;
    constant to_character : std_logic_to_char_t := (
      'U' => 'U', 'X' => 'X', '0' => '0', '1' => '1',
      'Z' => 'Z', 'W' => 'W', 'L' => 'L', 'H' => 'H',
      '-' => '-'
    );
    variable output : string(input'length downto 1);
  begin
    for i in output'range loop
      output(i) := to_character(input(i - 1));
    end loop;
    return output;
  end;

  constant SCYCLE : time := 7.5 ns;
  constant MCYCLE : time := 100 ns;
  -- constant MCYCLE : time := 20 ns;

  signal sclk_r : std_logic := '1';
  signal srst_r : std_logic := '0';
  signal mclk_r : std_logic := '1';
  signal mrst_r : std_logic := '0';

  signal s1addr_r   : std_logic_vector(2 downto 0) := (others => 'X');
  signal s1write_r  : std_logic := '0';
  signal s1wdata_r  : std_logic_vector(31 downto 0) := (others => 'X');
  signal s1rdata_w  : std_logic_vector(31 downto 0);

  signal m1addr_w   : std_logic_vector(31 downto 0);
  signal m1write_w  : std_logic;
  signal m1wdata_w  : std_logic_vector(7 downto 0);
  signal m1wreq_r   : std_logic;

begin -- behaviour

  process begin
    wait for SCYCLE / 2;
    sclk_r <= not sclk_r;
  end process;

  process begin
    wait for MCYCLE / 2;
    mclk_r <= not mclk_r;
  end process;

  process begin
    wait until rising_edge(sclk_r);
    srst_r <= '1';
    wait until rising_edge(sclk_r);
    srst_r <= '0';
    wait;
  end process;

  process begin
    wait until rising_edge(mclk_r);
    mrst_r <= '1';
    wait until rising_edge(mclk_r);
    mrst_r <= '0';

    wait until rising_edge(sclk_r);
    s1addr_r <= "000";
    s1wdata_r <= X"BFDFF713"; -- -1.74972763
--  s1wdata_r <= X"BFB0A3D7"; -- -1.38
--  s1wdata_r <= X"BF800000"; -- -1.00
--  s1wdata_r <= X"3E99999A"; -- +0.30
    s1write_r <= '1';
    wait until rising_edge(sclk_r);
    s1addr_r <= "001";
    s1wdata_r <= X"B80F51C2"; -- -0.00003417
--  s1wdata_r <= X"3C23D70A"; -- -0.01
--  s1wdata_r <= X"BCA3D70A"; -- -0.02
--  s1wdata_r <= X"BCF5C28F"; -- -0.03
--  s1wdata_r <= X"BD8F5C29"; -- -0.07
--  s1wdata_r <= X"BE47AE14"; -- -0.195
    s1write_r <= '1';
    wait until rising_edge(sclk_r);
    s1addr_r <= "010";
    s1wdata_r <= X"34F7C95B"; -- 0.0000004615384
--  s1wdata_r <= X"3FA3D70A"; -- 1.28
    s1write_r <= '1';
    wait until rising_edge(sclk_r);
    s1addr_r <= "011";
    s1wdata_r <= X"3477C95B"; -- 0.0000002307692
--  s1wdata_r <= X"3F23D70A"; -- 0.64
    s1write_r <= '1';
    wait until rising_edge(sclk_r);
    s1addr_r <= "XXX";
    s1wdata_r <= (others => 'X');
    s1write_r <= '0';

    wait until rising_edge(sclk_r);
    s1addr_r <= "111";
    s1write_r <= '1';
    wait until rising_edge(sclk_r);
    s1addr_r <= "XXX";
    s1write_r <= '0';
    wait;
  end process;

  process begin
    wait until rising_edge(mrst_r);
    m1wreq_r <= '0';
    wait until falling_edge(mrst_r);
    while (true) loop
      wait until rising_edge(mclk_r);
      if (m1write_w = '1') then
        report "avm_m1_writedata=" & to_string(m1wdata_w);
      end if;
    end loop;
    wait;
  end process;

  dut: mandelbrot_float
    generic map (
      LCD_BASE => X"01010000",
      ITER_WIDTH => 8
    )
    port map (
      csi_s1_clk          => sclk_r,
      rsi_s1_reset        => srst_r,
      avs_s1_address      => s1addr_r,
      avs_s1_write        => s1write_r,
      avs_s1_writedata    => s1wdata_r,
      avs_s1_read         => '0',
      avs_s1_readdata     => s1rdata_w,
      csi_m1_clk          => mclk_r,
      rsi_m1_reset        => mrst_r,
      avm_m1_address      => m1addr_w,
      avm_m1_write        => m1write_w,
      avm_m1_writedata    => m1wdata_w,
      avm_m1_waitrequest  => m1wreq_r
    );

end behaviour;

