//////////////////////////////////////////////////////////////////////////
// The scoreboard for the APB master                                    //
//////////////////////////////////////////////////////////////////////////
import uvm_pkg::*; 
`include "uvm_macros.svh"

`uvm_analysis_imp_decl(_rcvd_pkt)
`uvm_analysis_imp_decl(_sent_pkt)

class apb_scoreboard extends uvm_scoreboard; 
	`uvm_component_utils(apb_scoreboard)

	apb_item exp_que[$]; 

	uvm_analysis_imp_rcvd_pkt #(apb_item,apb_scoreboard) Rcvr2Sb_port; 
	uvm_analysis_imp_sent_pkt #(apb_item,apb_scoreboard) Drvr2Sb_port; 

	function new(string name, uvm_component parent); 
		super.new(name,parent); 
		Rcvr2Sb_port = new("Rcvr2Sb",this); 
                Drvr2Sb_port = new("Drvr2Sb",this); 
	endfunction : new 


        virtual function void write_rcvd_pkt(input apb_item pkt); 
	   apb_item exp_pkt; 
		    `uvm_info("MYINFO2","RECEIVED PACKET ",UVM_LOW);
	   pkt.print(); 

	   if (exp_que.size())
	   begin 
          // uvm_report_info(get_type_name(),
          // $psprintf("Scoreboard Report %s", this.sprint()), UVM_LOW);
	   exp_pkt = exp_que.pop_front(); 
		    `uvm_info("MYINFO2","EXPECTED PACKET ",UVM_LOW);
           exp_pkt.print();
	    //if (pkt.compare(exp_pkt))
             if ((pkt.PDATA == exp_pkt.PDATA) &&  pkt.PADDR == exp_pkt.PADDR)
	    begin 
		    `uvm_info("MYINFO2","PACKET MATCHED ",UVM_LOW);
	    end 
	    else 
                    `uvm_error("MYINFO2","PACKET MISMATCHED ");
            end 
           else 
		   `uvm_error("MYINFO2","NO MORE PACKETS to COMPARE");
	 endfunction : write_rcvd_pkt 


	 virtual function void write_sent_pkt(input apb_item pkt); 
	   exp_que.push_back(pkt); 
	 endfunction : write_sent_pkt


	 virtual function void report(); 
         uvm_report_info(get_type_name(),
           $psprintf("Scoreboard Report %s", this.sprint()), UVM_LOW);
         endfunction : report

endclass : apb_scoreboard


