`include "./datapath/DPath.v"
`include "./control/ctrl.v"

module Mips (clk, rst);
    input   clk;
    input   rst;

    wire [31:0] Ins;
   
    wire RegDst;
    wire Jump;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [2: 0] ALUOp;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire ExtOp;

    data_path DataPath(
        .RegDst(RegDst), 
        .Jump(Jump), 
        .Branch(Branch), 
        .MemRead(MemRead),  
        .MemtoReg(MemtoReg), 
        .ALUOp(ALUOp), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite), 
        .ExtOp(ExtOp), 
        .clk(clk), 
        .rst(rst), 

        .ID_ins(Ins)
    );

    ctrl Controller(
        .Opcode(Ins[31:26]),
        
        .RegDst(RegDst),
        .Jump(Jump),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ExtOp(ExtOp)
    );

endmodule //mips