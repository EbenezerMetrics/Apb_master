/////////////////////////////////////////////////////////
// APB tests for the VIP 4 tests                      ///
/////////////////////////////////////////////////////////
class apb_test extends uvm_test; 

	`uvm_component_utils(apb_test)

	apb_env env; 
	apb_sequence seq; 

	function new(string name = "apb_test",uvm_component parent=null); 
		super.new(name,parent);
	endfunction : new 

	virtual function void build_phase(uvm_phase phase);
	  super.build_phase(phase); 
	  env = apb_env::type_id::create("env",this); 
	  seq = apb_sequence::type_id::create("seq"); 

	endfunction :build_phase 

	task run_phase(uvm_phase phase); 
		phase.raise_objection(this); 
	fork 
	        seq.start(env.apb_agt.sequencer); 
	        #10000;
        join_any
		phase.drop_objection(this); 
         endtask :run_phase

endclass : apb_test

class apb_cont_write_read_test extends uvm_test;

	`uvm_component_utils(apb_cont_write_read_test)

	apb_env env;
	apb_sequence_cont_write_read  seq;

	function new(string name = "apb_cont_write_read_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  env = apb_env::type_id::create("env",this);
	  seq = apb_sequence_cont_write_read::type_id::create("seq");

	endfunction :build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	fork
	        seq.start(env.apb_agt.sequencer);
	        #10000;
        join_any
		phase.drop_objection(this);
         endtask :run_phase

endclass : apb_cont_write_read_test

class apb_write_read_test extends uvm_test;

	`uvm_component_utils(apb_write_read_test)

	apb_env env;
	apb_sequence_write_read_only seq;

	function new(string name = "apb_write_read_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  env = apb_env::type_id::create("env",this);
	  seq = apb_sequence_write_read_only::type_id::create("seq");

	endfunction :build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	fork
	        seq.start(env.apb_agt.sequencer);
	        #10000;
        join_any
		phase.drop_objection(this);
         endtask :run_phase

endclass : apb_write_read_test

class apb_write_test extends uvm_test;

	`uvm_component_utils(apb_write_test)

	apb_env env;
	apb_sequence_write_only seq;

	function new(string name = "apb_write_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  env = apb_env::type_id::create("env",this);
	  seq = apb_sequence_write_only::type_id::create("seq");

	endfunction :build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	fork
	        seq.start(env.apb_agt.sequencer);
	  #1000;
        join_any
		phase.drop_objection(this);
         endtask :run_phase

endclass : apb_write_test
