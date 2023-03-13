module pc (clk, rst, PCWrite, PC, NPC);

    input clk;
    input rst;
    input PCWrite;

    input [31:0] NPC;
    
    output reg[31:0] PC;

    always @(posedge clk or posedge rst) 
    begin
      if(rst)
          PC <= 32'h0000_3000;
      else if(PCWrite)
          PC <= NPC;
    end

    // initial
    //     begin
    //       $display("cp");
    //     end
endmodule //pc