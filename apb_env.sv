import uvm_pkg::*; 
`include "uvm_macros.svh"
class apb_env extends uvm_env; 

	apb_agent apb_agt; 
	apb_cov apb_cv; 

	`uvm_component_utils(apb_env)

	function new (string name, uvm_component parent);
		super.new(name,parent);
		apb_cv = apb_cov::type_id::create("apb_cov",this); 
	endfunction : new 

	function void build_phase(uvm_phase phase); 
		super.build_phase(phase); 

		apb_agt = apb_agent::type_id::create("mem_agt",this); 
	endfunction :build_phase 

endclass :apb_env 
