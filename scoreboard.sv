//================================================================
//						    SV_Lab_Scoreboard
//================================================================
//gets the packet from monitor, Generated the expected result and compares with the //actual result recived from Monitor

class scoreboard;
   
  //creating mailbox handle
  mailbox mon2scb;
  
  //used to count the number of transactions
  int no_transactions;
  

  // Define Variables
  bit [2:0] input_reg[17:0];
  bit [9:0] golden_ans;
  bit region0, region1, region2, region3, region4, region5;
  bit [9:0] ID[5:0];
  bit [5:0] gm[5:0];
  bit [9:0] tmp;
  integer a,k,i,j;

  //constructor
  function new(mailbox mon2scb);
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //SMC calculation by bubble sort
  task main;

    forever begin
        transaction trans;
        //getting the trans from  mailbox
        mon2scb.get(trans);   
        //Define Triode or Saturation region                        
        region0 = ( trans.V_GS_0 - 1 > trans.V_DS_0) ? 1 : 0 ;   // 1:triode 0:saturation
        region1 = ( trans.V_GS_1 - 1 > trans.V_DS_1) ? 1 : 0 ;
        region2 = ( trans.V_GS_2 - 1 > trans.V_DS_2) ? 1 : 0 ;
        region3 = ( trans.V_GS_3 - 1 > trans.V_DS_3) ? 1 : 0 ;
        region4 = ( trans.V_GS_4 - 1 > trans.V_DS_4) ? 1 : 0 ;
        region5 = ( trans.V_GS_5 - 1 > trans.V_DS_5) ? 1 : 0 ;
        //ID and Gm Calculation
        if( region0 == 1 ) begin
            ID[0] = trans.W_0 * trans.V_DS_0 * (2*trans.V_GS_0-2-trans.V_DS_0) / 3 ;
            gm[0] = 2 * trans.W_0 * trans.V_DS_0 / 3 ;
        end 
        else begin 
            ID[0] = trans.W_0 * (trans.V_GS_0-1) * (trans.V_GS_0-1) / 3 ;
            gm[0] = 2 * trans.W_0 * (trans.V_GS_0-1) / 3 ;
        end 
        
        if( region1 == 1 ) begin
            ID[1] = trans.W_1 * trans.V_DS_1 * (2*trans.V_GS_1-2-trans.V_DS_1) / 3 ;
            gm[1] = 2 * trans.W_1 * trans.V_DS_1 / 3 ;
        end 
        else begin 
            ID[1] = trans.W_1 * (trans.V_GS_1-1) * (trans.V_GS_1-1) / 3 ;
            gm[1] = 2 * trans.W_1 * (trans.V_GS_1-1) / 3 ;
        end 
        
        if( region2 == 1 ) begin
            ID[2] = trans.W_2 * trans.V_DS_2 * (2*trans.V_GS_2-2-trans.V_DS_2) / 3 ;
            gm[2] = 2 * trans.W_2 * trans.V_DS_2 / 3 ;
        end 
        else begin 
            ID[2] = trans.W_2 * (trans.V_GS_2-1) * (trans.V_GS_2-1) / 3 ;
            gm[2] = 2 * trans.W_2 * (trans.V_GS_2-1) / 3 ;
        end 
        
        if( region3 == 1 ) begin
            ID[3] = trans.W_3 * trans.V_DS_3 * (2*trans.V_GS_3-2-trans.V_DS_3) / 3 ;
            gm[3] = 2 * trans.W_3 * trans.V_DS_3 / 3 ;
        end 
        else begin 
            ID[3] = trans.W_3 * (trans.V_GS_3-1) * (trans.V_GS_3-1) / 3 ;
            gm[3] = 2 * trans.W_3 * (trans.V_GS_3-1) / 3 ;
        end 
        
        if( region4 == 1 ) begin
            ID[4] = trans.W_4 * trans.V_DS_4 * (2*trans.V_GS_4-2-trans.V_DS_4) / 3 ;
            gm[4] = 2 * trans.W_4 * trans.V_DS_4 / 3 ;
        end 
        else begin 
            ID[4] = trans.W_4 * (trans.V_GS_4-1) * (trans.V_GS_4-1) / 3 ;
            gm[4] = 2 * trans.W_4 * (trans.V_GS_4-1) / 3 ;
        end 
        
        if( region5 == 1 ) begin
            ID[5] = trans.W_5 * trans.V_DS_5 * (2*trans.V_GS_5-2-trans.V_DS_5) / 3 ;
            gm[5] = 2 * trans.W_5 * trans.V_DS_5 / 3 ;
        end 
        else begin 
            ID[5] = trans.W_5 * (trans.V_GS_5-1) * (trans.V_GS_5-1) / 3 ;
            gm[5] = 2 * trans.W_5 * (trans.V_GS_5-1) / 3 ;
        end 
        
        //ID by bubble sort
        if( trans.mode[0] == 1 ) begin
            for( i=0; i<6; i=i+1) begin
                for( j=0; j<6-i; j=j+1) begin 
                    if( ID[j] < ID[j+1] ) begin
                        tmp     = ID[j];
                        ID[j]   = ID[j+1];
                        ID[j+1] = tmp;
                    end    
                end
            end
        end
        //gm by bubble sort
        else begin
            for( i=0; i<6; i=i+1) begin
                for( j=0; j<6-i; j=j+1) begin 
                    if( gm[j] < gm[j+1] ) begin
                        tmp     = gm[j];
                        gm[j]   = gm[j+1];
                        gm[j+1] = tmp;
                    end    
                end
            end 
        end
        // ID Larger or smaller by mode[1]
        if( trans.mode[0] == 1 ) begin
            if( trans.mode[1] == 1) begin
                golden_ans = 3*ID[0] + 4*ID[1] + 5*ID[2];
            end
            else begin
                golden_ans = 3*ID[3] + 4*ID[4] + 5*ID[5];
            end
        end
        // gm Larger or smaller by mode[1]
        else begin
            if( trans.mode[1] == 1) begin
                golden_ans = gm[0] + gm[1] + gm[2];
            end
            else begin
                golden_ans = gm[3] + gm[4] + gm[5];
            end
        end
        // gen_golden;
        // $display("\t SB_W_VGS_VDS_0 = %0d\t, %0d\t, %0d",trans.W_0,trans.V_GS_0,trans.V_DS_0);
        // $display("\t SB_W_VGS_VDS_1 = %0d\t, %0d\t, %0d",trans.W_1,trans.V_GS_1,trans.V_DS_1);
        // $display("\t SB_W_VGS_VDS_2 = %0d\t, %0d\t, %0d",trans.W_2,trans.V_GS_2,trans.V_DS_2);
        // $display("\t SB_W_VGS_VDS_3 = %0d\t, %0d\t, %0d",trans.W_3,trans.V_GS_3,trans.V_DS_3);
        // $display("\t SB_W_VGS_VDS_4 = %0d\t, %0d\t, %0d",trans.W_4,trans.V_GS_4,trans.V_DS_4);
        // $display("\t SB_W_VGS_VDS_5 = %0d\t, %0d\t, %0d",trans.W_5,trans.V_GS_5,trans.V_DS_5);
        // $display("\t SB_mode = %0d",trans.mode);
        // $display ("            answer should be : %d , your answer is : %d           ", golden_ans, trans.out_n);
        //================================================================
        //Check DUT answer and Scoreboard answer
        //================================================================
        if(trans.out_n!==golden_ans) begin
        display_fail;
        $display ("-------------------------------------------------------------------");
        $display ("             answer should be : %d , your answer is : %d           ", golden_ans, trans.out_n);
        $display ("-------------------------------------------------------------------");
        #(100);
        $finish ;
        end
    else $display ("-------------Pass Pattern-----------");
      $display ("             answer should be : %d , your answer is : %d           ", golden_ans, trans.out_n);
      no_transactions++;
    end
  endtask

    task display_fail; begin
        $display("\n");
        $display("\n");
        $display("        --  OOPS!!  ---------------  QAQAQAQAQAQAQA");
        $display("        --  OOPS!!  ---------------  QAQAQAQAQAQAQA");
        $display("        --  OOPS!!   ---------------- QAQAQAQAQAQAQA ");
        $display("        --  \033[0;31m Simulation Failed!!\033");
        $display("        --  OOPS!!  ---------------  QAQAQAQAQAQAQA");
        $display("        --  OOPS!!  ---------------  QAQAQAQAQAQAQA");
        $display("        --  OOPS!!  ---------------  QAQAQAQAQAQAQA");
        $display("\n");
        $display("\n");
    end endtask
//   task gen_golden; begin
    
    
// end endtask

  
endclass
