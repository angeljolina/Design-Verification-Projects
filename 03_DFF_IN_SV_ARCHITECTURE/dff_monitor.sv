//MONITOR FILE
class dff_monitor;
  //virtual interface handle
  virtual signals_intf intf;
  
  //transaction file handle
  dff_transaction trans;
  
  //mailbox declaration from monitor to scoreboard
  mailbox mon_mbox;
  
  //constructor block for monitor
  function new(virtual signals_intf intf,mailbox mon_mbox);
    this.intf = intf;
    this.mon_mbox = mon_mbox;
  endfunction
  
  //monitor logic task
  task mon();
    $display("At [%0t] entered into monitor block..",$time);
    repeat(20)@(posedge intf.clk or negedge intf.clk) begin
      trans = new();
      //receiving signals from DUT through interface
      trans.din = intf.din;
      trans.dout = intf.dout;
      
            $display("At [%0t] received values on monitor from dut through interface clk=%b rst=%b din=%b dout=%b",$time,intf.clk,intf.rst,trans.din,trans.dout);
      
      mon_mbox.put(trans);
      
      $display("At [%0t] successfully put values on mailbox from monitor to scoreboard",$time);
      
      $display("At [%0t] put values from monitor to scoreboard clk=%b rst=%b din=%b dout=%b",$time,intf.clk,intf.rst,trans.din,trans.dout);
      
        $display("At [%0t] ---------------------------------------------",$time);
    end
    $display("At [%0t] exited from monitor block..",$time);
  endtask
endclass
