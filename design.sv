 `timescale 1ns/100ps 

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


//-----------SPI TOP DUT-------------//

 module top_dut(input logic mclk, input logic reset, input logic start, output logic slave_rd_wr, input logic master_rd_wr, output logic [6:0] slave_address, input logic [6:0] master_address, output logic [7:0] master_in_data,input logic [7:0] master_out_data, output logic [7:0] slave_in_data,input logic [7:0] slave_out_data);

    	logic miso,mosi,cs,sclk;
               
     	spi_master m(mclk,reset, start, master_rd_wr, master_address, master_in_data, master_out_data, miso, mosi, cs, sclk);
  
    	spi_slave s(sclk, reset, cs, mosi, miso, slave_rd_wr, slave_address, slave_in_data, slave_out_data);
    
 endmodule

//-------------SPI MASTER--------------//
 module spi_master(input logic mclk, input logic reset, input logic start, input logic master_rd_wr, input logic [6:0] master_address, output logic [7:0] master_in_data, input logic [7:0] master_out_data, input logic miso, output logic mosi, output logic cs, output logic sclk);

  	int count; 
  	logic [7:0] header = 0;
  	logic [7:0] header1;
  	logic [7:0] in_data;
  	logic [7:0] out_data;
  
  	assign sclk=mclk;
  	assign header1 = {master_rd_wr, master_address[6:0]};
  
  	always @(posedge cs)begin
    		master_in_data <=  in_data;
    		count <= 0;
  	end
  
  	always @(posedge mclk) begin
    		if(!reset)
     	 		begin
        			mosi <=0;
        			cs <=1; 
				count <= 0;    
      			end
    		else begin
			if(start)begin
      				if(count == 0)begin
					header <= header1;
					if(master_rd_wr == 0) out_data <= master_out_data;
				end

				if(count == 1) cs <= 0;
		
				if(count >= 1 && count <= 8) begin
					mosi <= header[7]; 
					header <= header << 1;
				end

          			if( count > 8 && count <=16) begin
					if(master_rd_wr == 1) begin
                  				in_data <= {in_data[6:0], miso};
					end
					else begin
						mosi <= out_data[7];
						out_data <= out_data << 1;
					end		

				end

				count <= count + 1;
        	    	end

			else begin        		
        	  		cs <= 1;
        		end 
  		end

   	end
  
 endmodule

          
 //---------SPI SLAVE------------//

 module spi_slave(input logic sclk, input logic reset, input logic cs, input logic mosi, output logic miso, output logic slave_rd_wr, output logic [6:0] slave_address, output logic [7:0]slave_in_data, input logic[7:0] slave_out_data);

  	int count_s;
  	logic [7:0]in_data;
  	logic [7:0] in_header = 0;
  	logic [7:0] out_data;
  
  	always @(posedge sclk) begin
    		//
  	end  
  
  	always@(negedge sclk) begin
    		if(!reset) begin
      			miso <= 0;
			count_s <= 0;
    		end

	    	else begin

			if(!cs)begin
				if(count_s>=0 && count_s<8)begin
              				in_header <= {in_header[6:0], mosi};
				end
         
          			if(count_s>=8 && count_s < 16)begin
            				if(in_header[7] == 1)begin
						miso <= out_data[7];
						out_data <= out_data << 1;
					end
					else begin
        		              		in_data <= {in_data[6:0], mosi};
					end
				end
          
				count_s <= count_s + 1;
			end
			else begin			
				out_data <= slave_out_data;
			end
		
		end
        
  	end
  
  	always @(posedge cs)begin
    		slave_in_data <=  in_data;
    		slave_rd_wr <=  in_header[7] ;
    		slave_address[6:0] <=  in_header[6:0] ;
    		count_s <= 0;
  	end
  
 endmodule
