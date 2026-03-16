//DRIVER FILE
class dff_driver;
  //virtual interface handle
  virtual signals_intf intf;
  
  //transaction file handle
  dff_transaction trans;
  
  //mailbox declaration to driver from generator 
  mailbox drv_mbox;
  
  //constructor block for driver
  function new(virtual signals_intf intf,mailbox drv_mbox);
    this.intf = intf;
    this.drv_mbox = drv_mbox;
  endfunction
  
  //driver logic task
  task drv();
    $display("At [%0t] entered into driver block..",$time);
    repeat(20)@(posedge intf.clk or negedge intf.clk) begin
      trans = new();
      drv_mbox.get(trans);
      $display("At [%0t] successfully reveived values in driver from generator",$time);
      
//debug	      $display("At [%0t] received values in driver is clk=%b rst=%b din=%b",$time,trans.clk,trans.rst,trans.din);
      
      $display("At [%0t] received values in driver is clk=%b rst=%b din=%b",$time,intf.clk,intf.rst,trans.din);   
      
      //passing signals from driver to DUT through interface
      
      intf.din = trans.din;
      
      $display("At [%0t] successfully passed signals from driver to dut through interface",$time);
      $display("At [%0t] passed valued from driver to dut through interface are clk=%b rst=%b din=%b",$time,intf.clk,intf.rst,intf.din);
      
        $display("At [%0t] ---------------------------------------------",$time);
      
    end
    $display("At [%0t] exited from driver block..",$time);
  endtask
endclass
