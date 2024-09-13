//================================================================
//						        SV_Lab_Driver
//================================================================
//gets the packet from generator and drive the transaction paket items into interface

`define DRIV_IF mem_vif.DRIVER.driver_cb
class driver;
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual mem_intf mem_vif;
  
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual mem_intf mem_vif,mailbox gen2driv);
    //getting the interface
    this.mem_vif = mem_vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(mem_vif.reset);
    $display("--------- [DRIVER] Reset Started ---------");
    `DRIV_IF.Enable<= 0;
    `DRIV_IF.mode <= 2'b0;
    `DRIV_IF.W_0 <= 0;
    `DRIV_IF.V_GS_0 <= 0;
    `DRIV_IF.V_DS_0 <= 0;
    `DRIV_IF.W_1 <= 0;
    `DRIV_IF.V_GS_1 <= 0;
    `DRIV_IF.V_DS_1 <= 0;
    `DRIV_IF.W_2 <= 0;
    `DRIV_IF.V_GS_2 <= 0;
    `DRIV_IF.V_DS_2 <= 0;
    `DRIV_IF.W_3 <= 0;
    `DRIV_IF.V_GS_3 <= 0;
    `DRIV_IF.V_DS_3 <= 0;
    `DRIV_IF.W_4 <= 0;
    `DRIV_IF.V_GS_4 <= 0;
    `DRIV_IF.V_DS_4 <= 0;
    `DRIV_IF.W_5 <= 0;
    `DRIV_IF.V_GS_5 <= 0;
    `DRIV_IF.V_DS_5 <= 0;
    wait(!mem_vif.reset);
    $display("--------- [DRIVER] Reset Ended ---------");
  endtask
  //================================================================
  //drivers the transaction items to interface signals
  //================================================================
  task drive;
      transaction trans;
      gen2driv.get(trans);
      $display("--------- gen2driv_get ------");
      $display("\t dr_W_VGS_VDS_0 = %0d\t, %0d\t, %0d",trans.W_0,trans.V_GS_0,trans.V_DS_0);
      $display("\t dr_W_VGS_VDS_1 = %0d\t, %0d\t, %0d",trans.W_1,trans.V_GS_1,trans.V_DS_1);
      $display("\t dr_W_VGS_VDS_2 = %0d\t, %0d\t, %0d",trans.W_2,trans.V_GS_2,trans.V_DS_2);
      $display("\t dr_W_VGS_VDS_3 = %0d\t, %0d\t, %0d",trans.W_3,trans.V_GS_3,trans.V_DS_3);
      $display("\t dr_W_VGS_VDS_4 = %0d\t, %0d\t, %0d",trans.W_4,trans.V_GS_4,trans.V_DS_4);
      $display("\t dr_W_VGS_VDS_5 = %0d\t, %0d\t, %0d",trans.W_5,trans.V_GS_5,trans.V_DS_5);
      $display("\t dr_mode = %0d",trans.mode);
      $display("-----------------------------------------");
      $display("--------- [DRIVER-TRANSFER: %0d] ---------",no_transactions);
      @(posedge mem_vif.DRIVER.clk);
        `DRIV_IF.W_0 <= trans.W_0;
        `DRIV_IF.V_GS_0 <= trans.V_GS_0;
        `DRIV_IF.V_DS_0 <= trans.V_DS_0;
        `DRIV_IF.W_1 <= trans.W_1;
        `DRIV_IF.V_GS_1 <= trans.V_GS_1;
        `DRIV_IF.V_DS_1 <= trans.V_DS_1;
        `DRIV_IF.W_2 <= trans.W_2;
        `DRIV_IF.V_GS_2 <= trans.V_GS_2;
        `DRIV_IF.V_DS_2 <= trans.V_DS_2;
        `DRIV_IF.W_3 <= trans.W_3;
        `DRIV_IF.V_GS_3 <= trans.V_GS_3;
        `DRIV_IF.V_DS_3 <= trans.V_DS_3;
        `DRIV_IF.W_4 <= trans.W_4;
        `DRIV_IF.V_GS_4 <= trans.V_GS_4;
        `DRIV_IF.V_DS_4 <= trans.V_DS_4;
        `DRIV_IF.W_5 <= trans.W_5;
        `DRIV_IF.V_GS_5 <= trans.V_GS_5;
        `DRIV_IF.V_DS_5 <= trans.V_DS_5;
        `DRIV_IF.mode <= trans.mode;
        `DRIV_IF.Enable<= 1;
        @(posedge mem_vif.DRIVER.clk);
        `DRIV_IF.Enable<= 0;
        no_transactions++;
  endtask
  
  //================================================================
  //Main task to do drive task loop
  //================================================================
  task main;
    forever begin
      fork
        //Thread-1: Waiting for reset
        begin
          wait(mem_vif.reset);
        end
        //Thread-2: Calling drive task
        begin
          forever
            drive();
        end
      join_any
      disable fork;
    end
  endtask
        
endclass
