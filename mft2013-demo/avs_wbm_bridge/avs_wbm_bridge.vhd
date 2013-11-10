--------------------------------------------------------------------------------
-- Avalon MM Slave to Wishbone Master Bridge
-- Author:  kimu_shu
-- License: MIT License (See LICENSE for details)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity avs_wbm_bridge is
  generic (
    ADDR_WIDTH  : integer := 1;
    WORD_WIDTH  : integer := 8
  );
  port (
    csi_clk         : in  std_logic;
    rsi_reset       : in  std_logic;

    avs_chipselect  : in  std_logic;
    avs_address     : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    avs_write       : in  std_logic;
    avs_writedata   : in  std_logic_vector(WORD_WIDTH-1 downto 0);
    avs_read        : in  std_logic;
    avs_readdata    : out std_logic_vector(WORD_WIDTH-1 downto 0);
    avs_waitrequest : out std_logic;

    wbm_adr_o       : out std_logic_vector(ADDR_WIDTH-1 downto 0);
    wbm_dat_i       : in  std_logic_vector(WORD_WIDTH-1 downto 0);
    wbm_dat_o       : out std_logic_vector(WORD_WIDTH-1 downto 0);
    wbm_we_o        : out std_logic;
    wbm_stb_o       : out std_logic;
    wbm_ack_i       : in  std_logic;
    wbm_cyc_o       : out std_logic
  );
end avs_wbm_bridge;

architecture structure of avs_wbm_bridge is
begin -- structure

  wbm_adr_o       <= avs_address;
  avs_readdata    <= wbm_dat_i;
  wbm_dat_o       <= avs_writedata;
  wbm_we_o        <= avs_write and (not avs_read);
  wbm_stb_o       <= avs_chipselect;
  avs_waitrequest <= not wbm_ack_i;
  wbm_cyc_o       <= avs_write or avs_read;

end structure;

