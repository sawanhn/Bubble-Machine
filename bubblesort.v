/*
*@author: CHETAN(210281) and SAWAN H N (210952)
*@file: bubblesort.v
*@ brief: this is the verilog code for executing bubble sort where the code for bubble sort is stored in the form 
*         of instructions in memory
*@date: 20230416
*/

module add(input [31:0]a,b, output [31:0] c);
assign c = a + b;
endmodule

module sub(input [31:0]a,b, output [31:0] c);
assign c = a - b;
endmodule

module andp(input [31:0]a,b, output [31:0] c);
assign c = a & b;
endmodule

module orp(input [31:0]a,b, output [31:0] c);
assign c = a | b;
endmodule

module sll(input [31:0]a, input [4:0]b, output [31:0]c);
assign c = a >> b;
endmodule

module srl(input [31:0]a, input [4:0]b, output [31:0]c);
assign c = a << b;
endmodule

module bubble_sort(input clk, output reg [31:0] out);

// all the necessary and required variables are declared here
reg [9:0] pc;
reg [5:0] op;
reg [5:0] fun;
reg [4:0] source_register;
reg [4:0] destination_register;
reg [4:0] rt;
reg [15:0] constant;
reg [4:0] shift_amount;
reg [25:0] jump_address;
integer i;
reg [31:0] present_instruction;
wire [31:0] sum_result;
wire [31:0] subtraction_result;
wire [31:0] and_result;
wire [31:0] or_result;
wire [31:0] shift_left_logical_result;
wire [31:0] shift_right_logical_result;
reg [31:0]register_memory [31:0];
reg [31:0] instruction_veda_memory [256:0];
reg [31:0] data_veda_memory [1023:0]


// this is used to implement these functions whose modules are present outside this bubble_sort module
add a1(register_memory[source_register],register_memory[rt],sum_result);
sub a2(register_memory[source_register],register_memory[rt],subtraction_result);
andp a3(register_memory[source_register],register_memory[rt],and_result);
orp a4(register_memory[source_register],register_memory[rt],or_result);
sll a5(register_memory[rt],shift_amount,shift_left_logical_result);
srl a6(register_memory[rt],shift_amount,shift_right_logical_result);

initial begin
    data_veda_memory[0] = 32'd1000; 
    data_veda_memory[1] = 32'd800; 
    data_veda_memory[2] = 32'd23; 
    data_veda_memory[3] = 32'd384;
    data_veda_memory[4] = 32'd342;
    data_veda_memory[5] = 32'd234;
    data_veda_memory[6] = 32'd0;
    data_veda_memory[7] = 32'd65;
    data_veda_memory[8] = 32'd9;
    data_veda_memory[9] = 32'd290;

    instruction_veda_memory[0] = {6'b000000,5'd0,5'd0,5'd1,5'd0,6'b100000};//s0=0
    instruction_veda_memory[1] = {6'b000000,5'd0,5'd0,5'd2,5'd0,6'b100000};//s1=0
    instruction_veda_memory[2] = {6'b000000,5'd0,5'd0,5'd7,5'd0,6'b100000};
    instruction_veda_memory[3] = {6'b001000,5'd7,5'd7,16'd9};//s6=9
    instruction_veda_memory[4] = {6'b000000,5'd2,5'd8,5'd16,5'd0,6'b100000};//add t7,s7,s1 //loop start
    instruction_veda_memory[5] = {6'b100011,5'd16,5'd9,16'd0};//lw t0,0(t7)
    instruction_veda_memory[6] = {6'b100011,5'd16,5'd10,16'd1};//lw t1,1(t7)
    instruction_veda_memory[7] = {6'b000000,5'd9,5'd10,5'd11,5'd0,6'b101010};//slt t2,t0,t1
    instruction_veda_memory[8] = {6'b000101,5'd0,5'd11,16'd21};//bne t2,zero,increment 
    instruction_veda_memory[9] = {6'b101011,5'd16,5'd10,16'd0};//sw t1,0(t7)
    instruction_veda_memory[10] = {6'b101011,5'd16,5'd9,16'd1};// sw t0,1(t7)
    instruction_veda_memory[11] = {6'b001000,5'd2,5'd2,16'd1};//increment start , addi s1,s1,1
    instruction_veda_memory[12] = {6'b000000,5'd7,5'd1,5'd6,5'd0,6'b100010};//sub s5,s6,s0
    instruction_veda_memory[13] = {6'b000101,5'd2,5'd6,16'd14};// bne s1,s5,loop
    instruction_veda_memory[14] = {6'b001000,5'd1,5'd1,16'd1};// addi s0,s0,1
    instruction_veda_memory[15] = {6'b000000,5'd0,5'd0,5'd2,5'd0,6'b100000};// reset s1=0
    instruction_veda_memory[16] = {6'b000101,5'd1,5'd7,16'd14};// bne s0,s6,loop
    instruction_veda_memory[17] = {6'b000001,26'd0};//print
end 

// here the register memory is present which consists of 32 registers each of 32 bits
initial begin
    pc = 10;
  register_memory[0] = 32'd0; //zero_register
  register_memory[1] = 32'd5; //s0
  register_memory[2] = 32'd0; //s1
  register_memory[3] = 32'd7; //s2
  register_memory[4] = 32'd0; //s3
  register_memory[5] = 32'd10;//s4
  register_memory[6] = 32'd0;//s5
  register_memory[7] = 32'd5;//s6
  register_memory[8] = 32'd0;//s7 
  register_memory[9] = 32'd0;//t0
  register_memory[10] = 32'd0;//t1
  register_memory[11] = 32'd0;//t2
  register_memory[12] = 32'd0;//t3
  register_memory[13] = 32'd0;//t4
  register_memory[14] = 32'd0;//t5
  register_memory[15] = 32'd0;//t6
  register_memory[16] = 32'd0;//t7
  register_memory[17] = 32'd0;
  register_memory[18] = 32'd0;
  register_memory[19] = 32'd0;
  register_memory[20] = 32'd0;
end

// all the implementations are done here
always @(posedge clk) begin
    present_instruction = instruction_veda_memory[pc];
    op =  present_instruction[31:26];
    fun = present_instruction[5:0];
    source_register = present_instruction[25:21];
    rt = present_instruction[20:16];
    destination_register = present_instruction[15:11];
    constant =  present_instruction[15:0];
    shift_amount = present_instruction[10:6];
    jump_address = present_instruction[25:0];

    case(op)
        6'b000000: case(fun)
        6'b100000: begin register_memory[destination_register] = sum_result;out = sum_result;pc = pc + 1; end
        6'b100010: begin register_memory[destination_register] = subtraction_result;out = subtraction_result;pc = pc + 1; end
        6'b100001: begin register_memory[destination_register] = sum_result; pc = pc + 1; end                   
        6'b100011: begin register_memory[destination_register] = subtraction_result; pc = pc + 1; end                           
        6'b100100: begin register_memory[destination_register] = and_result; pc = pc + 1; out = and_result; end
        6'b100101: begin register_memory[destination_register] = or_result; pc = pc + 1; end
        6'b000000: begin register_memory[destination_register] = shift_left_logical_result; pc = pc + 1; end                             
        6'b000010: begin register_memory[destination_register] = shift_right_logical_result; pc = pc + 1; end
        6'b001000: pc =register_memory[source_register];
        6'b101010: begin if(register_memory[source_register] <register_memory[rt]) begin
                              register_memory[destination_register] = 32'd1;
                               end
                               else begin
                              register_memory[destination_register] = 32'd0;
                               end
                               pc = pc + 1;
                   end
                   endcase
        6'b001000 :begin register_memory[rt] =register_memory[source_register] + constant[15:0]; pc = pc + 1;end
        6'b001001 :begin register_memory[rt] =register_memory[source_register] + constant[15:0]; pc = pc + 1; end 
        6'b001100 :begin register_memory[rt] =register_memory[source_register] & constant[15:0]; pc = pc + 1; end                     
        6'b001101 :begin register_memory[rt] =register_memory[source_register] | constant[15:0]; pc = pc + 1; end
        6'b100011 :begin register_memory[rt] = instruction_veda_memory[register_memory[source_register] +  constant]; out =register_memory[rt]; pc = pc + 1;end                   
        6'b101011 :begin instruction_veda_memory[register_memory[source_register] +  constant] =register_memory[rt]; pc = pc + 1; end
        6'b000100 :if(register_memory[rt] ==register_memory[source_register]) begin pc = pc + 1 + constant[5:0]; end
        6'b000101 :begin if(register_memory[rt] !=register_memory[source_register]) begin pc = constant[9:0]; end                    
                        else begin pc = pc + 1; end                         
                   end
        6'b000111 :begin if(register_memory[source_register] >register_memory[rt]) pc = pc + 1 + constant[9:0]; end
        6'b001111 : begin if(register_memory[source_register] >=register_memory[rt]) pc = pc + 1 + constant[9:0]; end
        6'b000110 :begin if(register_memory[source_register] <register_memory[rt]) pc = pc + 1 + constant[9:0]; end
        6'b011111 :begin if(register_memory[source_register] <=register_memory[rt]) pc = pc + 1 + constant[9:0]; end
        6'b000010 : pc = jump_address[9:0];
        6'b000011 : begin register_memory[5'b11111] = pc + 1; pc = jump_address[9:0]; end
        6'b001010 :begin if(register_memory[rt] < constant)register_memory[source_register] = 1;                      
                        else register_memory[source_register] = 0;
                        pc = pc + 1;                     
                   end
        6'b000001 : begin
                    $display("********Sorted Array***********");
                    $display("%d",instruction_veda_memory[0]);
                    $display("%d",instruction_veda_memory[1]);
                    $display("%d",instruction_veda_memory[2]);
                    $display("%d",instruction_veda_memory[3]);
                    $display("%d",instruction_veda_memory[4]);
                    $display("%d",instruction_veda_memory[5]);
                    $display("%d",instruction_veda_memory[6]);
                    $display("%d",instruction_veda_memory[7]);
                    $display("%d",instruction_veda_memory[8]);
                    $display("%d",instruction_veda_memory[9]);
                    $finish;
                    end
    endcase
end
endmodule





