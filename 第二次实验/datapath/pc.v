module pc(clk, rst, NPC, PC);
    input clk; //时钟
    input rst; //复位信号，1-复位，0-无效
    input [31:0] NPC; //输入信号，即跳转地址或下一条地址
    output reg [31:0] PC; //输出信号，即指令存储器地址
    
    always @ ( posedge clk or posedge rst) begin
      //$display("pc   PC:%h NPC:%h clk:%h rst:%h",PC,NPC,clk,rst);
      if(rst == 1)//复位
          PC <= 32'h0000_3000;
      else
          PC <= NPC;
    end

endmodule //pc