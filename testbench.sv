// Code your testbench here
// or browse Examples

//SPI Top TB

`timescale 1ns/100ps

 import uvm_pkg::*;
`include "uvm_macros.svh"
`include "packet.sv"
`include "sequence1.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"

module top_tb;
  
  bit clk;
  bit reset;
  
  always #5 clk = ~clk;
  
  initial begin
    reset = 0;
    #5 reset =1;
  end
  
  spi_interface intf(clk,reset);
  
  top_dut dut(intf.mclk, intf.reset, intf.start, intf.slave_rd_wr, intf.master_rd_wr, intf.slave_address, intf.master_address, intf.master_in_data, intf.master_out_data, intf.slave_in_data, intf.slave_out_data );
  
   initial begin 
     uvm_config_db#(virtual spi_interface)::set(uvm_root::get(),"*","vif",intf);
    
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

  initial begin 
    run_test("test");
  end
  
endmodule
