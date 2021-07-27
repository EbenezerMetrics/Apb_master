import uvm_pkg::*;
`include "uvm_macros.svh"

class apb_master_driver extends uvm_driver#(apb_item); 

  apb_item apb_xaction; 

  virtual apb_interface apb_if; 

  uvm_analysis_port #(apb_item) Drvr2Sb_port; 
  uvm_analysis_port #(apb_item) Rcvr2Sb_port; 

  `uvm_component_utils_begin(apb_master_driver)
  `uvm_component_utils_end

  function new (string name = "apb_master_driver", uvm_component parent); 
	 super.new(name,parent); 
  endfunction :new 

  virtual function void build_phase(uvm_phase phase); 
  super.build(); 
  Drvr2Sb_port = new("Drvr2Sb", this); 
  Rcvr2Sb_port = new("Rcvr2Sb", this); 
  if (!uvm_config_db#(virtual apb_interface):: get (this, "","apb_if",apb_if))
	  `uvm_fatal ("NOVIF", {"virtual interface must be set for :",get_full_name(),".apb_if"}); 
  endfunction: build_phase 

  virtual task run_phase ( uvm_phase phase); 
         master_reset(); 
	 forever begin 
	  `uvm_info("MYINFO1","Entered Driver connection with sequencer  ",UVM_LOW); 
	    seq_item_port.get_next_item(req); 
	  `uvm_info("MYINFO1","Entered Driver got data from sequencer ",UVM_LOW); 
	    $cast(apb_xaction, req); 

	    //req.print(); 
	    if (req.PWRITE == 1'b1)
	    Drvr2Sb_port.write(req); 
	    drive_master_transfer(apb_xaction); 
	    //req.print(); 
	  `uvm_info("MYINFO1","Exited Driver master transfer ",UVM_LOW); 
	    rsp = req; 
	    //rsp.print(); 
	    if (req.PWRITE == 1'b0)
	    Rcvr2Sb_port.write(rsp); 
	  `uvm_info("MYINFO1","Got response for req",UVM_LOW); 
	    seq_item_port.item_done(rsp); 
	  `uvm_info("MYINFO1","sent response to Seq",UVM_LOW); 
	 end 
  endtask:run_phase 
			  

  task master_reset();
	  `uvm_info("MYINFO1","Entered Driver reset start",UVM_LOW); 
         @(posedge apb_if.PCLOCK);
         if (apb_if.PRESETn == 1'b0)
	 begin
           apb_if.PADDR  <= 15'b0; 
	   apb_if.PWDATA <= 32'h0;
	   apb_if.PSEL  <= 1'h0;
	   apb_if.PPROT  <= 1'h0;
	   apb_if.PENABLE <= 1'h0;
	   apb_if.PWRITE  <= 1'b1; 
	   apb_if.PSTRB  <= 4'b0; 
	 end
	  `uvm_info("MYINFO0","exiting reset ",UVM_LOW); 
  endtask: master_reset


  task drive_master_transfer(apb_item master_item); 
	  `uvm_info("MYINFO1","Entered Driver master transfer ",UVM_LOW); 
     if (master_item.PWRITE == 1'b1) 
     begin 
        `uvm_info("MYINFO0","within write cycle ",UVM_LOW); 
       @(apb_if.PCLOCK); 
       @(apb_if.PCLOCK); 
	  `uvm_info("MYINFO1","within write cycle ",UVM_LOW); 
       apb_if.PSEL <= 1'b1;
       apb_if.PPROT  <= 1'h0;
       apb_if.PENABLE <= 1'b1;
       apb_if.PWRITE <= 1'b1; 
       apb_if.PSTRB <= 4'b1111;
       apb_if.PADDR <= master_item.PADDR;
       apb_if.PWDATA <= master_item.PDATA; 
       @(apb_if.PCLOCK); 
       @(apb_if.PCLOCK); 
     end  
     else if (master_item.PWRITE == 1'b0)
     begin 
        `uvm_info("MYINFO0","within read cycle ",UVM_LOW); 
        @(apb_if.PCLOCK); 
	  `uvm_info("MYINFO1","within read cycle ",UVM_LOW); 
       apb_if.PSEL <= 1'b1;
       apb_if.PPROT  <= 1'h0;
       apb_if.PENABLE <= 1'b1;
       apb_if.PWRITE <= 1'b0; 
       apb_if.PSTRB <= 4'b1111;
       apb_if.PADDR <= master_item.PADDR;
       @(apb_if.PCLOCK); 
       @(apb_if.PCLOCK); 
       master_item.PDATA = apb_if.PRDATA ;  
     end 	
  endtask

  endclass : apb_master_driver
