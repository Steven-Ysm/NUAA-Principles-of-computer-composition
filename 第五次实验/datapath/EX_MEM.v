module EX_MEM (clk,rst,

    EX_PC, EX_ins, Extimm, AluOut, EX_ReadData2, mux_RegDst_out,
    EX_Branch, EX_MemtoReg, EX_MemWrite, EX_RegWrite, EX_Jump,
    zero, undefine, overflow,

    MEM_PC, Jump_Addr, PC_Branch, MEM_AluOut, MEM_ReadData2, MEM_mux_RegDst_out,
    MEM_Branch, MEM_MemtoReg, MEM_MemWrite, MEM_RegWrite, MEM_Jump,
    MEM_zero, MEM_undefine, MEM_overflow );

    input clk;
    input rst;

    input [31:0] EX_PC;
    input [25:0] EX_ins; 
    input [31:0] Extimm;
    input [31:0] AluOut;       
    input [31:0] EX_ReadData2;
    input [4:0] mux_RegDst_out;

    input  EX_Branch;
    input  EX_MemtoReg;
    input  EX_MemWrite;
    input  EX_RegWrite;
    input  EX_Jump;

    input  zero;
    input  undefine;
    input  overflow;

    output reg [31:0] MEM_PC;
    output reg [25:0] Jump_Addr;
    output reg [31:0] PC_Branch;
    output reg [31:0] MEM_AluOut;
    output reg [31:0] MEM_ReadData2;
    output reg [4:0]  MEM_mux_RegDst_out;

    output reg MEM_Branch;
    output reg MEM_MemtoReg;
    output reg MEM_MemWrite;
    output reg MEM_RegWrite;
    output reg MEM_Jump;
    
    output reg MEM_zero;
    output reg MEM_undefine;
    output reg MEM_overflow;

    always  @(negedge clk) begin
        if(!rst)
            begin
                MEM_Branch  <=  EX_Branch;
                MEM_MemtoReg <= EX_MemtoReg;
                MEM_MemWrite <= EX_MemWrite;
                MEM_RegWrite <= EX_RegWrite;
                MEM_Jump <= EX_Jump;
                Jump_Addr <= EX_ins;
                PC_Branch <= (Extimm << 2) + EX_PC;
                MEM_zero <= zero;
                MEM_AluOut <= AluOut;
                MEM_ReadData2 <= EX_ReadData2;
                MEM_mux_RegDst_out <= mux_RegDst_out;
                MEM_undefine <= undefine;
                MEM_PC <= EX_PC;
                MEM_overflow <= overflow;
            end
    end
endmodule