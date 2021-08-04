//////////////////////////////////////////////////////////////////
// This file contains the agent file                           ///
// instantiates the driver                                      //
//              the sequeuncer                                  //
//              the scoreboard                                  //
//////////////////////////////////////////////////////////////////
import uvm_pkg::*; 
`include "uvm_macros.svh"

class apb_agent extends uvm_agent; 

	apb_sequencer sequencer;
	apb_master_driver    driver;
	apb_scoreboard Sbd; 

	`uvm_component_utils_begin(apb_agent)
	`uvm_component_utils_end

	function new(string name,uvm_component parent);
		super.new(name,parent);
	//	this.name = name;
        endfunction : new 		

	virtual function void build();
	  super.build();
	  driver = apb_master_driver::type_id::create("driver",this);
	  sequencer = apb_sequencer::type_id::create("sequencer",this); 
	  Sbd = apb_scoreboard::type_id::create("Sbd",this); 
        endfunction: build   

	virtual function void connect(); 
	   super.connect(); 
	   driver.seq_item_port.connect(sequencer.seq_item_export); 
	   driver.Drvr2Sb_port.connect(Sbd.Drvr2Sb_port);
	   driver.Rcvr2Sb_port.connect(Sbd.Rcvr2Sb_port);
	endfunction: connect 

endclass : apb_agent
