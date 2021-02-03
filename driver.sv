 class driver extends uvm_driver #(packet);
  
    	packet item;
  	virtual spi_interface intf;

  	`uvm_component_utils(driver)
  
  	function new(string name ="driver", uvm_component parent);
    		super.new(name, parent);
  	endfunction
  
  	function void build_phase(uvm_phase phase);
    		super.build_phase(phase);
    
    		if(! uvm_config_db #(virtual spi_interface)::get(this,"", "vif" , intf))
      			`uvm_error("NOVIF", {"virtual interface must be set for:", get_full_name(), ".vif"})
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		wait(intf.reset == 1'b0);
    		wait(intf.reset == 1'b1);
    		`uvm_info(get_type_name(), "IN RUN PHASE OF DRIVER", UVM_LOW)
    		forever begin
		  	seq_item_port.get_next_item(item);
      
	     	  	// drive data to dut through interface

	      		intf.master_rd_wr <= item.master_rd_wr;
      			intf.master_address <= item.master_address;
      			if(item.master_rd_wr == 0) intf.master_out_data <= item.master_out_data;
      			if(item.master_rd_wr) intf.slave_out_data <= item.slave_out_data;
      			intf.start <=1;
              repeat(18) @(posedge intf.mclk);
      			intf.start <=0;
      
			seq_item_port.item_done();     	  		
        	end
  	endtask
  
 endclass
