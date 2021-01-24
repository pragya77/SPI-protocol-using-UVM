class sequence1 extends uvm_sequence #(packet);
  
  packet item;
  
  `uvm_object_utils(sequence1)
  
  function new( string name = " sequence1 ");
    super.new(name);
  endfunction
  
  virtual task body();
    	
   		repeat(10) begin
        	`uvm_info(get_type_name(), "Executing sequence", UVM_LOW)
    		`uvm_do(item)
    	end
  endtask  
  
endclass  
