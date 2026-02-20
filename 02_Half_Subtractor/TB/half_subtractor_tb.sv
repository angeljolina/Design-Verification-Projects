//TESTBENCH FOR HALF SUBTRACTOR

`include "clock_block.sv"
`include "reset_block.sv"
`include "stimulus_block.sv"


//module declaration 
module half_subtractor_tb_top();
  //ports declaration
  logic clk;
  logic rst;
  logic in1;
  logic in2;
  logic diff;
  logic borrow;
  
  //instantiation block
  half_subtractor half_subtractor_inst(
    .clk(clk),
    .rst(rst),
    .in1(in1),
    .in2(in2),
    .diff(diff),
    .borrow(borrow));
  
  //initialization block
  initial begin
    clk = 1'b0;
    rst = 1'b0;
    in1 = 1'b0;
    in2 = 1'b0;
  end
  
  //handle and object creation for other classes
  clock_block clk_h = new();
  reset_block rst_h = new();
  stimulus_block stimul_h = new();
  
  //fork-joining all the tasks
  initial begin
    fork
    clk_h.clk_gen(clk);
    rst_h.rst_gen(clk,rst);
    stimul_h.stimul_gen(clk,in1,in2);
    join
  end
  
  //dislay statement
  initial begin
    $monitor("At [%0t] values are clk=%b rst=%b in1=%b in2=%b diff=%b borrow=%b",$time,clk,rst,in1,in2,diff,borrow);
  end
  
  //wavefrom generation
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
endmodule

//class file block for clock generation
class clock_block;
  task clk_gen(ref logic clk);
    $display("At [%0t] entered into clock block..",$time);
    forever #5 clk=~clk;
    $display("At [%0t] exited from clock block..",$time);
  endtask
endclass

//class file block for reset generation
class reset_block;
  task rst_gen(ref logic clk,rst);
    $display("At [%0t] entered into reset block..",$time);
    #15 @(posedge clk or negedge clk) rst = ~rst;
    #25 @(posedge clk or negedge clk) rst = ~rst;
    $display("At [%0t] exited from reset block..",$time);
  endtask
endclass

//class file block for stimulus generation
class stimulus_block;
  task stimul_gen(ref logic clk,in1,in2);
    $display("At [%0t] entered into stimulus block..",$time);
    repeat(25) @(posedge clk or negedge clk) begin
      in1 = $urandom_range(0,1);
      in2 = $urandom_range(0,1);
    end
    $display("At [%0t] exited from stimulus block..",$time);
    #50 $finish;
  endtask
endclass
