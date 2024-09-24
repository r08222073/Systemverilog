//================================================================
//						          Lab_SV_Environment
//================================================================
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;
  
  //generator and driver instance
  generator  gen;
  driver     driv;
  monitor    mon;
  scoreboard scb;
  
  //mailbox handle's
  mailbox gen2driv;
  mailbox mon2scb;
  
  //event for synchronization between generator and test
  event gen_ended;
  
  //virtual interface
  virtual mem_intf mem_vif;
  
  //constructor
  function new(virtual mem_intf mem_vif);
    //get the interface from test
    this.mem_vif = mem_vif;
    
    //creating the mailbox 
    gen2driv = new();
    mon2scb  = new();
    
    //creating generator and driver
    gen  = new(gen2driv,gen_ended);
    driv = new(mem_vif,gen2driv);
    mon  = new(mem_vif,mon2scb);
    scb  = new(mon2scb);
  endfunction
  
  //
  task pre_test();
    driv.reset();
  endtask
  
  // forever run task 
  task test();
    fork 
    gen.main();
    driv.main();
    mon.main();
    scb.main();      
    join_none
  endtask

  //================================================================
  // Run test() till scb_counts = gen_counts
  //================================================================
  task post_test();
    wait(gen_ended.triggered);    
    wait(gen.repeat_count == driv.no_transactions);
    $display("\t gen.repeat_coun = %0d\t", gen.repeat_count);
    $display("\t driv.no_transactions = %0d\t", driv.no_transactions);  
    wait(gen.repeat_count == scb.no_transactions);
    $display("\t scb.no_transactions = %0d\t", scb.no_transactions);
    
  endtask  
  //================================================================
  //run task
  //================================================================
  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask
  
endclass


