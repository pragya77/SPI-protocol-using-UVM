 class sequencer extends uvm_sequencer #(packet);
  
  	packet item;
  
  	`uvm_component_utils(sequencer)
  
  	function new(string name ="sequencer", uvm_component parent = null);
    		super.new(name, parent);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    
    		`uvm_info(get_type_name(), "IN RUN PHASE OF SEQUENCER", UVM_LOW)
    	endtask
  
 endclass
