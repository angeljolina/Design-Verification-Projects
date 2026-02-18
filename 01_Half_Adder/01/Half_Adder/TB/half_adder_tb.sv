//ALL SUB FILES
`include "clock_generation.sv"
`include "reset_generation.sv"
`include "sequence_generation.sv"

//module declaration
module half_adder_tb_top();
  //ports declaration
  logic clk;
  logic rst;
  logic in1;
  logic in2;
  logic sum;
  logic carry;
  
  //instantiation block
  half_adder half_adder_inst(
    .clk(clk),
    .rst(rst),
    .in1(in1),
    .in2(in2),
    .sum(sum),
    .carry(carry));
  
  //initialisation block
  initial begin
    clk = 1'b0;
    rst = 1'b0;
    in1 = 1'b0;
    in2 = 1'b0;
  end
  
  //object creation of classes
 // initial begin
  clock_generate clk_h = new();
  reset_generate rst_h = new();
  sequence_generate seq_h = new();
 // end
  
  //fork-joining the tasks
  initial begin
  fork
    clk_h.clk_gen(clk);
    rst_h.rst_gen(clk,rst);
    seq_h.seq_gen(clk,in1,in2);
  join
  end
  //display statement
  initial begin
    $monitor("At[%0t] values are clk=%b rst=%b in1=%b in2=%b sum=%b carry=%b",$time,clk,rst,in1,in2,sum,carry);
  end

  //clock generation block file code
class clock_generate;
  task clk_gen(ref logic clk);
    $display("At[%0t] Entered into clock block",$time);
    forever #5 clk = ~clk;
    $display("At[%0t] Exitef from clock block",$time);
  endtask
endclass

  //reset generation block file code
class reset_generate;
  task rst_gen(ref logic clk,rst);
     $display("At[%0t] Entered into reset block",$time);
    #10 @(posedge clk or negedge clk) rst = ~rst;
    #20 @(posedge clk or negedge clk) rst = ~rst;
    $display("At[%0t] Exit from reset block",$time);
  endtask
endclass

  //sequence generation block file code
class sequence_generate;
  task seq_gen(ref logic clk,in1,in2);
    $display("At[%0t] Entered into sequence block",$time);
    repeat(25)@(posedge clk or negedge clk)begin
      in1 = $urandom_range(0,1);
      in2 = $urandom_range(0,1);
    end
     $display("At[%0t] Exit from sequence block",$time);
    #50 $finish;
  endtask
endclass
  
  //waveform generation
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
endmodule
