 class agent extends uvm_agent;

  	driver i_driver;
  	monitor i_monitor;
  	sequencer i_sequencer;
  
  	`uvm_component_utils(agent)
  
  	function new(string name ="agent", uvm_component parent);
    		super.new(name, parent);
  	endfunction
  
  	function void build_phase(uvm_phase phase);
    		super.build_phase(phase);   
    		i_monitor = monitor::type_id::create("i_monitor",this);
    		if(get_is_active() == UVM_ACTIVE)begin
      			i_driver = driver::type_id::create("i_driver",this);
      			i_sequencer = sequencer::type_id::create("i_sequencer",this);
    		end 
  	endfunction
  
  	function void connect_phase(uvm_phase phase);
    		if(get_is_active() == UVM_ACTIVE)begin
      			i_driver.seq_item_port.connect(i_sequencer.seq_item_export);
    		end
 	endfunction
  
   	task run_phase(uvm_phase phase);
    
     		`uvm_info(get_type_name(), "IN RUN PHASE OF AGENT", UVM_LOW)
    
  	endtask
  
 endclass
