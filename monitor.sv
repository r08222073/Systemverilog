//================================================================
//						          SV_Lab_Monitor
//================================================================

`define MON_IF mem_vif.MONITOR.monitor_cb
class monitor;
  
  //creating virtual interface handle
  virtual mem_intf mem_vif;

  //================================================================
  //create coverage group and define coverpoints
  //================================================================
  coverage cg_monitor;
    W_0:coverpoint `MON_IF.W_0{ignore_bins ignore_1 = {0};}
    V_GS_0:coverpoint `MON_IF.V_GS_0{ignore_bins ignore_1 = {0};}
    V_DS_0:coverpoint `MON_IF.V_DS_0{ignore_bins ignore_1 = {0};}
    W_1:coverpoint `MON_IF.W_1{ignore_bins ignore_1 = {0};}
    V_GS_1:coverpoint `MON_IF.V_GS_1{ignore_bins ignore_1 = {0};}
    V_DS_1:coverpoint `MON_IF.V_DS_1{ignore_bins ignore_1 = {0};}
    W_2:coverpoint `MON_IF.W_2{ignore_bins ignore_1 = {0};}
    V_GS_2:coverpoint `MON_IF.V_GS_2{ignore_bins ignore_1 = {0};}
    V_DS_2:coverpoint `MON_IF.V_DS_2{ignore_bins ignore_1 = {0};}
    W_3:coverpoint `MON_IF.W_3{ignore_bins ignore_1 = {0};}
    V_GS_3:coverpoint `MON_IF.V_GS_3{ignore_bins ignore_1 = {0};}
    V_DS_3:coverpoint `MON_IF.V_DS_3{ignore_bins ignore_1 = {0};}
    W_4:coverpoint `MON_IF.W_4{ignore_bins ignore_1 = {0};}
    V_GS_4:coverpoint `MON_IF.V_GS_4{ignore_bins ignore_1 = {0};}
    V_DS_4:coverpoint `MON_IF.V_DS_4{ignore_bins ignore_1 = {0};}
    W_5:coverpoint `MON_IF.W_5{ignore_bins ignore_1 = {0};}
    V_GS_5:coverpoint `MON_IF.V_GS_5{ignore_bins ignore_1 = {0};}
    V_DS_5:coverpoint `MON_IF.V_DS_5{ignore_bins ignore_1 = {0};}
    CVP_mode:coverpoint `MON_IF.mode;
    cross W_0,V_GS_0,V_DS_0,W_1,V_GS_1,V_DS_1,W_2,V_GS_2,V_DS_2,W_3,V_GS_3,V_DS_3,W_4,V_GS_4,V_DS_4,W_5,V_GS_5,V_DS_5,CVP_mode;
  endgroup


  //creating mailbox handle
  mailbox mon2scb;
  
  //constructor
  function new(virtual mem_intf mem_vif,mailbox mon2scb);
    //getting the interface
    this.mem_vif = mem_vif;
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
    //construct coverage group
    cg_monitor = new();

  endfunction
  

  //Samples the interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      transaction trans;
      trans = new();

      @(posedge mem_vif.MONITOR.clk);
          wait(`MON_IF.Enable);
          trans.W_0 = `MON_IF.W_0;
          trans.V_GS_0 = `MON_IF.V_GS_0;
          trans.V_DS_0 = `MON_IF.V_DS_0 ;
          trans.W_1 = `MON_IF.W_1;
          trans.V_GS_1 = `MON_IF.V_GS_1;
          trans.V_DS_1 = `MON_IF.V_DS_1;
          trans.W_2 = `MON_IF.W_2;
          trans.V_GS_2 = `MON_IF.V_GS_2;
          trans.V_DS_2 = `MON_IF.V_DS_2;
          trans.W_3 = `MON_IF.W_3;
          trans.V_GS_3 = `MON_IF.V_GS_3;
          trans.V_DS_3 = `MON_IF.V_DS_3;
          trans.W_4 = `MON_IF.W_4;
          trans.V_GS_4 = `MON_IF.V_GS_4;
          trans.V_DS_4 = `MON_IF.V_DS_4;
          trans.W_5 = `MON_IF.W_5;
          trans.V_GS_5 = `MON_IF.V_GS_5;
          trans.V_DS_5 = `MON_IF.V_DS_5;
          trans.mode = `MON_IF.mode;
          trans.out_n = `MON_IF.out_n;
          // $display("\t -------------Monitor_signal------------");
          // $display("\t SB_W_VGS_VDS_0 = %0d\t, %0d\t, %0d",trans.W_0,trans.V_GS_0,trans.V_DS_0);  
          
          // Sample coverage points
      		cg_monitor.sample();
          //put transaction to mailbox for scoreboard
          mon2scb.put(trans);          
          //================================================================
          // assertion to check monitor signal inside the spec        
          //================================================================  
          assert (trans.W_0 >= 1 && trans.W_0 <= 7) else $fatal("Error: trans.W_0 out of range");
          assert (trans.V_GS_0 >= 1 && trans.V_GS_0 <= 7) else $fatal("Error: trans.V_GS_0 out of range");
          assert (trans.V_DS_0 >= 1 && trans.V_DS_0 <= 7) else $fatal("Error: trans.V_DS_0 out of range");
          assert (trans.W_1 >= 1 && trans.W_1 <= 7) else $fatal("Error: trans.W_1 out of range");
          assert (trans.V_GS_1 >= 1 && trans.V_GS_1 <= 7) else $fatal("Error: trans.V_GS_1 out of range");
          assert (trans.V_DS_1 >= 1 && trans.V_DS_1 <= 7) else $fatal("Error: trans.V_DS_1 out of range");
          assert (trans.W_2 >= 1 && trans.W_2 <= 7) else $fatal("Error: trans.W_2 out of range");
          assert (trans.V_GS_2 >= 1 && trans.V_GS_2 <= 7) else $fatal("Error: trans.V_GS_2 out of range");
          assert (trans.V_DS_2 >= 1 && trans.V_DS_2 <= 7) else $fatal("Error: trans.V_DS_2 out of range");
          assert (trans.W_3 >= 1 && trans.W_3 <= 7) else $fatal("Error: trans.W_3 out of range");
          assert (trans.V_GS_3 >= 1 && trans.V_GS_3 <= 7) else $fatal("Error: trans.V_GS_3 out of range");
          assert (trans.V_DS_3 >= 1 && trans.V_DS_3 <= 7) else $fatal("Error: trans.V_DS_3 out of range");
          assert (trans.W_4 >= 1 && trans.W_4 <= 7) else $fatal("Error: trans.W_4 out of range");
          assert (trans.V_GS_4 >= 1 && trans.V_GS_4 <= 7) else $fatal("Error: trans.V_GS_4 out of range");
          assert (trans.V_DS_4 >= 1 && trans.V_DS_4 <= 7) else $fatal("Error: trans.V_DS_4 out of range");
          assert (trans.W_5 >= 1 && trans.W_5 <= 7) else $fatal("Error: trans.W_5 out of range");
          assert (trans.V_GS_5 >= 1 && trans.V_GS_5 <= 7) else $fatal("Error: trans.V_GS_5 out of range");
          assert (trans.V_DS_5 >= 1 && trans.V_DS_5 <= 7) else $fatal("Error: trans.V_DS_5 out of range");
      end
  endtask

   
	

  
endclass