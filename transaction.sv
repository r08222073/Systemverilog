//================================================================
//						            SV_Lab_SMC_Transaction 
//================================================================
class transaction;
  //declaring the transaction items
  rand bit [2:0] W_0, V_GS_0, V_DS_0;
  rand bit [2:0] W_1, V_GS_1, V_DS_1;
  rand bit [2:0] W_2, V_GS_2, V_DS_2;
  rand bit [2:0] W_3, V_GS_3, V_DS_3;
  rand bit [2:0] W_4, V_GS_4, V_DS_4;
  rand bit [2:0] W_5, V_GS_5, V_DS_5;
  rand bit [1:0] mode;
       bit [9:0] out_n;
  

  //constaint, to generate W, V_GS, V_DS within spec
  constraint range {
    W_0 inside {[1:7]};
    V_GS_0 inside {[1:7]};
    V_DS_0 inside {[1:7]};
    W_1 inside {[1:7]};
    V_GS_1 inside {[1:7]};
    V_DS_1 inside {[1:7]};
    W_2 inside {[1:7]};
    V_GS_2 inside {[1:7]};
    V_DS_2 inside {[1:7]};
    W_3 inside {[1:7]};
    V_GS_3 inside {[1:7]};
    V_DS_3 inside {[1:7]};
    W_4 inside {[1:7]};
    V_GS_4 inside {[1:7]};
    V_DS_4 inside {[1:7]};
    W_5 inside {[1:7]};
    V_GS_5 inside {[1:7]};
    V_DS_5 inside {[1:7]};
  }
  
  //================================================================
  //postrandomize function, displaying randomized values of items 
  //================================================================
  function void post_randomize();
    $display("--------- [Trans] post_randomize ------");
    $display("\t W_VGS_VDS_0 = %0d\t, %0d\t, %0d",W_0,V_GS_0,V_DS_0);
    $display("\t W_VGS_VDS_1 = %0d\t, %0d\t, %0d",W_1,V_GS_1,V_DS_1);
    $display("\t W_VGS_VDS_2 = %0d\t, %0d\t, %0d",W_2,V_GS_2,V_DS_2);
    $display("\t W_VGS_VDS_3 = %0d\t, %0d\t, %0d",W_3,V_GS_3,V_DS_3);
    $display("\t W_VGS_VDS_4 = %0d\t, %0d\t, %0d",W_4,V_GS_4,V_DS_4);
    $display("\t W_VGS_VDS_5 = %0d\t, %0d\t, %0d",W_5,V_GS_5,V_DS_5);
    $display("\t mode = %0d",mode);
    $display("-----------------------------------------");
  endfunction
  //================================================================
  //deep copy method
  //================================================================
  function transaction do_copy();
    transaction trans;
    trans = new();
    trans.W_0 = this.W_0;
    trans.V_GS_0 = this.V_GS_0;
    trans.V_DS_0 = this.V_DS_0;
    trans.W_1 = this.W_1;
    trans.V_GS_1 = this.V_GS_1;
    trans.V_DS_1 = this.V_DS_1;
    trans.W_2 = this.W_2;
    trans.V_GS_2 = this.V_GS_2;
    trans.V_DS_2 = this.V_DS_2;
    trans.W_3 = this.W_3;
    trans.V_GS_3 = this.V_GS_3;
    trans.V_DS_3 = this.V_DS_3;
    trans.W_4 = this.W_4;
    trans.V_GS_4 = this.V_GS_4;
    trans.V_DS_4 = this.V_DS_4;
    trans.W_5 = this.W_5;
    trans.V_GS_5 = this.V_GS_5;
    trans.V_DS_5 = this.V_DS_5;
    trans.mode = this.mode;
    trans.out_n = this.out_n;
    return trans;
  endfunction
endclass
