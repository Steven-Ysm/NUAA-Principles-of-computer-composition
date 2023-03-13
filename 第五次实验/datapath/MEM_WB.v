module MEM_WB(clk,rst,
    MEM_MemtoReg, MEM_RegWrite, 
    dm_out, MEM_AluOut, MEM_mux_RegDst_out, MEM_PC,
    MEM_undefine, MEM_overflow,
    WB_MemtoReg, WB_RegWrite, WB_dm_out, WB_AluOut, rd);

    input clk;
    input rst;

    input MEM_MemtoReg;
    input MEM_RegWrite;

    input [31:0] dm_out;
    input [31:0] MEM_AluOut;
    input [4:0] MEM_mux_RegDst_out;
    input [31:0] MEM_PC;

    input MEM_undefine;
    input MEM_overflow;

    output reg WB_MemtoReg;
    output reg WB_RegWrite;
    output reg [31:0] WB_dm_out;
    output reg [31:0] WB_AluOut;
    output reg [4:0] rd;

    always  @(negedge clk) begin

        WB_AluOut <= MEM_AluOut;
        rd <= MEM_mux_RegDst_out;
        WB_MemtoReg <= MEM_MemtoReg;
        WB_dm_out <= dm_out;

        if(MEM_undefine == 1)
            begin
                if( (MEM_PC - 4) != 32'hfffffffc)
                begin
                    $display("undefine:%h", MEM_PC - 4);
                    WB_RegWrite <= 0;
                end
                else
                begin
                    WB_RegWrite <= 0;
                end
            end
        else if(MEM_overflow == 1)
            begin
                $display("overflow:%h", MEM_PC - 4);
                WB_RegWrite <= 0;
            end
        else
            begin
                WB_RegWrite <= MEM_RegWrite;
            end
    end
    // initial
    //     begin
    //       $display("mem_wb");
    //     end
endmodule //MEM_WB