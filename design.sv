
//-----------SPI TOP DUT-------------//

module top_dut(input logic mclk, input logic reset, input logic start, output logic slave_rd_wr, input logic master_rd_wr, output logic [6:0] slave_address, input logic [6:0] master_address, input logic [7:0] master_in_data,output logic [7:0] master_out_data, input logic [7:0] slave_in_data,output logic [7:0] slave_out_data);

    logic miso,mosi,cs,sclk;
               
    spi_master m(mclk,reset, start, master_rd_wr, master_address, master_in_data, master_out_data, miso, mosi, cs, sclk);
  
    spi_slave s(sclk, reset, cs, mosi, miso, slave_rd_wr, slave_address, slave_in_data, slave_out_data);
    
endmodule

//-------------SPI MASTER--------------//
module spi_master(input logic mclk, input logic reset, input logic start, input logic master_rd_wr, input logic [6:0] master_address, input logic [7:0] master_in_data, output logic [7:0] master_out_data, input logic miso, output logic mosi, output logic cs, output logic sclk);

  int count = 0; 
  logic [7:0] header;
  logic [7:0] header1;
  logic [7:0] in_data;
  
  assign sclk=mclk;
  assign header1 = {master_rd_wr, master_address[6:0]};
  assign master_in_data = in_data;
  
  always @(posedge mclk) begin
    if(!reset)
      begin
        mosi<=0;
        cs<=1;
        header <= header1;
      end
    else begin
      if(start) begin
        if(count < 16) cs<=0;
        else cs<=1;
        if(count < 8) begin
          mosi <= header[7];
          header <= header << 1;
        end  
        
        if(count >=8 && count < 16) begin
          if(master_rd_wr) begin
            in_data[0]<= miso;
          	in_data <= in_data << 1;
          end
          else begin
            mosi <= master_out_data[7];
            master_out_data <= master_out_data << 1;
          end 
        end 
        
      end
    end
      count <= count + 1;
    end
  
endmodule

          
//---------SPI SLAVE------------//

module spi_slave(input logic sclk, input logic reset, input logic cs, input logic mosi, output logic miso, output logic slave_rd_wr, output logic [6:0] slave_address, input logic [7:0]slave_in_data, output logic[7:0] slave_out_data);

  int count;
  logic [7:0]in_data;
  logic [7:0] in_header;
  assign slave_in_data = in_data;
  assign slave_rd_wr = in_header[7];
  assign slave_address[6:0] = in_header[6:0];
  
  always@(negedge sclk) begin
    if(!reset) begin
      miso<=0;
    end
    else begin
      if(!cs) begin
        if(count < 8) begin
        in_header <= mosi;
        in_header <= in_header << 1;   
        end
        end
      if(count >=8 && count < 16)begin
        if(slave_rd_wr) begin
          miso <= slave_out_data[7];
          slave_out_data <= slave_out_data << 1;
        end
        else begin
          in_data[0] <= mosi;
          in_data <= slave_in_data << 1;
        end
      end
      end
  count <= count + 1;
  end
  
endmodule
