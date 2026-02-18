//DESIGN CODE FOR HALF-ADDER

//module declaration
module half_adder(
//ports declaration
  input clk,
  input rst,
  input in1,
  input in2,
  output reg sum,
  output reg carry
);
  //logic with respect og clock
  always@(posedge clk or negedge clk)begin
    if(rst)begin
      sum <= 0;
      carry <= 0;
    end
    else begin
      sum <= (in1 ^ in2);
      carry <= (in1 & in2);
    end
  end
endmodule
