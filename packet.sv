 class packet extends uvm_sequence_item;

  	bit slave_rd_wr;
  	rand bit master_rd_wr;
  	bit [6:0]slave_address;
  	rand bit [6:0]master_address;
  	bit [7:0]master_in_data;
  	rand bit [7:0]master_out_data;
  	bit [7:0]slave_in_data;
  	rand bit [7:0]slave_out_data; 
  
  	`uvm_object_utils_begin(packet)
  	`uvm_field_int(slave_rd_wr, UVM_ALL_ON)
  	`uvm_field_int(master_rd_wr, UVM_ALL_ON)
  	`uvm_object_utils_end
  
  	function new(string name ="packet");
    		super.new(name);
  	endfunction
  
  	constraint rw { master_rd_wr dist { 1:= 40, 0:= 60 };}
  
endclass  
