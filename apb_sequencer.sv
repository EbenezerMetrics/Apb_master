///////////////////////////////////
// APB sequencer                 //
// ////////////////////////////////
import uvm_pkg::*; 
`include "uvm_macros.svh"
class apb_sequencer extends uvm_sequencer #(apb_item); 

`uvm_sequencer_utils_begin(apb_sequencer)
`uvm_sequencer_utils_end

function new(string name, uvm_component parent); 
	super.new(name,parent); 
endfunction : new

virtual function void build(); 
 super.build(); 
endfunction: build 

endclass: apb_sequencer
