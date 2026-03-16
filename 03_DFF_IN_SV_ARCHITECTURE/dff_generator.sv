//GENERATOR FILE
class dff_generator;
  
  //virtual interface handle
  virtual signals_intf intf;
  
  //transaction file
  dff_transaction trans;
  
  //mailbox declaration to pass signals from generator to driver block
  mailbox drv_mbox;
  
  //constructor block
  function new(virtual signals_intf intf,mailbox drv_mbox);
    this.intf = intf;
    this.drv_mbox = drv_mbox;
  endfunction
  
  //generator task block
  task gen();
    $display("At [%0t] entered into generator block..",$time);
    repeat(20)@(posedge intf.clk or negedge intf.clk) begin
      trans = new();
      if(!trans.randomize())begin
        $error("At [%0t] randomization failed in generator..",$time);
      end
      else begin
        $display("At [%0t] generated values are clk=%b rst=%b din=%b",$time,intf.clk,intf.rst,trans.din);
        
        drv_mbox.put(trans);
        
        $display("At [%0t] successfully put values from generator to driver mailbox",$time);
        
        $display("At [%0t] send values from generator to driver are clk=%b rst=%b din=%b",$time,intf.clk,intf.rst,trans.din);
        
        $display("At [%0t] ---------------------------------------------",$time);
        
      end
    end
    $display("At [%0t] exited from generator block..",$time);
    #250 $finish;
  endtask
endclass
