class sequence1 extends uvm_sequence #(packet);
  
  `uvm_object_utils(sequence1)
  
  function new( string name = " sequence1 ");
    super.new(name);
  endfunction
  
  virtual task body();
  
    packet item;
    repeat(10)begin
      `uvm_info(get_type_name(), "Executing sequence", UVM_LOW)
      item=new();
      `uvm_do(item)
    end
    	
  endtask  
  
endclass  
