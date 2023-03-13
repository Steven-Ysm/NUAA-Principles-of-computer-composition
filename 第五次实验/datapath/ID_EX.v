module ID_EX(clk, rst, EXflush,

    ReadData1, ReadData2, ID_PC, ID_ins, Extimm, 
    RegDst, Branch, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, Ext_op,

    EX_ReadData1, EX_ReadData2, EX_ins, EX_PC, EX_Extimm,
    EX_RegDst, EX_Branch, EX_MemtoReg, EX_ALUOp, EX_MemWrite, EX_ALUSrc, EX_RegWrite, EX_Jump, EX_Ext_op);

    input clk;
    input rst;
    input EXflush;

    input [31:0] ReadData1;
    input [31:0] ReadData2;
    input [31:0] ID_PC;
    input [25:0] ID_ins;
    input [31:0] Extimm;

    input RegDst;   
    input Branch;
    input MemtoReg;
    input MemWrite;
    input ALUSrc;
    input RegWrite;
    input Jump;
    input Ext_op;
    input  [2:0] ALUOp;


    output reg [31:0] EX_ReadData1;
    output reg [31:0] EX_ReadData2;
    output reg [31:0] EX_PC;
    output reg [25:0] EX_ins;
    output reg [31:0] EX_Extimm;

    output reg EX_RegDst;   
    output reg EX_Branch;
    output reg EX_MemtoReg;
    output reg EX_MemWrite;
    output reg EX_ALUSrc;
    output reg EX_RegWrite;
    output reg EX_Jump;
    output reg EX_Ext_op;
    output reg [2:0] EX_ALUOp;

    always  @(negedge clk)  begin
        if(!rst)
            begin
                
                EX_ReadData1 <= ReadData1;
                EX_ReadData2 <= ReadData2;
                EX_PC <= ID_PC;
                EX_ins <= ID_ins;
                EX_RegDst <= RegDst;   
                EX_Branch <= Branch;
                EX_MemtoReg <= MemtoReg;
                EX_ALUOp <= ALUOp;
                EX_MemWrite <= MemWrite;
                EX_ALUSrc <= ALUSrc;
                EX_RegWrite <= RegWrite;
                EX_Jump <= Jump;
                EX_Ext_op <= Ext_op;
                EX_Extimm <= Extimm;

                if(EXflush)
                    begin
                        EX_RegDst <= 0;   
                        EX_Branch <= 0;
                        EX_MemtoReg <= 0;
                        EX_ALUOp <= 3'b000;
                        EX_MemWrite <= 0;
                        EX_ALUSrc <= 0;
                        EX_RegWrite <= 0;
                        EX_Jump <= 0;
                        EX_Ext_op <= 0;
                    end
            end
    end 
    
    // initial
    //     begin
    //       $display("id_ex");
    //     end
endmodule //ID_EX