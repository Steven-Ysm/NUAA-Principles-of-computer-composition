`include "control/ctrl.v"
`include "datapath/alu.v"
`include "datapath/dm.v"
`include "datapath/extension.v"
`include "datapath/im.v"
`include "datapath/mux.v"
`include "datapath/npc.v"
`include "datapath/pc.v"
`include "datapath/registerfile.v"
module Mips(clk, rst);
    input clk;
    input rst;

    wire [2:0] aluCtr;
    wire Branch;
    wire Jump;
    wire RegDst;
    wire AluSrc;
    wire RegWrite;
    wire MemWrite;
    wire extOp;
    wire MemtoReg;
    wire Zero;

    wire [31:0] pc_next; //下一个指令地址
    wire [31:0] pc_cur; //当前指令地址
    wire [31:0] instruction; //指令编码
    wire [31:0] ext_imm;
    wire [4:0] RegDst_mux_out; 
    wire [31:0] register_out1; //寄存器输出1
    wire [31:0] register_out2; //寄存器输出2
    wire [31:0] WriteData_reg;
    wire [31:0] AluSrc_mux_out;
    wire [31:0] alu_out;
    wire [31:0] dm_out;
    wire [31:0] MemtoReg_mux_out;

    pc pc(
        .clk(clk), 
        .rst(rst), 
        .NPC(pc_next), 
        .PC(pc_cur)
    );

    im im(
        .PC(pc_cur[11:2]), 
        .out_ins(instruction)
    );

    extension extension(
        .imm16(instruction[15:0]), 
        .extop(extOp), 
        .dout(ext_imm)
    );

    mux #(5) RegDst_mux(
        .a(instruction[20:16]), 
        .b(instruction[15:11]), 
        .ctrl_src(RegDst), 
        .dout(RegDst_mux_out)
    );
    
    registerfile registerfile(
        .clk(clk), 
        .rst(rst), 
        .rs(instruction[25:21]), 
        .rt(instruction[20:16]), 
        .rd(RegDst_mux_out), 
        .regw(RegWrite), 
        .out1(register_out1), 
        .out2(register_out2), 
        .wdata(WriteData_reg)
    );

    mux #(32) AluSrc_mux(
        .a(register_out2), 
        .b(ext_imm), 
        .ctrl_src(AluSrc), 
        .dout(AluSrc_mux_out));

    alu alu(
        .aluop(aluCtr), 
        .a(register_out1), 
        .b(AluSrc_mux_out), 
        .zero(Zero), 
        .alu_out(alu_out)
    );

    dm dm(
        .alu_out(alu_out[11:2]), 
        .din(register_out2), 
        .MemWrite(MemWrite), 
        .clk(clk), 
        .dm_out(dm_out)
    );

    mux #(32) MemtoReg_mux(
        .a(alu_out), 
        .b(dm_out), 
        .ctrl_src(MemtoReg), 
        .dout(WriteData_reg)
    );

    npc npc(
        .PC(pc_cur), 
        .Branch(Branch), 
        .Jump(Jump), 
        .Zero(Zero), 
        .ext_imm(ext_imm), 
        .imm26(instruction[25:0]), 
        .NPC(pc_next)
    );

    ctrl ctrl(
        .ins(instruction), 
        .Branch(Branch), 
        .Jump(Jump), 
        .RegDst(RegDst), 
        .RegWrite(RegWrite), 
        .ALUSrc(AluSrc), 
        .MemWrite(MemWrite), 
        .MemtoReg(MemtoReg), 
        .AluOp(aluCtr), 
        .extOp(extOp)
    );

endmodule