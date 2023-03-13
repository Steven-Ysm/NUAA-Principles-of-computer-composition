module pc(clk, rst, PCWrite, NPC, PC);
    input clk, rst;
    input PCWrite;

    input [31:0] NPC;
    output reg [31:0] PC;

    always @ (negedge clk)
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