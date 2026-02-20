//half subtarctor
module half_subtractor(
//ports declaration
  input clk,
  input rst,
  input in1,
  input in2,
  output reg diff,
  output reg borrow
);
  
  //logic implementation interms of clock
  always @(posedge clk or negedge clk)begin
    if(rst) begin
      diff <= 0;
      borrow <= 0;
    end
    else begin
      diff <= in1 ^ in2;
      borrow <= (~in1) & in2;
    end
  end
endmodule
