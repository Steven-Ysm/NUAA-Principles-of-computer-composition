`include "./datapath/pc.v"
`include "./datapath/npc.v"
`include "./datapath/pc_add4.v"
`include "./datapath/im.v"
`include "./datapath/IF_ID.v"
`include "./datapath/registerfile.v"
`include "./datapath/ID_EX.v"
`include "./datapath/alu.v"
`include "./datapath/aluctrl.v"
`include "./datapath/EX_MEM.v"
`include "./datapath/dm.v"
`include "./datapath/MEM_WB.v"
`include "./datapath/ext.v"
`include "./datapath/mux.v"
`include "./datapath/forwardunit.v"
`include "./datapath/hazardunit.v"
`include "./datapath/compare.v"

module data_path (RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, 
    MemWrite, ALUSrc, RegWrite, ExtOp, clk, rst, ID_ins);
    
    input                  RegDst;
    input                  Jump;
    input                  Branch;
    input                  MemRead;
    input                  MemtoReg;
    input [2: 0] ALUOp;
    input                  MemWrite;
    input                  ALUSrc;
    input                  RegWrite;
    input                  ExtOp;

    input                  clk;
    input                  rst;

    output [31: 0]         ID_ins;

    //IF_ID
    wire    [31:0] ID_PC;
    wire    [31:0] ID_ins;

    //ID_EX
    wire           EX_MemtoReg;
    wire           EX_RegWrite;
    wire           EX_Branch;
    wire           EX_Jump;
    wire           EX_MemWrite;
    wire           EX_MemRead;
    wire           EX_RegDst;
    wire           EX_ALUSrc;
    wire           EX_ExtOp;
    wire    [2:0]  EX_ALUOp;
    wire    [31:0] EX_PC;
    wire    [25:0] EX_Jump_ins_add;
    wire    [31:0] EX_Reg_data_1_out;
    wire    [31:0] EX_Reg_data_2_out;
    wire    [15:0] EX_Extimm;
    wire    [4:0]  EX_rt;
    wire    [4:0]  EX_rd;
    wire    [4:0]  EX_rs;
    //EX_MEM
    wire           MEM_MemtoReg;
    wire           MEM_RegWrite;
    wire           MEM_Branch;
    wire           MEM_Jump;
    wire           MEM_MemWrite;
    wire           MEM_MemRead;
    wire    [31:0] MEM_PC;
    wire    [25:0] MEM_Jump_ins_add;
    wire           MEM_Zero;
    wire    [31:0] MEM_ALU;
    wire    [31:0] MEM_WriteData;
    wire    [31:0] MEM_Extimm;
    wire    [4:0]  MEM_Reg_Write;
    //MEM_WB
    wire           WB_MemtoReg;
    wire           WB_RegWrite;
    wire    [31:0] WB_Data_out;
    wire    [31:0] WB_ALU;
    wire    [4:0]  WB_Reg_Write;

    // module wire
    wire    [31: 0] PC;          
    wire    [31: 0] PC_add_4;      
    wire    [31: 0] NPC;            
    wire    [31: 0] ExtOut;         
    wire    [31: 0] Ins;    
    wire            Zero_ALU;           

    wire    [31: 0] RegfileOut1;    
    wire    [31: 0] RegfileOut2;    

    wire    [ 4: 0] mux_RegDst_out;     
    wire    [31: 0] mux_ALUSrc_out;    
    wire    [31: 0] mux_MemToReg_out;      

    wire    [3: 0] AluCtrlOut;     
    wire    [31: 0] AluOut;         
    wire    [31: 0] DmOut;          
    
    wire [1:0] ForwardA_1;
    wire [1:0] ForwardB_1;

    wire [31:0] mux_forward_out1;
    wire [31:0] mux_forward_out2;

    wire Branch_2 = Branch_1 & Branch;
    wire PCSrc = Branch_2 & Zero_Compare;
    wire PCWrite; //冒险中控制 Pc 是否更新
    wire IFflush; //冒险中控制 IF/ID 流水寄存器是否清零
    wire ctrflush;
    wire IFWrite; //冒险中控制IF/ID流水寄存器是否可以写入数据
    wire Branch_1;
    
    wire ForwardA_2;
    wire ForwardB_2;

    wire [31:0] pc_branch;
    wire [31:0] pc_jump;
    wire [31:0] pc_mux;

    wire Zero_Compare;

    pc pc(
        .clk(clk),
        .rst(rst),
        .PCWrite(PCWrite),
        .PC(PC),
        .NPC(NPC)
    );

    PC_add pc_add4(
        .PC(PC),
        .PC_add_4(PC_add_4)
    ); //pc + 4

    npc npc(
        .PC_add_4(PC_add_4), 
        .Branch(Branch),
        .Zero(Zero_Compare),
        .Jump(MEM_Jump),
        .Beq_ext_imm(MEM_Extimm),
        .Jump_ins_add(MEM_Jump_ins_add),
        .NPC(NPC)
    );

    im im(
        .PC(PC),
        .out_ins(Ins)
    );

    IF_ID IF_ID(
        .clk(clk),
        .rst(rst),

        .IF_PC(PC_add_4),
        .IF_ins(Ins),

        .IFflush(IFflush),
        .IFWrite(IFWrite),

        .ID_PC(ID_PC),
        .ID_ins(ID_ins)
    );

    register_file register_files(
        .clk(clk),
        .rst(rst),

        .rs(ID_ins[25:21]),
        .rt(ID_ins[20:16]),
        .rd(WB_Reg_Write),
        .writedata(mux_MemToReg_out),
        .RegWrite(WB_RegWrite),

        .ReadData1(RegfileOut1),
        .ReadData2(RegfileOut2)
    );



    HazardUnit hazardunit(
        .clk(clk),
        .rst(rst),
        .mux_RegDst_out(WB_Reg_Write),

        .rs(ID_ins[25:21]),
        .rt(ID_ins[20:16]),
        .EX_Reg_Write(EX_rd),

        .ID_MemRead(EX_MemRead),
        .EX_MemRead(MEM_MemRead),
        .ID_RegWrite(EX_RegWrite),
        .EX_RegWrite(MEM_RegWrite),

        .PCSrc(PCSrc),
        .Jump(Jump),
        .Branch(Branch),

        .PCWrite(PCWrite),
        .IFflush(IFflush),
        .ctrflush(ctrflush),
        .IFWrite(IFWrite),
        .Branch_1(Branch_1)
    );

    forward_unit_2 forward_unit_2(
        .clk(clk),
        .rst(rst),
        .rs(ID_ins[25:21]),
        .rt(ID_ins[20:16]),
        .EX_Reg_Write(MEM_Reg_Write),
        .EX_RegWrite(MEM_RegWrite),
        .Branch(Branch),
        .ForwardA_2(ForwardA_2),
        .ForwardB_2(ForwardB_2)
    );

    wire [31:0] comparesrc1;
    wire [31:0] comparesrc2;

    mux_beq beq_MUX_1(
        .regdata(RegfileOut1),
        .AluOut(AluOut),
        .Forward_2(ForwardA_2),
        .comparesrc(comparesrc1)
    );

    mux_beq beq_MUX_2(
        .regdata(RegfileOut2),
        .AluOut(AluOut),
        .Forward_2(ForwardB_2),
        .comparesrc(comparesrc2)
    );

    compare compare(
        .comparesrc_1(comparesrc1),
        .comparesrc_2(comparesrc2),
        .Zero(Zero_Compare)
    );

    ID_EX ID_EX(
        .clk(clk),
        .ctrflush(ctrflush),
        .ID_MemtoReg(MemtoReg),
        .ID_RegWrite(RegWrite),
        .ID_Branch(Branch),
        .ID_Jump(Jump),
        .ID_MemWrite(MemWrite),
        .ID_MemRead(MemRead),
        .ID_RegDst(RegDst),
        .ID_ALUSrc(ALUSrc),
        .ID_ExtOp(ExtOp),
        .ID_ALUOp(ALUOp),
        .ID_PC(ID_PC),
        .ID_Jump_ins_add(ID_ins[25:0]),
        .ID_ReadData1(RegfileOut1),
        .ID_ReadData2(RegfileOut2),
        .ID_Extimm(ID_ins[15:0]),
        .ID_rt(ID_ins[20:16]),
        .ID_rd(ID_ins[15:11]),
        .ID_rs(ID_ins[25:21]),

        .EX_MemtoReg(EX_MemtoReg),
        .EX_RegWrite(EX_RegWrite),
        .EX_Branch(EX_Branch),
        .EX_Jump(EX_Jump),
        .EX_MemWrite(EX_MemWrite),
        .EX_MemRead(EX_MemRead),
        .EX_RegDst(EX_RegDst),
        .EX_ALUSrc(EX_ALUSrc),
        .EX_ExtOp(EX_ExtOp),
        .EX_ALUOp(EX_ALUOp),
        .EX_PC(EX_PC),
        .EX_Jump_ins_add(EX_Jump_ins_add),
        .EX_ReadData1(EX_Reg_data_1_out),
        .EX_ReadData2(EX_Reg_data_2_out),
        .EX_Extimm(EX_Extimm),
        .EX_rt(EX_rt),
        .EX_rd(EX_rd),
        .EX_rs(EX_rs)
    );

    mux_RegDst IF_ID_MUX(
        .rt(EX_rt),
        .rd(EX_rd),
        .RegDst(EX_RegDst),
        .mux_RegDst_out(mux_RegDst_out)
    );

    ext extend_immediate(
        .ins16(ID_ins[15:0]),
        .ExtOp(ExtOp),
        .Extimm(ExtOut)
    );

    forward_unit_1 forward_unit_1(
        .clk(clk),
        .rst(rst),

        .EX_RegWrite(EX_RegWrite),
        .MEM_RegWrite(RegWrite),

        .EX_Reg_Write(MEM_Reg_Write),
        .MEM_Reg_Write(WB_Reg_Write),

        .EX_rs(ID_ins[25:21]),
        .EX_rt(ID_ins[20:16]),
        .ForwardA_1(ForwardA_1),
        .ForwardB_1(ForwardB_1)
    );

    mux_forward Forward_MUX_1(
        .forward_C(ForwardA_1),
        .alu_out(AluOut),
        .rs_rt_imm(EX_Reg_data_1_out),
        .writedata(mux_MemToReg_out),
        .mux_forward_out(mux_forward_out1)
    );

    mux_forward Forward_MUX_2(
        .forward_C(ForwardB_1),
        .alu_out(AluOut),
        .rs_rt_imm(EX_Reg_data_2_out),
        .writedata(mux_MemToReg_out),
        .mux_forward_out(mux_forward_out2)
    );

    mux_ALUSrc RF_ALU_MUX(
        .rtData(mux_forward_out2),
        .Imm(ExtOut),
        .ALUSrc(EX_ALUSrc),
        .mux_ALUSrc_out(mux_ALUSrc_out)
    );

    
    alu_ctrl ALU_controller(
        .func(ExtOut[5:0]),
        .ALUOp(EX_ALUOp),
        .AluCtrlOut(AluCtrlOut)
    );

    alu ALU(
        .rs(mux_forward_out1),
        .rt(mux_ALUSrc_out),
        .AluCtrlOut(AluCtrlOut),
        .Zero(Zero_ALU),
        .AluOut(AluOut)
    );

    EX_MEM EX_MEM(
        .clk(clk),
        .EX_MemtoReg(EX_MemtoReg),
        .EX_RegWrite(EX_RegWrite),
        .EX_Branch(EX_Branch),
        .EX_Jump(EX_Jump),
        .EX_MemWrite(EX_MemWrite),
        .EX_MemRead(EX_MemRead),
        .EX_PC(EX_PC),
        .EX_Jump_ins_add(EX_Jump_ins_add),
        .EX_Zero(Zero_ALU),
        .EX_ALU(AluOut),
        .EX_WriteData(mux_forward_out2),
        .EX_Extimm(ExtOut),
        .EX_Reg_Write(mux_RegDst_out),

        .MEM_MemtoReg(MEM_MemtoReg),
        .MEM_RegWrite(MEM_RegWrite),
        .MEM_Branch(MEM_Branch),
        .MEM_Jump(MEM_Jump),
        .MEM_MemWrite(MEM_MemWrite),
        .MEM_MemRead(MEM_MemRead),
        .MEM_PC(MEM_PC),
        .MEM_Jump_ins_add(MEM_Jump_ins_add),
        .MEM_Zero(MEM_Zero),
        .MEM_ALU(MEM_ALU),
        .MEM_WriteData(MEM_WriteData),
        .MEM_Extimm(MEM_Extimm),
        .MEM_Reg_Write(MEM_Reg_Write)
    );

    dm data_memory(
        .MEM_ALU(MEM_ALU),
        .MEM_WriteData(MEM_WriteData),
        .MemWrite(MEM_MemWrite),
        .MemRead(MEM_MemRead),
        .clk(clk),

        .dm_out(DmOut)
    );

    MEM_WB MEM_WB(
        .clk(clk),
        .MEM_MemtoReg(MEM_MemtoReg),
        .MEM_RegWrite(MEM_RegWrite),
        .MEM_Data_in(DmOut),
        .MEM_ALU(MEM_ALU),
        .MEM_Reg_Write(MEM_Reg_Write),

        .WB_MemtoReg(WB_MemtoReg),
        .WB_RegWrite(WB_RegWrite),
        .WB_Data_out(WB_Data_out),
        .WB_ALU(WB_ALU),
        .WB_Reg_Write(WB_Reg_Write)
    );

    mux_MemToReg DM_OUT_MUX(
        .DmData(WB_Data_out),
        .ALUData(WB_ALU),
        .MemtoReg(WB_MemtoReg),

        .mux_MemToReg_out(mux_MemToReg_out)
    );
endmodule //data_path
