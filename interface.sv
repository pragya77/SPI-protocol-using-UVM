
//SPI interface

interface spi_interface(input logic mclk,reset);
  logic start;
  logic slave_rd_wr;
  logic master_rd_wr;
  logic [6:0]slave_address;
  logic [6:0]master_address;
  logic [7:0]master_in_data;
  logic [7:0]master_out_data;
  logic [7:0]slave_in_data;
  logic [7:0]slave_out_data;  
endinterface
