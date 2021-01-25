class env extends uvm_env;
  
    
  agent i_agent;
  scoreboard i_scb;
  
  `uvm_component_utils(env)
  
  function new(string name ="env", uvm_component parent);
    super.new(name, parent);
  endfunction  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);   
    i_agent = agent::type_id::create("i_agent",this);
    i_scb = scoreboard::type_id::create("i_scb",this);
  endfunction  
  
	function void connect_phase(uvm_phase phase);
      i_agent.i_monitor.item_collected_port.connect(i_scb.item_collected_export);
	endfunction
  
endclass  
