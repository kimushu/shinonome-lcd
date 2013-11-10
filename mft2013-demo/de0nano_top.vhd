--------------------------------------------------------------------------------
-- Terasic DE0-Nano Top Module for shinonome-lcd/mft2013-demo
-- Author:  kimu_shu
-- License: MIT License (See LICENSE for details)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity de0nano_top is
port (
  -- Clock
  CLOCK_50      : in    std_logic;

  -- LED
  LED           : out   std_logic_vector(7 downto 0);

  -- Push switch
  KEY           : in    std_logic_vector(1 downto 0);

  -- DIP switch
  SW            : in    std_logic_vector(3 downto 0);

  -- SDR-SDRAM
  DRAM_ADDR     : out   std_logic_vector(12 downto 0);
  DRAM_BA       : out   std_logic_vector(1 downto 0);
  DRAM_CAS_N    : out   std_logic;
  DRAM_CKE      : out   std_logic;
  DRAM_CLK      : out   std_logic;
  DRAM_CS_N     : out   std_logic;
  DRAM_DQ       : inout std_logic_vector(15 downto 0);
  DRAM_DQM      : out   std_logic_vector(1 downto 0);
  DRAM_RAS_N    : out   std_logic;
  DRAM_WE_N     : out   std_logic;

  -- EPCS Flash
  EPCS_ASDO     : out   std_logic;
  EPCS_DATA0    : in    std_logic;
  EPCS_DCLK     : out   std_logic;
  EPCS_NCSO     : out   std_logic;

  -- Accelerometer and EEPROM
  G_SENSOR_CS_N : out   std_logic;
  G_SENSOR_INT  : in    std_logic;
  I2C_SCLK      : inout std_logic;
  I2C_SDAT      : inout std_logic;

  -- ADC
  ADC_CS_N      : out   std_logic;
  ADC_SADDR     : out   std_logic;
  ADC_SCLK      : out   std_logic;
  ADC_SDAT      : in    std_logic;

  -- 2x13 GPIO Header
  GPIO_2        : inout std_logic_vector(12 downto 0);
  GPIO_2_IN     : in    std_logic_vector(2 downto 0);

  -- GPIO_0
  GPIO_0        : inout std_logic_vector(33 downto 0);
  GPIO_0_IN     : in    std_logic_vector(1 downto 0);

  -- GPIO_1
  GPIO_1        : inout std_logic_vector(33 downto 0);
  GPIO_1_IN     : in    std_logic_vector(1 downto 0)
);
end entity;

architecture structure of de0nano_top is

-- Signal declarations here

  component de0nano_nios2 is
    port (
      epcs_dclk          : out   std_logic;                                        -- dclk
      epcs_sce           : out   std_logic;                                        -- sce
      epcs_sdo           : out   std_logic;                                        -- sdo
      epcs_data0         : in    std_logic                     := 'X';             -- data0
      sdram_addr         : out   std_logic_vector(12 downto 0);                    -- addr
      sdram_ba           : out   std_logic_vector(1 downto 0);                     -- ba
      sdram_cas_n        : out   std_logic;                                        -- cas_n
      sdram_cke          : out   std_logic;                                        -- cke
      sdram_cs_n         : out   std_logic;                                        -- cs_n
      sdram_dq           : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
      sdram_dqm          : out   std_logic_vector(1 downto 0);                     -- dqm
      sdram_ras_n        : out   std_logic;                                        -- ras_n
      sdram_we_n         : out   std_logic;                                        -- we_n
      led_export         : out   std_logic_vector(7 downto 0);                     -- export
      pushsw_export      : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
      dipsw_export       : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
      -- For mmcdma by s.osafune {{{
--    mmc_nCS            : out   std_logic;                                        -- nCS
--    mmc_SCK            : out   std_logic;                                        -- SCK
--    mmc_SDO            : out   std_logic;                                        -- SDO
--    mmc_SDI            : in    std_logic                     := 'X';             -- SDI
--    mmc_CD             : in    std_logic                     := 'X';             -- CD
--    mmc_WP             : in    std_logic                     := 'X';             -- WP
      -- }}}
      i2cbus_scl_in      : in    std_logic                     := 'X';             -- scl_in
      i2cbus_scl_out     : out   std_logic;                                        -- scl_out
      i2cbus_sda_in      : in    std_logic                     := 'X';             -- sda_in
      i2cbus_sda_outen   : out   std_logic;                                        -- sda_outen
      i2cbus_sda_out     : out   std_logic;                                        -- sda_out
      i2cbus_scl_outen   : out   std_logic;                                        -- scl_outen
      clk_core_clk       : in    std_logic                     := 'X';             -- clk
      reset_core_reset_n : in    std_logic                     := 'X';             -- reset_n
      clk_peri_clk       : in    std_logic                     := 'X';             -- clk
      reset_peri_reset_n : in    std_logic                     := 'X';             -- reset_n
      -- For shinonome-lcd rev1.1 {{{
      gpio2_addr_mosi    : out   std_logic_vector(0 downto 0);                     -- addr_mosi
      gpio2_csio_n       : out   std_logic_vector(0 downto 0);                     -- csio_n
      gpio2_data_miso    : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- data_miso
      gpio2_wr_n_sck     : out   std_logic_vector(0 downto 0);                     -- wr_n_sck
      gpio2_rd_n         : out   std_logic_vector(0 downto 0);                     -- rd_n
      gpio2_cslcd_n      : out   std_logic_vector(0 downto 0);                     -- cslcd_n
      -- }}}
      adc_MISO           : in    std_logic                     := 'X';             -- MISO
      adc_MOSI           : out   std_logic;                                        -- MOSI
      adc_SCLK           : out   std_logic;                                        -- SCLK
      adc_SS_n           : out   std_logic;                                        -- SS_n
      gpio0lo_export     : inout std_logic_vector(31 downto 0) := (others => 'X'); -- export
      gpio0hi_export     : inout std_logic_vector(1 downto 0)  := (others => 'X'); -- export
      gpio0in_export     : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
      -- If mmcdma is used, gpio1xx must be disabled {{{
      gpio1lo_export     : inout std_logic_vector(31 downto 0) := (others => 'X'); -- export
      gpio1hi_export     : inout std_logic_vector(1 downto 0)  := (others => 'X'); -- export
      gpio1in_export     : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
      -- }}}
      gpio2in_export     : in    std_logic_vector(2 downto 0)  := (others => 'X')  -- export
    );
  end component de0nano_nios2;

  component syspll
    port (
      inclk0  : in  std_logic := '0';
      c0      : out std_logic;
      c1      : out std_logic;
      c2      : out std_logic;
      locked  : out std_logic
    );
  end component syspll;

  function reverse_bus(b: std_logic_vector)
    return std_logic_vector is
    variable r: std_logic_vector(b'range);
  begin
    for i in r'range loop
      r(i) := b(b'low+r'high-i);
    end loop;
    return r;
  end;

  signal clk_core_w   : std_logic;
  signal clk_sdr_w    : std_logic;
  signal clk_peri_w   : std_logic;
  signal clk_locked_w : std_logic;
  signal sys_reset_w  : std_logic;

  -- For mmcdma by s.osafune {{{
--signal mmc_cs_n_w   : std_logic;
--signal mmc_sck_w    : std_logic;
--signal mmc_sdo_w    : std_logic;
--signal mmc_sdi_w    : std_logic;
--signal mmc_cd_w     : std_logic;
--signal mmc_wp_w     : std_logic;
  -- }}}

  signal i2c_scl_w    : std_logic;
  signal i2c_sclen_w  : std_logic;
  signal i2c_sda_w    : std_logic;
  signal i2c_sdaen_w  : std_logic;

begin -- structure

-- Structural coding

  DRAM_CLK    <= clk_sdr_w;

  -- For mmcdma by s.osafune {{{
--GPIO_1(24)  <= mmc_cs_n_w;
--GPIO_1(7)   <= not mmc_cs_n_w;
--GPIO_1(26)  <= mmc_sck_w;
--GPIO_1(27)  <= mmc_sdo_w;
--mmc_sdi_w   <= GPIO_1(29);
--mmc_cd_w    <= GPIO_1(21);
--mmc_wp_w    <= '1';
  --

  I2C_SCLK    <= 'Z' when (i2c_sclen_w = '0') else i2c_scl_w;
  I2C_SDAT    <= 'Z' when (i2c_sdaen_w = '0') else i2c_sda_w;

  u_pll: component syspll
    port map (
      inclk0  => CLOCK_50,
      c0      => clk_core_w,
      c1      => clk_sdr_w,
      c2      => clk_peri_w,
      locked  => clk_locked_w
    );

  sys_reset_w <= clk_locked_w and KEY(0);

  u_sys: component de0nano_nios2
  port map (
    epcs_dclk          => EPCS_DCLK,
    epcs_sce           => EPCS_NCSO,
    epcs_sdo           => EPCS_ASDO,
    epcs_data0         => EPCS_DATA0,
    sdram_addr         => DRAM_ADDR,
    sdram_ba           => DRAM_BA,
    sdram_cas_n        => DRAM_CAS_N,
    sdram_cke          => DRAM_CKE,
    sdram_cs_n         => DRAM_CS_N,
    sdram_dq           => DRAM_DQ,
    sdram_dqm          => DRAM_DQM,
    sdram_ras_n        => DRAM_RAS_N,
    sdram_we_n         => DRAM_WE_N,
    led_export         => LED,
    pushsw_export      => KEY,
    dipsw_export       => SW,
    -- For mmcdma by s.osafune {{{
--  mmc_nCS            => mmc_cs_n_w,
--  mmc_SCK            => mmc_sck_w,
--  mmc_SDO            => mmc_sdo_w,
--  mmc_SDI            => mmc_sdi_w,
--  mmc_CD             => mmc_cd_w,
--  mmc_WP             => mmc_wp_w,
    -- }}}
    i2cbus_scl_in      => I2C_SCLK,
    i2cbus_scl_out     => i2c_scl_w,
    i2cbus_scl_outen   => i2c_sclen_w,
    i2cbus_sda_in      => I2C_SDAT,
    i2cbus_sda_out     => i2c_sda_w,
    i2cbus_sda_outen   => i2c_sdaen_w,
    clk_core_clk       => clk_core_w,
    reset_core_reset_n => sys_reset_w,
    clk_peri_clk       => clk_peri_w,
    reset_peri_reset_n => sys_reset_w,
    -- For shinonome-lcd rev1.1 {{{
    gpio2_addr_mosi    => GPIO_2(2 downto 2),
    gpio2_csio_n       => GPIO_2(0 downto 0),
    gpio2_data_miso    => reverse_bus(GPIO_2(12 downto 5)),
    gpio2_wr_n_sck     => GPIO_2(3 downto 3),
    gpio2_rd_n         => GPIO_2(4 downto 4),
    gpio2_cslcd_n      => GPIO_2(1 downto 1),
    -- }}}
    adc_MISO           => ADC_SDAT,
    adc_MOSI           => ADC_SADDR,
    adc_SCLK           => ADC_SCLK,
    adc_SS_N           => ADC_CS_N,
    gpio0lo_export     => GPIO_0(31 downto 0),
    gpio0hi_export     => GPIO_0(33 downto 32),
    gpio0in_export     => GPIO_0_IN,
    -- If mmcdma is used, gpio1xx must be disabled {{{
    gpio1lo_export     => GPIO_1(31 downto 0),
    gpio1hi_export     => GPIO_1(33 downto 32),
    gpio1in_export     => GPIO_1_IN,
    -- }}}
    gpio2in_export     => GPIO_2_IN
  );

end structure;

