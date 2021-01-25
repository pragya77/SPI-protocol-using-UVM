class test extends uvm_test;
  
  `uvm_component_utils(test)
  
    env i_env;
  sequence1 i_seq;
  
  function new(string name ="test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    i_env = env::type_id::create("i_env", this);
    i_seq = sequence1::type_id::create("i_seq");    
  endfunction  
  
  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "IN RUN PHASE OF TEST", UVM_LOW)
    phase.raise_objection(this);
    fork 
    	begin
		    i_seq.start(i_env.i_agent.i_sequencer);         
    	end
    	begin
          #200000;
    	end
    join_any  
    phase.drop_objection(this);
    
  endtask  
  
   function void end_of_elaboration_phase (uvm_phase phase);
		uvm_top.print_topology;
   endfunction  
   
   function void check_phase(uvm_phase phase);
    	check_config_usage();
   endfunction
  
endclass  
