//ENVIRONMENT FILE
class dff_environment;
  //virtual handle declaration
  virtual signals_intf intf;
  
  //handle creation for all classes
  dff_transaction trans;
  dff_generator gen_h;
  dff_driver drv_h;
  dff_monitor mon_h;
  dff_scoreboard scb_h;
  
  //handle for mailboxes
  mailbox drv_mbox;
  mailbox mon_mbox;
  
  //constructor block 
  function new(virtual signals_intf intf);
    this.intf = intf;
    
    drv_mbox = new();
    mon_mbox = new();
    
    trans = new();
    gen_h = new(intf,drv_mbox);
    drv_h = new(intf,drv_mbox);
    mon_h = new(intf,mon_mbox);
    scb_h = new(drv_mbox,mon_mbox,intf);
  endfunction
  
  //environment runtest logic in task
  task run_test();
    $display("At [%0t] entered into environment block..",$time);
    gen_h.intf = intf;
    drv_h.intf = intf;
    mon_h.intf = intf;
    scb_h.intf = intf;
    
    fork
        gen_h.gen();
        drv_h.drv();
        mon_h.mon();
        scb_h.compare();
    join
    $display("At [%0t] exited from environment block..",$time);
  endtask
endclass
