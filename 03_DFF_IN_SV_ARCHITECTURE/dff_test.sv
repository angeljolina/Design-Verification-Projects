//TEST FILE
class dff_test;
  //virtual interface handle
  virtual signals_intf intf;
  
  //handle creation of environment file
  dff_environment env_h = new(intf);
  
  //constructor block for test
  function new(virtual signals_intf intf);
    this.intf = intf;
  endfunction
  
  //main run test logic
  task main_run_test();
    $display("At [%0t] entered into test block..",$time);
    env_h.intf = intf;
    env_h.run_test();
    $display("At [%0t] exited from test block..",$time);
  endtask
endclass
