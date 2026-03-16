//SCOREBOARD FILE
class dff_scoreboard;
  
  //virtual handle for clk signal
  virtual signals_intf intf;
  
  //transaction file handles
  dff_transaction d_trans;
  dff_transaction m_trans;
  
  //mailbox declaration 
  mailbox drv_mbox;
  mailbox mon_mbox;
  
  //constructor block for scoreboard
  function new(mailbox drv_mbox,mailbox mon_mbox,virtual signals_intf intf);
    this.drv_mbox = drv_mbox;
    this.mon_mbox = mon_mbox;
    this.intf = intf;
  endfunction
  
  //comparison logic
  task compare();
    $display("At [%0t] entered into scoreboard block..",$time);
    repeat(20)@(posedge intf.clk or negedge intf.clk) begin
      d_trans = new();
      m_trans = new();
      
      drv_mbox.get(d_trans);
      mon_mbox.get(m_trans);
      
      if(intf.rst) begin
                if(m_trans.dout == 0) begin
                  $display("At [%0t] TEST PASSED! clk=%b rst=%b din=%b dout=%b",$time,intf.clk,intf.rst,d_trans.din,m_trans.dout);
                end
                else begin
                  $error("At [%0t] TEST FAILED! clk=%b rst=%b din=%b dout=%b",$time,intf.clk,intf.rst,d_trans.din,m_trans.dout);
                end
        end
        else begin
                if(d_trans.din == m_trans.dout) begin
                  $display("At [%0t] TEST PASSED! clk=%b rst=%b din=%b dout=%b",$time,intf.clk,intf.rst,d_trans.din,m_trans.dout);
                end
                else begin
                  $error("At [%0t] TEST FAILED! clk=%b rst=%b din=%b dout=%b",$time,intf.clk,intf.rst,d_trans.din,m_trans.dout);
                end
        end
        $display("At [%0t] ---------------------------------------------",$time);
    end
    
    $display("At [%0t] exited from scoreboard block..",$time);
  endtask
endclass
