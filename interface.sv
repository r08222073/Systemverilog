//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
interface mem_intf(input logic clk,reset);
  
  //declaring the signals

  logic [2:0] W_0, V_GS_0, V_DS_0;
  logic [2:0] W_1, V_GS_1, V_DS_1;
  logic [2:0] W_2, V_GS_2, V_DS_2;
  logic [2:0] W_3, V_GS_3, V_DS_3;
  logic [2:0] W_4, V_GS_4, V_DS_4;
  logic [2:0] W_5, V_GS_5, V_DS_5;
  logic [1:0] mode;
  logic [9:0] out_n;
  logic valid;
  
  
  //driver clocking block
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output W_0, V_GS_0, V_DS_0;
    output W_1, V_GS_1, V_DS_1;
    output W_2, V_GS_2, V_DS_2;
    output W_3, V_GS_3, V_DS_3;
    output W_4, V_GS_4, V_DS_4;
    output W_5, V_GS_5, V_DS_5;
    output mode;
    output valid;
    input  out_n;  
  endclocking
  
  //monitor clocking block
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input W_0, V_GS_0, V_DS_0;
    input W_1, V_GS_1, V_DS_1;
    input W_2, V_GS_2, V_DS_2;
    input W_3, V_GS_3, V_DS_3;
    input W_4, V_GS_4, V_DS_4;
    input W_5, V_GS_5, V_DS_5;
    input mode; 
    input out_n;  
    input valid;
  endclocking
  
  //driver modport
  modport DRIVER  (clocking driver_cb,input clk,reset);
  
  //monitor modport  
  modport MONITOR (clocking monitor_cb,input clk,reset);
  
endinterface
