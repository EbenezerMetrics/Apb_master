////////////////////////////////////////////////////////////////////
// This module contains the interface of the APB bus protocol     //
////////////////////////////////////////////////////////////////////
//import uvm_pkg::*;
//`include "uvm_macros.svh"
interface apb_interface(input PCLOCK) ; 
          logic PRESETn; 
	  logic [15:0] PADDR; 
	  logic PPROT; 
	  logic PSEL; 
	  logic PENABLE; 
	  logic PWRITE; 
	  logic [31:0] PWDATA; 
	  logic [3:0] PSTRB; 
	  logic PREADY; 
	  logic [31:0] PRDATA; 
	  logic PSLVERR; 

	  modport apb_slave ( input PRESETn, 
	                      input PADDR, 
	                      input PPROT, 
	                      input PSEL, 
	                      input PENABLE, 
	                      input PWRITE, 
	                      input PWDATA, 
	                      input PSTRB, 
	                      input PREADY, 
	                      output PRDATA, 
	                      output PSLVERR ); 
	  modport apb_master( output PRESETn, 
	                      output PADDR, 
	                      output PPROT, 
	                      output PSEL, 
	                      output PENABLE, 
	                      output PWRITE, 
	                      output PWDATA, 
	                      output PSTRB, 
	                      output PREADY, 
	                      input PRDATA, 
	                      input PSLVERR ); 
endinterface: apb_interface
