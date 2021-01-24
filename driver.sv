class driver extends uvm_driver #(packet);

  `uvm_component_utils(driver)
  
  function new(string name ="driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  packet item;
  virtual spi_interface intf;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(! uvm_config_db #(virtual spi_interface)::get(this,"", "vif" , intf))
      	`uvm_error("NOVIF", {"virtual interface must be set for:", get_full_name(), ".vif"})
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
		  seq_item_port.get_next_item(item);
     	  // drive data to dut through interface
		  seq_item_port.item_done();
        end
  endtask
  
endclass
