module EX_MEM (clk,
    EX_MemtoReg, EX_RegWrite,
    EX_Branch, EX_Jump, EX_MemWrite, EX_MemRead,
    EX_PC, EX_Jump_ins_add, EX_Zero, EX_ALU, EX_WriteData, EX_Extimm, EX_Reg_Write,
    MEM_MemtoReg,  MEM_RegWrite,
    MEM_Branch, MEM_Jump, MEM_MemWrite, MEM_MemRead,
    MEM_PC, MEM_Jump_ins_add, MEM_Zero, MEM_ALU, MEM_WriteData, MEM_Extimm, MEM_Reg_Write);
    
    input clk;

    input EX_MemtoReg;
    input EX_RegWrite;

    input EX_Branch;
    input EX_Jump;
    input EX_MemWrite;
    input EX_MemRead;

    input [31:0] EX_PC;
    input [25:0] EX_Jump_ins_add;
    input        EX_Zero;
    input [31:0] EX_ALU;
    input [31:0] EX_WriteData;
    input [31:0] EX_Extimm;
    input [4:0]  EX_Reg_Write;

    output reg MEM_MemtoReg;
    output reg MEM_RegWrite;

    output reg  MEM_Branch;
    output reg  MEM_Jump;
    output reg  MEM_MemWrite;
    output reg  MEM_MemRead;

    output reg [31:0] MEM_PC;
    output reg [25:0] MEM_Jump_ins_add;
    output reg        MEM_Zero;
    output reg [31:0] MEM_ALU;
    output reg [31:0] MEM_WriteData;
    output reg [31:0] MEM_Extimm;
    output reg [4:0]  MEM_Reg_Write;   

    always @(posedge clk) begin
        MEM_MemtoReg   <= EX_MemtoReg;
        MEM_RegWrite   <= EX_RegWrite;
        MEM_Branch     <= EX_Branch;
        MEM_Jump       <= EX_Jump;
        MEM_MemWrite   <= EX_MemWrite;
        MEM_MemRead    <= EX_MemRead;
        MEM_PC         <= EX_PC;
        MEM_Jump_ins_add <= EX_Jump_ins_add;
        MEM_Zero       <= EX_Zero;
        MEM_ALU     <= EX_ALU;
        MEM_WriteData <= EX_WriteData;
        MEM_Extimm     <= EX_Extimm;
        MEM_Reg_Write  <= EX_Reg_Write;
    end

endmodule //EX_MEM