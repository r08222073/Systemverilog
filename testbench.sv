//================================================================
//				          SV_Lab_Test_top Testbench
//================================================================

//including interfcae and testcase files
`include "interface.sv"
`include "random_test.sv"
//================================================================


module tbench_top;
  
  //clock and reset signal declaration
  bit clk;
  bit reset;
  
  //clock generation
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    reset = 1;
    #5 reset =0;
  end  
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  mem_intf intf(clk,reset);
  
  //Testcase instance, interface handle is passed to test as an argument
  test t1(intf);
  
  //DUT instance, interface signals are connected to the DUT ports
  SMC DUT (
    .clk(intf.clk),
    .reset(intf.reset),
    .mode(intf.mode),
    .W_0(intf.W_0),
    .W_1(intf.W_1),
    .W_2(intf.W_2),
    .W_3(intf.W_3),
    .W_4(intf.W_4),
    .W_5(intf.W_5),
    .V_GS_0(intf.V_GS_0),
    .V_GS_1(intf.V_GS_1),
    .V_GS_2(intf.V_GS_2),
    .V_GS_3(intf.V_GS_3),
    .V_GS_4(intf.V_GS_4),
    .V_GS_5(intf.V_GS_5),
    .V_DS_0(intf.V_DS_0),
    .V_DS_1(intf.V_DS_1),
    .V_DS_2(intf.V_DS_2),
    .V_DS_3(intf.V_DS_3),
    .V_DS_4(intf.V_DS_4),
    .V_DS_5(intf.V_DS_5),
    .out_n(intf.out_n), 
    .Enable(intf.Enable)
   );
  
  //enabling the wave dump
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
  initial begin
 	$fsdbDumpfile("dump.fsdb");
	$fsdbDumpvars(0,tbench_top);
	end
endmodule
