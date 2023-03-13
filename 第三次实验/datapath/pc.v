module pc (clk, rst, PC, NPC);

    input clk;
    input rst;

    input [31:0] NPC;
    
    output reg[31:0] PC;

  always @(posedge clk or posedge rst) 
  begin
    if(rst)
        PC <= 32'h0000_3000;
    else
        PC <= NPC;
  end
endmodule //pc