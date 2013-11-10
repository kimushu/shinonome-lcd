--------------------------------------------------------------------------------
-- Mandelbrot (Single precision float) plotter (320x240)
-- Author:  kimu_shu
-- License: MIT License (See LICENSE for details)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mandelbrot_float is
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
end entity mandelbrot_float;

architecture structure of mandelbrot_float is

  component fpadd is
    port
    (
      clock   : in std_logic ;
      dataa   : in std_logic_vector (31 downto 0);
      datab   : in std_logic_vector (31 downto 0);
      result  : out std_logic_vector (31 downto 0)
    );
  end component fpadd;

  component fpsub is
    port
    (
      clock   : in std_logic ;
      dataa   : in std_logic_vector (31 downto 0);
      datab   : in std_logic_vector (31 downto 0);
      result  : out std_logic_vector (31 downto 0)
    );
  end component fpsub;

  component fpmul is
    port
    (
      clock   : in std_logic ;
      dataa   : in std_logic_vector (31 downto 0);
      datab   : in std_logic_vector (31 downto 0);
      result  : out std_logic_vector (31 downto 0)
    );
  end component fpmul;

  component fpdbl is
    generic (
      LATENCY : integer range 2 to 15 := 2
    );
    port (
      clock   : in  std_logic;
      data    : in  std_logic_vector(31 downto 0);
      result  : out std_logic_vector(31 downto 0)
    );
  end component fpdbl;

  component mb_fifo is
    port
    (
      aclr    : in std_logic  := '0';
      data    : in std_logic_vector (7 downto 0);
      rdclk   : in std_logic ;
      rdreq   : in std_logic ;
      wrclk   : in std_logic ;
      wrreq   : in std_logic ;
      q       : out std_logic_vector (7 downto 0);
      rdempty : out std_logic ;
      wrfull  : out std_logic
    );
  end component mb_fifo;

  type state is (IDLE, CALCCI, CALCCR, ITER0, ITERN, WRITE, WAIT0, WAIT1);

  subtype float is std_logic_vector(31 downto 0);
  type float_vector is array (Natural range <>) of float;

  subtype iter is unsigned(ITER_WIDTH-1 downto 0);
  type iter_vector is array (Natural range <>) of iter;

  signal cr0_r      : float;  -- address = "000"
  signal ci0_r      : float;  -- address = "001"
  signal wr_r       : float;  -- address = "010"
  signal wi_r       : float;  -- address = "011"
  signal zr0_r      : float;  -- address = "100"
  signal zi0_r      : float;  -- address = "101"

  --       xonly
  --         |
  -- 000000001 01110111 (x only)
  -- 00000001x 01111000
  -- 0000001xx 01111001
  -- 000001xxx 01111010
  -- 00001xxxx 01111011
  -- 0001xxxxx 01111100
  -- 001xxxxxx 01111101
  -- 01xxxxxxx 01111110
  -- 1xxxxxxxx 01111111
  signal state_r    : state;
  signal state_1d_r : state;
  signal stage_r    : std_logic_vector(19 downto 0);
  signal ibsel_r    : std_logic;
  signal xfrac_r    : unsigned(7 downto 0);
  signal xfadd_r    : unsigned(8 downto 0);
  signal xfinc_w    : unsigned(8 downto 0);
  signal xexp_r     : unsigned(3 downto 0);
  signal xfl_w      : float;
  signal yfrac_r    : unsigned(6 downto 0);
  signal yfadd_r    : unsigned(7 downto 0);
  signal yfinc_w    : unsigned(7 downto 0);
  signal yexp_r     : unsigned(2 downto 0);
  signal yfl_w      : float;
  signal cr_r       : float_vector(0 to 19);
  signal ci_r       : float;
  signal iter_r     : iter_vector(0 to 19);
  signal niter_w    : unsigned(ITER_WIDTH downto 0);
  signal diverge_r  : std_logic_vector(6 downto 0);
  signal stop_r     : std_logic_vector(19 downto 0);
  signal stopall_r  : std_logic;

  signal zr_0d_w    : float;
  signal zi_0d_w    : float;
  signal zr2_6d_w   : float;
  signal zi2_6d_w   : float;
  signal mula_w     : float;
  signal mulb_w     : float;
  signal zrzi_6d_w  : float;
  signal zrzi2_13d_w    : float;
  signal zr2mzi2_13d_w  : float;
  signal zr2pzi2_13d_w  : float;
  signal addib_w    : float;

  signal wrreq_w    : std_logic;
  signal wrdata_w   : std_logic_vector(7 downto 0) := X"00";
  signal wrfull_w   : std_logic;
  signal rdack_w    : std_logic;
  signal rddata_w   : std_logic_vector(7 downto 0);
  signal rdempty_w  : std_logic;
  signal rdbyte_r   : std_logic;
  signal color16_w  : std_logic_vector(15 downto 0);
  signal rdempty_s1_r : std_logic_vector(1 downto 0);

begin -- structure

  process (csi_s1_clk, rsi_s1_reset) begin
    if (rsi_s1_reset = '1') then
      state_r <= IDLE;
    elsif (rising_edge(csi_s1_clk)) then
      case (state_r) is
        when IDLE =>
          if (avs_s1_write = '1' and avs_s1_address = "111") then
            state_r <= CALCCI;
          end if;
        when CALCCI =>
          -- 241 = 1.1110001 * 2^7
          if (yfrac_r(6 downto 4) = "111" and yfrac_r(0) = '1' and
              yfadd_r(0) = '1') then
            state_r <= WAIT0;
          else
            state_r <= CALCCR;
          end if;
        when CALCCR =>
          if (stage_r(19) = '1') then
            state_r <= ITER0;
          end if;
        when ITER0 =>
          if (stage_r(19) = '1') then
            state_r <= ITERN;
          end if;
        when ITERN =>
          if (stage_r(1) = '1' and stopall_r = '1') then
            state_r <= WRITE;
          end if;
        when WRITE =>
          if (stage_r(1) = '1' and wrfull_w = '0') then
            state_r <= CALCCI;
          end if;
        when WAIT0 =>
          if (rdempty_s1_r(1) = '0') then
            state_r <= WAIT1;
          end if;
        when WAIT1 =>
          if (rdempty_s1_r(1) = '1') then
            state_r <= IDLE;
          end if;
      end case;
    end if;
    state_1d_r <= state_r;
  end process;

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      if (state_r = CALCCI) then
        stage_r <= (0 => '1', others => '0');
      elsif (state_r /= WRITE or wrfull_w = '0') then
        stage_r <= stage_r(18 downto 0) & stage_r(19);
      end if;
    end if;
  end process;

--               0             6             7             7            --
--  zr0 ------|~~~~~|                                                   --
--            | MUX |---+                                               --
--        +---|_____|   |   |~~~~~|                cr --|~~~~~|         --
--  zr ---|             +---| SQ  |-------|~~~~~|       | ADD |-- zr'   --
--        +---|~~~~~|       |_____|       | SUB |-------|_____|         --
--  wr -------| MUX |---+            +----|_____|                       --
--  wi -------|_____|   +---|~~~~~|  |                                  --
--                          | MUL |--)--+                               --
--  x --------|~~~~~|   +---|_____|  |  |                               --
--  y --------| MUX |---+            |  | |~~~~~|                       --
--        +---|_____|       |~~~~~|  |  +-| x2  |-------|~~~~~|         --
--  zi ---|             +---| SQ  |--+    |_____|       | ADD |-- zi'   --
--        +---|~~~~~|   |   |_____|              0    +-|_____|   cr    --
--            | MUX |---+                ci --|~~~~~| |           ci    --
--  zi0 ------|_____|                   cr0 --| MUX |-+                 --
--                                      ci0 --|_____|                   --

  u_sqr: fpmul  -- Multiplier (zr*zr)
    port map (
      clock   => csi_s1_clk,
      dataa   => mula_w,
      datab   => mula_w,
      result  => zr2_6d_w
    );

  u_sqi: fpmul  -- Multiplier (zi*zi)
    port map (
      clock   => csi_s1_clk,
      dataa   => mulb_w,
      datab   => mulb_w,
      result  => zi2_6d_w
    );

  mula_w <= wi_r when (state_r = CALCCI) else
            wr_r when (state_r = CALCCR) else
            zr0_r when (state_r = ITER0) else
            zr_0d_w;

  mulb_w <= yfl_w when (state_r = CALCCI) else
            xfl_w when (state_r = CALCCR) else
            zi0_r when (state_r = ITER0) else
            zi_0d_w;

  u_mul: fpmul  -- Multiplier (zr*zi / wr*x / wi*y)
    port map (
      clock   => csi_s1_clk,
      dataa   => mula_w,
      datab   => mulb_w,
      result  => zrzi_6d_w
    );

  u_dbl: fpdbl  -- Doubler (zrzi*2)
    generic map (
      LATENCY => 7
    )
    port map (
      clock   => csi_s1_clk,
      data    => zrzi_6d_w,
      result  => zrzi2_13d_w
    );

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      if (state_r = CALCCI) then
        ibsel_r <= '0';
      elsif (state_r = ITER0 and stage_r(12) = '1') then
        ibsel_r <= '1';
      end if;
    end if;
  end process;

  addib_w <= ci_r when (ibsel_r = '1') else
             ci0_r when (stage_r(12) = '1' and state_r = CALCCR) else
             cr0_r;

  u_sub: fpsub  -- Subtracter (zr2-zi2)
    port map (
      clock   => csi_s1_clk,
      dataa   => zr2_6d_w,
      datab   => zi2_6d_w,
      result  => zr2mzi2_13d_w
    );

  u_addr: fpadd -- Adder (zr2mzi2+cr)
    port map (
      clock   => csi_s1_clk,
      dataa   => cr_r(12),
      datab   => zr2mzi2_13d_w,
      result  => zr_0d_w
    );

  u_addi: fpadd -- Adder (2zrzi+ci)
    port map (
      clock   => csi_s1_clk,
      dataa   => zrzi2_13d_w,
      datab   => addib_w,
      result  => zi_0d_w
    );

  u_adds: fpadd -- Adder (zr2+zi2)
    port map (
      clock   => csi_s1_clk,
      dataa   => zr2_6d_w,
      datab   => zi2_6d_w,
      result  => zr2pzi2_13d_w
    );

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      if (state_r = CALCCR and stage_r(19) = '1') then
        ci_r <= zi_0d_w;
      end if;
    end if;
  end process;

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      if (state_1d_r = ITER0) then
        cr_r(0) <= zi_0d_w;
      else
        cr_r(0) <= cr_r(19);
      end if;
      for i in 1 to 19 loop
        cr_r(i) <= cr_r(i-1);
      end loop;
    end if;
  end process;

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      if (state_r = ITER0) then
        iter_r(0) <= (others => '0');
      elsif (state_r = ITERN and stop_r(19) = '0' and diverge_r(6) = '0') then
        iter_r(0) <= niter_w(iter'range);
      elsif (state_r /= WRITE or wrfull_w = '0') then
        iter_r(0) <= iter_r(19);
      end if;
      if (state_r /= WRITE or wrfull_w = '0') then
        for i in 1 to 19 loop
          iter_r(i) <= iter_r(i-1);
        end loop;
      end if;
    end if;
  end process;

  niter_w <= ('0' & iter_r(19)) + 1;

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      if (state_r = ITER0) then
        stop_r <= (others => '0');
      else
        stop_r <= stop_r(18 downto 0) & (stop_r(19) or diverge_r(6) or niter_w(niter_w'high));
      end if;
    end if;
  end process;

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      if (unsigned(zr2pzi2_13d_w(30 downto 23)) >= 129) then
        diverge_r(0) <= '1';
      else
        diverge_r(0) <= '0';
      end if;
      diverge_r(6 downto 1) <= diverge_r(5 downto 0);
    end if;
  end process;

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      if (state_r = ITER0) then
        stopall_r <= '0';
      elsif (stage_r(1) = '1') then
        stopall_r <= stop_r(0);
      else
        stopall_r <= stopall_r and stop_r(0);
      end if;
    end if;
  end process;

  xfinc_w <= ('0' & xfrac_r) + xfadd_r;
  yfinc_w <= ('0' & yfrac_r) + yfadd_r;

  -- for(xfl_w = 1/256; xfl_w < 320/256; xfl_w += 1/256)
  xfl_w(31) <= '0';                                 -- sign
  xfl_w(30 downto 27) <= "0111";                    -- exponent (high)
  xfl_w(26 downto 23) <= std_logic_vector(xexp_r);  -- exponent (low)
  xfl_w(22 downto 15) <= std_logic_vector(xfrac_r); -- fraction (high)
  xfl_w(14 downto 0)  <= (others => '0');           -- fraction (low)
  -- for(yfl_w = 1/128; yfl_w < 240/128; yfl_w += 1/128)
  yfl_w(31) <= '0';                                 -- sign
  yfl_w(30 downto 26) <= "01111";                   -- exponent (high)
  yfl_w(25 downto 23) <= std_logic_vector(yexp_r);  -- exponent (low)
  yfl_w(22 downto 16) <= std_logic_vector(yfrac_r); -- fraction (high)
  yfl_w(15 downto 0)  <= (others => '0');           -- fraction (low)

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      if (state_r = IDLE) then
        xfrac_r <= (others => '0');
        xfadd_r <= (8 => '1', others => '0');
        xexp_r  <= "0111";
        yfrac_r <= (others => '0');
        yfadd_r <= (7 => '1', others => '0');
        yexp_r  <= "000";
      elsif (state_r = CALCCI) then
        -- 321 = 1.01000001 * 2^8 (but xfrac_r(0) can be ignored)
        if (xfrac_r(6) = '1' and xexp_r = "1111") then
          xfrac_r <= (others => '0');
          xfadd_r <= (8 => '1', others => '0');
          xexp_r  <= "0111";
          yfrac_r <= yfinc_w(6 downto 0);
          if (yfinc_w(7) = '1') then
            yfadd_r <= '0' & yfadd_r(7 downto 1);
            yexp_r  <= yexp_r + 1;
          end if;
        end if;
      elsif (state_r = CALCCR) then
        xfrac_r <= xfinc_w(7 downto 0);
        if (xfinc_w(8) = '1') then
          xfadd_r <= '0' & xfadd_r(8 downto 1);
          xexp_r  <= xexp_r + 1;
        end if;
      end if;
    end if;
  end process;

  process (csi_s1_clk, rsi_s1_reset) begin
    if (rsi_s1_reset = '1') then
      cr0_r     <= X"c019999a"; -- (-2.4)
      ci0_r     <= X"bf99999a"; -- (-1.2)
      wr_r      <= X"4023d70a"; -- (3.2/320*256)
      wi_r      <= X"3fa3d70a"; -- (2.4/240*128)
      zr0_r     <= X"00000000"; -- (0.0)
      zi0_r     <= X"00000000"; -- (0.0)
    elsif (rising_edge(csi_s1_clk)) then
      if (avs_s1_write = '1') then
        case (avs_s1_address) is
          when "000" =>
            cr0_r <= avs_s1_writedata;
          when "001" =>
            ci0_r <= avs_s1_writedata;
          when "010" =>
            wr_r <= avs_s1_writedata;
          when "011" =>
            wi_r <= avs_s1_writedata;
          when "100" =>
            zr0_r <= avs_s1_writedata;
          when "101" =>
            zi0_r <= avs_s1_writedata;
          when others =>
            null;
        end case;
      end if;
    end if;
  end process;

  avs_s1_readdata(0) <= '1' when (state_r /= IDLE) else '0';
  avs_s1_readdata(31 downto 1) <= (others => '0');

  wrdata_w(iter'range) <= std_logic_vector(iter_r(1));
  wrreq_w <= (not wrfull_w) when state_r = WRITE else '0';

  process (csi_s1_clk) begin
    if (rising_edge(csi_s1_clk)) then
      -- m1 -> s1 synchronization
      rdempty_s1_r <= rdempty_s1_r(0) & rdempty_w;
    end if;
  end process;

  u_fifo: mb_fifo
    port map (
      aclr    => rsi_s1_reset,
      data    => wrdata_w,
      rdclk   => csi_m1_clk,
      rdreq   => rdack_w,
      wrclk   => csi_s1_clk,
      wrreq   => wrreq_w,
      q       => rddata_w,
      rdempty => rdempty_w,
      wrfull  => wrfull_w
    );

  process (csi_m1_clk, rsi_m1_reset) begin
    if (rsi_m1_reset = '1') then
      rdbyte_r <= '0';
    elsif (rising_edge(csi_m1_clk)) then
      if (rdempty_w = '0' and avm_m1_waitrequest = '0') then
        rdbyte_r <= not rdbyte_r;
      end if;
    end if;
  end process;

  -- r = (n%64)*4  = n<5:0> & "00"   --> (5bits) n<5:1>
  -- g = (n%32)*8  = n<4:0> & "000"  --> (6bits) n<4:0> & '0'
  -- b = (n%16)*16 = n<3:0> & "0000" --> (5bits) n<3:0> & '0'
  color16_w <= rddata_w(5 downto 1) &       -- red
               rddata_w(4 downto 0) & '0' & -- green
               rddata_w(3 downto 0) & '0';  -- blue
  rdack_w <= (not rdempty_w) and rdbyte_r and (not avm_m1_waitrequest);
  avm_m1_address(31 downto 1) <= LCD_BASE(31 downto 1);
  avm_m1_address(0) <= '1';
  avm_m1_write <= (not rdempty_w);
  avm_m1_writedata <= color16_w(15 downto 8) when rdbyte_r = '0' else
                      color16_w(7 downto 0);

end architecture structure;

