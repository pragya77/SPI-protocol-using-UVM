class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)
  
  function new(string name="scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  packet q[$];

  uvm_analysis_imp #(packet, scoreboard) item_collected_export;
	
  function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item_collected_export = new("item_collected_export", this);
	endfunction

	virtual function void write(packet item);
		q.push_back(item);
	endfunction
  
  
  virtual task run_phase(uvm_phase phase);		
			
		forever begin
			packet item;
			wait(q.size()>0);
			item = q.pop_front();
			// compare and check here
		end
	endtask

endclass