/*
*@author: CHETAN(210281) and SAWAN H N (210952)
*@file: bubblesort_tb.v
*@ brief: this is the testbench for the bubblesort.v file
*@date: 20230416
*/

`include "bubblesort.v"
module tb;
reg clk;
wire [31:0] out;

bubble_sort uut (clk,out);

initial begin
clk = 0;
forever #10 clk = ~clk;
end

initial begin
#10
#10000 $finish;
    $dumpfile("alu.vcd");
    $dumpvars(0, tb);
end
endmodule