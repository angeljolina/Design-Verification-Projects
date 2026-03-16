//TESTBENCH FILE

//Inclusion of all sub-file
`include "dff_interface.sv"
`include "dff_transaction.sv"
`include "dff_generator.sv"
`include "dff_driver.sv"
`include "dff_monitor.sv"
`include "dff_scoreboard.sv"
`include "dff_environment.sv"
`include "dff_test.sv"

//module declaration
module dff_tb_top();
  //clk and rst ports declaration
//  logic clk;
  //logic rst;	
  
  // interface handle
  signals_intf intf();
  
  //dff_transation file
//debug	  dff_transaction trans = new();
  
  //handle and object creation for dff_test class
  dff_test tst_h= new(intf);
  
  //Instanatiation block
  dff dff_inst(
    .clk(intf.clk),
    .rst(intf.rst),
    .din(intf.din),
    .dout(intf.dout));
  
  //Initialization block
  initial begin
    intf.clk = 0;
    intf.rst = 1;
    intf.din = 0;
  end
  
  //transaction file clk and rst
/*  initial begin
    trans.clk = 0;
    trans.rst=1;
    trans.din = 0;
  end			*/
  
  //clock generation block
initial begin
    $display("At [%0t] entered into clock block..",$time);
    forever  #5 intf.clk = ~intf.clk;
//debug		    $display("At [%0t] intf.clk=%b trans.clk=%b",$time,intf.clk,trans.clk);
   $display("At [%0t] intf.clk=%b",$time,intf.clk);
  end
  
  //reset generation block
  initial begin
    $display("At [%0t] entered into reset block..",$time);
    #15 @(posedge intf.clk) intf.rst=0;
    #25 @(posedge intf.clk) intf.rst=1;
    #45 @(posedge intf.clk) intf.rst=0;
//debug		    $display("At [%0t] trans.rst=%b intf.clk=%b",$time,trans.rst,intf.rst);
    $display("At [%0t] intf.clk=%b",$time,intf.rst);
  end
  
  //Main run test call
  initial begin
    tst_h.main_run_test();
  end
  
  //waveform generation
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule
