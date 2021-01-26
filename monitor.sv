
 class monitor extends uvm_monitor;

	packet item;

	virtual spi_interface intf;

	`uvm_component_utils(monitor)
   
	uvm_analysis_port #(packet) item_collected_port;
   
   	function new(string name="monitor", uvm_component parent = null);
		super.new(name,parent);
		item_collected_port = new("item_collected_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
                 
	      	if (!uvm_config_db #(virtual spi_interface)::get(this, get_full_name(),"vif", intf))
      			`uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})	
	endfunction

	task run_phase(uvm_phase phase);
         
      		wait(intf.reset == 1'b0);
   	 	wait(intf.reset == 1'b1);
      		`uvm_info(get_type_name(), "IN RUN PHASE OF MONITOR", UVM_LOW)
		forever begin

			item = packet::type_id::create("item",this);
          		@(posedge intf.start);
          		repeat(20) @(posedge intf.mclk);
          		item.slave_rd_wr = intf.slave_rd_wr;
        		item.master_rd_wr = intf.master_rd_wr;
        		item.slave_address = intf.slave_address;
			item.master_address = intf.master_address;
			item.master_in_data = intf.master_in_data; 
          		item.master_out_data = intf.master_out_data;
          		item.slave_in_data = intf.slave_in_data;
          		item.slave_out_data = intf.slave_out_data;
          
	  		item_collected_port.write(item);
		end
	endtask

 endclass
