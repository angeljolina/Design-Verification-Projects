//DFF DESIGN CODE
//module declaration
module dff(
  //ports declaration
  input clk,
  input rst,
  input din,
  output reg dout);
  
  //logic implementation interms of clock
  always@(posedge clk or negedge clk) begin
    if(rst) begin
      assign dout = 0;
    end
    else begin
      assign dout = din;
    end
  end
  
endmodule
