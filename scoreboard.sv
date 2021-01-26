 class scoreboard extends uvm_scoreboard;

    	packet q[$];

  	uvm_analysis_imp #(packet, scoreboard) item_collected_export;
  
  	`uvm_component_utils(scoreboard)
  
  	function new(string name="scoreboard", uvm_component parent);
    		super.new(name, parent);
  	endfunction
	
  	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item_collected_export = new("item_collected_export", this);
	endfunction

	virtual function void write(packet item);
		q.push_back(item);
	endfunction
  
  
  	virtual task run_phase(uvm_phase phase);		
    	`uvm_info(get_type_name(), "IN RUN PHASE OF SCOREBOARD", UVM_LOW)
		forever begin
			packet item;
			wait(q.size()>0);
			item = q.pop_front();
			// compare and check here
          		if(item.master_rd_wr == item.slave_rd_wr)begin
            			`uvm_info(get_type_name(),$sformatf("-----RD_WR Match-----"), UVM_LOW)
            			`uvm_info(get_type_name(), $sformatf("Master sent RD_WR:%0h  Slave received RD_WR:%0h", item.master_rd_wr , item.slave_rd_wr), UVM_LOW)
          		end
            		else begin
              			`uvm_error(get_type_name(),$sformatf("-----RD_WR Mismatch-----")) 
            			`uvm_info(get_type_name(), $sformatf("Master sent RD_WR:%0h  Slave received RD_WR:%0h", item.master_rd_wr , item.slave_rd_wr), UVM_LOW)
            		end
            
          		if(item.master_address == item.slave_address) begin
            			`uvm_info(get_type_name(),$sformatf("-----ADDRESS Match-----"), UVM_LOW)         
            			`uvm_info(get_type_name(), $sformatf("Master sent ADDRESS:%0h  Slave received ADDRESS:%0h", item.master_address , item.slave_address), UVM_LOW)
          		end
            		else begin
              			`uvm_error(get_type_name(),$sformatf("-----ADDRESS Mismatch-----"))
              			`uvm_info(get_type_name(), $sformatf("Master sent ADDRESS:%0h  Slave received ADDRESS:%0h", item.master_address , item.slave_address), UVM_LOW)
              		end
              
          		if(item.master_in_data == item.slave_out_data)begin
            			`uvm_info(get_type_name(),$sformatf("-----MISO data Match-----"), UVM_LOW)
            			`uvm_info(get_type_name(), $sformatf("Master received MISO data:%0h  Slave sent MISO data:%0h", item.master_in_data , item.slave_out_data), UVM_LOW)
          		end
            		else begin
              			`uvm_error(get_type_name(),$sformatf("-----MISO data Mismatch-----"))
              			`uvm_info(get_type_name(), $sformatf("Master received MISO data:%0h  Slave sent MISO data:%0h", item.master_in_data , item.slave_out_data), UVM_LOW)
            		end
          
          		if(item.slave_in_data ==  item.master_out_data) begin
            			`uvm_info(get_type_name(),$sformatf("-----MOSI data Match-----"), UVM_LOW)
            			`uvm_info(get_type_name(), $sformatf("Master sent MOSI data:%0h  Slave received MOSI data:%0h", item.master_out_data , item.slave_in_data), UVM_LOW)
          		end
            		else begin
              			`uvm_error(get_type_name(),$sformatf("-----MOSI data Mismatch-----"))
              			`uvm_info(get_type_name(), $sformatf("Master sent MOSI data:%0h  Slave received MOSI data:%0h", item.master_out_data , item.slave_in_data), UVM_LOW)
            		end
            
		end
	endtask

 endclass
