import uvm_pkg::*; 
`include "uvm_macros.svh"

//class uvm_subscriber #(type T=int) extends uvm_component; 
class uvm_subscriber  extends uvm_component; 
    //typedef uvm_subscriber  this_type; 

     //uvm_analysis_imp #(T, this_type) analysis_export; 
     uvm_analysis_port #(apb_item) analysis_export;

     function new (string name, uvm_component parent);
	     super.new(name, parent);
	     analysis_export = new("analysis_imp", this);
     endfunction 

     //pure virtual function void write (T,t); 

endclass 
