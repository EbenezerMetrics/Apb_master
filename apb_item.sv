import uvm_pkg::*;
`include "uvm_macros.svh"
class apb_item extends uvm_sequence_item; 
	 rand logic [15:0] PADDR; 
	 rand logic PWRITE; 
	 rand logic [31:0] PDATA; 

	  `uvm_object_utils_begin(apb_item)
	      `uvm_field_int(PADDR, UVM_DEFAULT)
	      `uvm_field_int(PWRITE,UVM_DEFAULT)
	      `uvm_field_int(PDATA,UVM_DEFAULT)
	   `uvm_object_utils_end   

function new (string name = "apb_item");
	super.new(name);
endfunction : new 
endclass : apb_item 
