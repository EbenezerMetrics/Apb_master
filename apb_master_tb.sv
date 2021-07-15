module tbench_top; 

logic clk; 
logic rst; 

always #5 clk = ~clk; 


 apb_interface intf(clk); 
// apb_interface intf(); 

//always intf.PCLOCK = clk; 

initial begin 
	clk = 0; 
//	intf.PCLOCK = clk; 
	intf.PRESETn = 0; 
	#10 intf.PRESETn = 1; 

end 

initial begin 
	uvm_config_db#(virtual apb_interface)::set(null,"*","apb_if",intf); 
end 
             

initial begin 
	run_test(); 
end 

apb_slave UINST_mod (.clk (intf.PCLOCK),
	             .rstn (intf.PRESETn),
		     .paddr (intf.PADDR), 
		     .pprot (intf.PPROT), 
		     .psel (intf.PSEL),
		     .penable(intf.PENABLE),
		     .pwrite (intf.PWRITE), 
		     .pwdata (intf.PWDATA), 
		     .pstrb (intf.PSTRB),
		     .pready (intf.PREADY),
		     .prdata (intf.PRDATA),
		     .pslverr (intf.PSLVERR)); 

endmodule 


