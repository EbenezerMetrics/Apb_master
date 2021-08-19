////////////////////////////////////////////////////////////////////////////
// This block contains the cover group class for the APB master           //
// /////////////////////////////////////////////////////////////////////////
import uvm_pkg::*; 
`include "uvm_macros.svh"

//class apb_cov extends uvm_component; 
class apb_cov extends uvm_subscriber; 
	`uvm_component_utils(apb_cov)

	virtual apb_interface apb_if; 

        covergroup apb_grp; 
	         coverpoint apb_if.PWRITE
	           { bins apb_read = {0};
	             bins apb_write = {1};	   
	           } 
        endgroup 

	function new (string name = "apb_cov",uvm_component parent);
		super.new(name,parent);
		  
		apb_grp = new(); 
        endfunction : new

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase

	 
        function connect_phase (uvm_phase phase); 
		super.connect_phase(phase);
	endfunction : connect_phase 

	task run_phase (uvm_phase phase);
		super.run_phase(phase); 

                assert(uvm_config_db#(virtual apb_interface):: get (this, "","apb_if",apb_if))
                `uvm_info("MYINFO1"," Inside coverable block",UVM_LOW);
	        forever begin 
		   @(posedge apb_if.PCLOCK); 
		   apb_grp.sample(); 
		end 


	endtask : run_phase 

endclass :apb_cov
