--------------------------------------------------------------------------------
-- SPI Master to TCM bridge
-- Author:  kimu_shu
-- License: MIT License (See LICENSE for details)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity spim_tcm_bridge_miso8 is
generic (
  SLAVES  : integer := 1
);
port (
  csi_clk         : in  std_logic;
  rsi_reset_n     : in  std_logic;
  avs_write       : in  std_logic;
  avs_writedata   : in  std_logic_vector(7 downto 0);
  avs_read        : in  std_logic;
  avs_readdata    : out std_logic_vector(7 downto 0);

  coe_MISO        : out std_logic;
  coe_MOSI        : in  std_logic;
  coe_SCLK        : in  std_logic;
  coe_SS_n        : in  std_logic_vector(SLAVES-1 downto 0);

  tcm_request     : out std_logic;
  tcm_grant       : in  std_logic;
  tcm_miso_in     : in  std_logic_vector(7 downto 0);
  tcm_miso_out    : out std_logic_vector(7 downto 0);
  tcm_miso_outen  : out std_logic;
  tcm_mosi_out    : out std_logic;
--tcm_mosi_outen  : out std_logic;
  tcm_sclk_out    : out std_logic;
--tcm_sclk_outen  : out std_logic;
  tcm_ss_n_out    : out std_logic_vector(SLAVES-1 downto 0)--;
--tcm_ss_n_outen  : out std_logic
);
end spim_tcm_bridge_miso8;

architecture rtl of spim_tcm_bridge_miso8 is

-- Register description
-- bit2: (R/W) Keep bus ownership
-- bit1: (W) Acquire bus / (R) Current bus ownership
-- bit0: (W) Release bus / (R) Always zero

signal request_r : std_logic;
signal keepbus_r : std_logic;

begin -- rtl

coe_MISO <= tcm_miso_in(0);
tcm_request <= request_r;
tcm_miso_out <= (others => '0');
tcm_miso_outen <= '0';
tcm_mosi_out <= coe_MOSI;
-- tcm_mosi_outen <= '1';
tcm_sclk_out <= coe_SCLK;
-- tcm_sclk_outen <= '1';
tcm_ss_n_out <= coe_SS_n;
-- tcm_ss_n_outen <= '1';

avs_readdata <= "XXXXX" & keepbus_r & (tcm_grant and request_r) & '0';

process (csi_clk, rsi_reset_n) begin
  if (rsi_reset_n = '0') then
    request_r <= '0';
    keepbus_r <= '0';
  elsif (rising_edge(csi_clk)) then
    if (avs_write = '1') then
      if (avs_writedata(0) = '1') then
        request_r <= '0';
      elsif (avs_writedata(1) = '1') then
        request_r <= '1';
      end if;
      keepbus_r <= avs_writedata(2);
    elsif (keepbus_r = '0' and and_reduce(coe_SS_n) = '1') then
      request_r <= '0';
    end if;
  end if;
end process;

end rtl;

