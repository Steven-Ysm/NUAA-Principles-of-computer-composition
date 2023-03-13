module registerfile(clk, rst, rs, rt, rd, regw, out1, out2, wdata);
    input clk; //时钟
    input rst; //复位
    input regw; //写入使能信号, Reg Write

    input [4:0] rs; //Read register1
    input [4:0] rt; //Read register2
    input [4:0] rd; //Write register
    input [31:0] wdata;//Write data

    output [31:0] out1; //Read data1
    output [31:0] out2; //Read data2

    reg [31:0] register[31:0];

    integer i;

    //存入寄存器
    assign out1 = (rs == 0) ? 0 : register[rs];
    assign out2 = (rt == 0) ? 0 : register[rt];

    always @(posedge clk or posedge rst) begin
      if (rst == 1)
        begin
          for(i = 0; i < 32; i = i + 1)
              register[i] <= 32'h0000_0000;
        end
      else if (regw == 1) 
        begin
          register[rd] <= wdata;
          //$display("reg:$%d<=%h",rd,wdata);
        end
      //$display("registerfile  clk:%h rst:%h rs:%h rt:%h rd:%h regw:%h out1:%h out2:%h wdata:%h", clk, rst, rs, rt, rd, regw, out1, out2, wdata);
    end //复位

endmodule