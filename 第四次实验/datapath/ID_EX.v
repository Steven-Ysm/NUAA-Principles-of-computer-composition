module ID_EX (clk, ctrflush,
    ID_MemtoReg, ID_RegWrite,
    ID_Branch, ID_Jump, ID_MemWrite, ID_MemRead,
    ID_RegDst, ID_ALUSrc, ID_ExtOp, ID_ALUOp,
    ID_PC, ID_Jump_ins_add, ID_ReadData1, ID_ReadData2, ID_Extimm, ID_rt, ID_rd, ID_rs,
    EX_MemtoReg, EX_RegWrite,
    EX_Branch, EX_Jump, EX_MemWrite, EX_MemRead,
    EX_RegDst, EX_ALUSrc, EX_ExtOp, EX_ALUOp,
    EX_PC, EX_Jump_ins_add, EX_ReadData1, EX_ReadData2, EX_Extimm, EX_rt, EX_rd, EX_rs);

    input clk;
    input ctrflush;

    input ID_MemtoReg;
    input ID_RegWrite;

    input ID_Branch;
    input ID_Jump;
    input ID_MemWrite;
    input ID_MemRead;

    input ID_RegDst;
    input ID_ALUSrc;
    input ID_ExtOp;
    input [2:0] ID_ALUOp;

    input [31:0] ID_PC;
    input [25:0] ID_Jump_ins_add;
    input [31:0] ID_ReadData1;
    input [31:0] ID_ReadData2;
    input [15:0] ID_Extimm;
    input [4:0]  ID_rt;
    input [4:0]  ID_rd;
    input [4:0]  ID_rs;

    output reg EX_MemtoReg;
    output reg EX_RegWrite;

    output reg EX_Branch;
    output reg EX_Jump;
    output reg EX_MemWrite;
    output reg EX_MemRead;

    output reg EX_RegDst;
    output reg EX_ALUSrc;
    output reg EX_ExtOp;
    output reg [2:0] EX_ALUOp;

    output reg [31:0] EX_PC;
    output reg [25:0] EX_Jump_ins_add;
    output reg [31:0] EX_ReadData1;
    output reg [31:0] EX_ReadData2;
    output reg [15:0] EX_Extimm;
    output reg [4:0]  EX_rt;
    output reg [4:0]  EX_rd;
    output reg [4:0]  EX_rs;

    always @(posedge clk) begin
        if (ctrflush)
            begin
                EX_MemtoReg <= 1'b0;
                EX_RegWrite <= 1'b0;
                EX_MemWrite <= 1'b0;
                EX_MemRead <= 1'b0;
                EX_RegDst <= 1'b0;
                EX_ALUSrc <= 1'b0;
                EX_ALUOp <= 3'b0;
                EX_Branch <= 1'b0;
                EX_Jump <= 1'b0;
            end
        else
            begin
                EX_MemtoReg <= ID_MemtoReg;
                EX_RegWrite <= ID_RegWrite;
                EX_MemWrite <= ID_MemWrite;
                EX_MemRead <= ID_MemRead;
                EX_RegDst <= ID_RegDst;
                EX_ALUSrc <= ID_ALUSrc;
                EX_ALUOp <= ID_ALUOp;
                EX_Branch <= ID_Branch;
                EX_Jump <= ID_Jump;
            end

        EX_ExtOp <= ID_ExtOp;
        EX_PC <= ID_PC;
        EX_Jump_ins_add <= ID_Jump_ins_add;
        EX_ReadData1 <= ID_ReadData1;
        EX_ReadData2 <= ID_ReadData2;
        EX_Extimm <= ID_Extimm;
        EX_rt <= ID_rt;
        EX_rd <= ID_rd;
        EX_rs <= ID_rs;
    end

    // initial
    //     begin
    //       $display("id_ex");
    //     end

endmodule //ID_EX