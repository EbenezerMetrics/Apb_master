import uvm_pkg::*;
`include "uvm_macros.svh"
//////////////////////////////////////////////////////////////////////////////////////////
// APB sequences - 4 sequences (write_only , write read, continuous writei              //
// interleaved read and write                                                           //
// ///////////////////////////////////////////////////////////////////////////////////////
class apb_sequence extends uvm_sequence#(apb_item); 

	apb_item req; 

	function new(string name="apb_sequence"); 
		super.new(name); 
	endfunction 

	`uvm_sequence_utils(apb_sequence,apb_sequencer)

	virtual task pre_body();
	if (starting_phase != null) 
		starting_phase.raise_objection(this, {"Runnning sequence'",get_full_name(),"'"}); 
        endtask
	virtual task post_body();
	if (starting_phase != null) 
		starting_phase.drop_objection(this, {"Completed sequence'",get_full_name(),"'"}); 
        endtask
	virtual task body();
            `uvm_info ("MYINFO","Entered Seq ", UVM_LOW ); 
	    // req.print();
	  for ( int i= 0; i < 10 ; i++) begin 
            `uvm_info ("MYINFO","passing packet with write data to driver ", UVM_LOW ); 
	  `uvm_do_with (req,
		          {req.PDATA ==  32'hABAB;
		           req.PWRITE == 1'b1; 
			   req.PADDR ==  i; 
		   })
	   get_response(rsp);
	   // rsp.print();
           end 
	   for (int i= 0; i <10 ; i++) begin 
            `uvm_info ("MYINFO","passing packet2 with read data to driver ", UVM_LOW ); 
	  `uvm_do_with (req,
		          {req.PDATA ==  32'h0;
		           req.PWRITE == 1'b0; 
			   req.PADDR == i;
		   })
            `uvm_info ("MYINFO","waiting for response from Driver ", UVM_LOW ); 
	   get_response(rsp);
            `uvm_info ("MYINFO","Got response from Driver ", UVM_LOW ); 
          end 
	    //rsp.print(); 
         endtask
endclass
class apb_sequence_cont_write_read  extends uvm_sequence#(apb_item);

	apb_item req;

	function new(string name="apb_sequence_cont_write_read");
		super.new(name);
	endfunction

	`uvm_sequence_utils(apb_sequence_cont_write_read,apb_sequencer)

	virtual task pre_body();
	if (starting_phase != null)
		starting_phase.raise_objection(this, {"Runnning sequence'",get_full_name(),"'"});
        endtask
	virtual task post_body();
	if (starting_phase != null)
		starting_phase.drop_objection(this, {"Completed sequence'",get_full_name(),"'"});
        endtask
	virtual task body();
            `uvm_info ("MYINFO","Entered Seq ", UVM_LOW );
	    // req.print();
	  for ( int i= 0; i < 10 ; i++) begin
            `uvm_info ("MYINFO","passing packet with write data to driver ", UVM_LOW );
	  `uvm_do_with (req,
		          {req.PDATA ==  32'hABAB;
		           req.PWRITE == 1'b1;
			   //req.PADDR == 16'hcdcd;
			   req.PADDR == i;
		   })
	   get_response(rsp);
	    //rsp.print();
            `uvm_info ("MYINFO","passing packet2 with read data to driver ", UVM_LOW );
	  `uvm_do_with (req,
		          {req.PDATA ==  32'h0;
		           req.PWRITE == 1'b0;
			   //req.PADDR == 16'hcdcd;
			   req.PADDR == i;
		   })
            `uvm_info ("MYINFO","waiting for response from Driver ", UVM_LOW );
	   get_response(rsp);
            `uvm_info ("MYINFO","Got response from Driver ", UVM_LOW );
          end
	    //rsp.print();
         endtask
endclass

class apb_sequence_write_read_only extends uvm_sequence#(apb_item); 

	apb_item req; 

	function new(string name="apb_sequence_write_read_only"); 
		super.new(name); 
	endfunction 

	`uvm_sequence_utils(apb_sequence_write_read_only,apb_sequencer)

	virtual task pre_body();
	if (starting_phase != null) 
		starting_phase.raise_objection(this, {"Runnning sequence'",get_full_name(),"'"}); 
        endtask
	virtual task post_body();
	if (starting_phase != null) 
		starting_phase.drop_objection(this, {"Completed sequence'",get_full_name(),"'"}); 
        endtask
	virtual task body();
            `uvm_info ("MYINFO","Entered Seq ", UVM_LOW ); 
	    // req.print();
            `uvm_info ("MYINFO","passing packet with write data to driver ", UVM_LOW ); 
	  `uvm_do_with (req,
		          {req.PDATA ==  32'hABAB;
		           req.PWRITE == 1'b1; 
			   req.PADDR == 16'hcdcd;
		   })
	   get_response(rsp);
	    //rsp.print();
            `uvm_info ("MYINFO","passing packet2 with read data to driver ", UVM_LOW ); 
	  `uvm_do_with (req,
		          {req.PDATA ==  32'h0;
		           req.PWRITE == 1'b0; 
			   req.PADDR == 16'hcdcd;
		   })
            `uvm_info ("MYINFO","waiting for response from Driver ", UVM_LOW ); 
	   get_response(rsp);
            `uvm_info ("MYINFO","Got response from Driver ", UVM_LOW ); 
	    //rsp.print(); 
         endtask
endclass

			   
class apb_sequence_write_only extends uvm_sequence#(apb_item);

	apb_item req;

	function new(string name="apb_sequence_write_only");
		super.new(name);
	endfunction

	`uvm_sequence_utils(apb_sequence_write_only,apb_sequencer)

	virtual task pre_body();
	if (starting_phase != null)
		starting_phase.raise_objection(this, {"Runnning sequence'",get_full_name(),"'"});
        endtask
	virtual task post_body();
	if (starting_phase != null)
		starting_phase.drop_objection(this, {"Completed sequence'",get_full_name(),"'"});
        endtask
	virtual task body();
            `uvm_info ("MYINFO","Entered Seq ", UVM_LOW );
	    // req.print();
            `uvm_info ("MYINFO","passing packet with write data to driver ", UVM_LOW );
	  `uvm_do_with (req,
		          {req.PDATA ==  32'hABAB;
		           req.PWRITE == 1'b1;
			   req.PADDR == 16'hcdcd;
		   })
	    // req.print();
            `uvm_info ("MYINFO","waiting for response from Driver ", UVM_LOW );
	   get_response(rsp);
            `uvm_info ("MYINFO","Got response from Driver ", UVM_LOW );
	    //rsp.print();
         endtask
endclass


// sequence for continuous write and reads 
// sequence or interleave write and reads 
