# Half Subtractor – SystemVerilog

## Objective
Design and verification of a Half Subtractor using SystemVerilog.

## Function
Performs single-bit subtraction by randomizing its input by $urandom_range()
0,1);
Difference = in1 ^ in2  
Borrow     = ~in1 & in2  

## Verification
All input combinations tested using a class - randomisation based testbench.
