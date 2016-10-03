--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
--Date        : Sat Oct  1 21:23:39 2016
--Host        : andrewandrepowell2-desktop running 64-bit Ubuntu 16.04 LTS
--Command     : generate_target block_design_wrapper.bd
--Design      : block_design_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity block_design_wrapper is
  port (
    DDR2_addr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    DDR2_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR2_cas_n : out STD_LOGIC;
    DDR2_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR2_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_ras_n : out STD_LOGIC;
    DDR2_we_n : out STD_LOGIC;
    UART_rxd : in STD_LOGIC;
    UART_txd : out STD_LOGIC;
    clock_rtl : in STD_LOGIC;
    eth_ref_clk : out STD_LOGIC;
    mdio_rtl_mdc : out STD_LOGIC;
    mdio_rtl_mdio_io : inout STD_LOGIC;
    nreset_rtl : in STD_LOGIC;
    rmii_rtl_crs_dv : in STD_LOGIC;
    rmii_rtl_rx_er : in STD_LOGIC;
    rmii_rtl_rxd : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rmii_rtl_tx_en : out STD_LOGIC;
    rmii_rtl_txd : out STD_LOGIC_VECTOR ( 1 downto 0 );
    spi_0_io0_io : inout STD_LOGIC;
    spi_0_io1_io : inout STD_LOGIC;
    spi_0_io2_io : inout STD_LOGIC;
    spi_0_io3_io : inout STD_LOGIC;
    spi_0_ss_io : inout STD_LOGIC_VECTOR ( 0 to 0 );
    spi_chipselect : out STD_LOGIC;
    spi_clock : out STD_LOGIC;
    spi_data : in STD_LOGIC
  );
end block_design_wrapper;

architecture STRUCTURE of block_design_wrapper is
  component block_design is
  port (
    mdio_rtl_mdc : out STD_LOGIC;
    mdio_rtl_mdio_i : in STD_LOGIC;
    mdio_rtl_mdio_o : out STD_LOGIC;
    mdio_rtl_mdio_t : out STD_LOGIC;
    rmii_rtl_crs_dv : in STD_LOGIC;
    rmii_rtl_rx_er : in STD_LOGIC;
    rmii_rtl_rxd : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rmii_rtl_tx_en : out STD_LOGIC;
    rmii_rtl_txd : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR2_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_addr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    DDR2_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR2_ras_n : out STD_LOGIC;
    DDR2_cas_n : out STD_LOGIC;
    DDR2_we_n : out STD_LOGIC;
    DDR2_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    UART_rxd : in STD_LOGIC;
    UART_txd : out STD_LOGIC;
    SPI_0_io0_i : in STD_LOGIC;
    SPI_0_io0_o : out STD_LOGIC;
    SPI_0_io0_t : out STD_LOGIC;
    SPI_0_io1_i : in STD_LOGIC;
    SPI_0_io1_o : out STD_LOGIC;
    SPI_0_io1_t : out STD_LOGIC;
    SPI_0_io2_i : in STD_LOGIC;
    SPI_0_io2_o : out STD_LOGIC;
    SPI_0_io2_t : out STD_LOGIC;
    SPI_0_io3_i : in STD_LOGIC;
    SPI_0_io3_o : out STD_LOGIC;
    SPI_0_io3_t : out STD_LOGIC;
    SPI_0_ss_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    SPI_0_ss_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    SPI_0_ss_t : out STD_LOGIC;
    eth_ref_clk : out STD_LOGIC;
    nreset_rtl : in STD_LOGIC;
    clock_rtl : in STD_LOGIC;
    spi_data : in STD_LOGIC;
    spi_clock : out STD_LOGIC;
    spi_chipselect : out STD_LOGIC
  );
  end component block_design;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal mdio_rtl_mdio_i : STD_LOGIC;
  signal mdio_rtl_mdio_o : STD_LOGIC;
  signal mdio_rtl_mdio_t : STD_LOGIC;
  signal spi_0_io0_i : STD_LOGIC;
  signal spi_0_io0_o : STD_LOGIC;
  signal spi_0_io0_t : STD_LOGIC;
  signal spi_0_io1_i : STD_LOGIC;
  signal spi_0_io1_o : STD_LOGIC;
  signal spi_0_io1_t : STD_LOGIC;
  signal spi_0_io2_i : STD_LOGIC;
  signal spi_0_io2_o : STD_LOGIC;
  signal spi_0_io2_t : STD_LOGIC;
  signal spi_0_io3_i : STD_LOGIC;
  signal spi_0_io3_o : STD_LOGIC;
  signal spi_0_io3_t : STD_LOGIC;
  signal spi_0_ss_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal spi_0_ss_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal spi_0_ss_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal spi_0_ss_t : STD_LOGIC;
begin
block_design_i: component block_design
     port map (
      DDR2_addr(12 downto 0) => DDR2_addr(12 downto 0),
      DDR2_ba(2 downto 0) => DDR2_ba(2 downto 0),
      DDR2_cas_n => DDR2_cas_n,
      DDR2_ck_n(0) => DDR2_ck_n(0),
      DDR2_ck_p(0) => DDR2_ck_p(0),
      DDR2_cke(0) => DDR2_cke(0),
      DDR2_cs_n(0) => DDR2_cs_n(0),
      DDR2_dm(1 downto 0) => DDR2_dm(1 downto 0),
      DDR2_dq(15 downto 0) => DDR2_dq(15 downto 0),
      DDR2_dqs_n(1 downto 0) => DDR2_dqs_n(1 downto 0),
      DDR2_dqs_p(1 downto 0) => DDR2_dqs_p(1 downto 0),
      DDR2_odt(0) => DDR2_odt(0),
      DDR2_ras_n => DDR2_ras_n,
      DDR2_we_n => DDR2_we_n,
      SPI_0_io0_i => spi_0_io0_i,
      SPI_0_io0_o => spi_0_io0_o,
      SPI_0_io0_t => spi_0_io0_t,
      SPI_0_io1_i => spi_0_io1_i,
      SPI_0_io1_o => spi_0_io1_o,
      SPI_0_io1_t => spi_0_io1_t,
      SPI_0_io2_i => spi_0_io2_i,
      SPI_0_io2_o => spi_0_io2_o,
      SPI_0_io2_t => spi_0_io2_t,
      SPI_0_io3_i => spi_0_io3_i,
      SPI_0_io3_o => spi_0_io3_o,
      SPI_0_io3_t => spi_0_io3_t,
      SPI_0_ss_i(0) => spi_0_ss_i_0(0),
      SPI_0_ss_o(0) => spi_0_ss_o_0(0),
      SPI_0_ss_t => spi_0_ss_t,
      UART_rxd => UART_rxd,
      UART_txd => UART_txd,
      clock_rtl => clock_rtl,
      eth_ref_clk => eth_ref_clk,
      mdio_rtl_mdc => mdio_rtl_mdc,
      mdio_rtl_mdio_i => mdio_rtl_mdio_i,
      mdio_rtl_mdio_o => mdio_rtl_mdio_o,
      mdio_rtl_mdio_t => mdio_rtl_mdio_t,
      nreset_rtl => nreset_rtl,
      rmii_rtl_crs_dv => rmii_rtl_crs_dv,
      rmii_rtl_rx_er => rmii_rtl_rx_er,
      rmii_rtl_rxd(1 downto 0) => rmii_rtl_rxd(1 downto 0),
      rmii_rtl_tx_en => rmii_rtl_tx_en,
      rmii_rtl_txd(1 downto 0) => rmii_rtl_txd(1 downto 0),
      spi_chipselect => spi_chipselect,
      spi_clock => spi_clock,
      spi_data => spi_data
    );
mdio_rtl_mdio_iobuf: component IOBUF
     port map (
      I => mdio_rtl_mdio_o,
      IO => mdio_rtl_mdio_io,
      O => mdio_rtl_mdio_i,
      T => mdio_rtl_mdio_t
    );
spi_0_io0_iobuf: component IOBUF
     port map (
      I => spi_0_io0_o,
      IO => spi_0_io0_io,
      O => spi_0_io0_i,
      T => spi_0_io0_t
    );
spi_0_io1_iobuf: component IOBUF
     port map (
      I => spi_0_io1_o,
      IO => spi_0_io1_io,
      O => spi_0_io1_i,
      T => spi_0_io1_t
    );
spi_0_io2_iobuf: component IOBUF
     port map (
      I => spi_0_io2_o,
      IO => spi_0_io2_io,
      O => spi_0_io2_i,
      T => spi_0_io2_t
    );
spi_0_io3_iobuf: component IOBUF
     port map (
      I => spi_0_io3_o,
      IO => spi_0_io3_io,
      O => spi_0_io3_i,
      T => spi_0_io3_t
    );
spi_0_ss_iobuf_0: component IOBUF
     port map (
      I => spi_0_ss_o_0(0),
      IO => spi_0_ss_io(0),
      O => spi_0_ss_i_0(0),
      T => spi_0_ss_t
    );
end STRUCTURE;
