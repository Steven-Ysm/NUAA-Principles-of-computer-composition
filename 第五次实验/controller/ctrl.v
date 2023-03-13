`define SIGNAL {RegDst, Branch, MemtoReg, ALUSrc, ALUOp, MemWrite, RegWrite, Jump, Ext_op}

module ctrl(Opcode, RegDst, Branch, MemtoReg, ALUOp, 
    MemWrite, ALUSrc, RegWrite, Jump, Ext_op);

    input [31:26] Opcode;

    output reg RegDst;   
    output reg Branch;
    output reg MemtoReg;
    output reg MemWrite;
    output reg ALUSrc;
    output reg RegWrite;
    output reg Jump;
    output reg Ext_op;

    output reg [2:0] ALUOp;

    parameter T = 1'b1;
    parameter F = 1'b0;

    always @(*) begin
        `SIGNAL = {F, F, F, F, 3'b000, F, F, F, F}; //异常
        if (Opcode == 6'b000000) //R
            `SIGNAL = {T, F, F, F, 3'b010, F, T, F, F};
        else
            case(Opcode) 
                6'b001000 : `SIGNAL = {F, F, F, T, 3'b000, F, T, F, F}; //ADDI
                6'b001001 : `SIGNAL = {F, F, F, T, 3'b000, F, T, F, T}; //ADDIU
                6'b000100 : `SIGNAL = {F, T, F, F, 3'b001, F, F, F, F}; //BEQ
                6'b000010 : `SIGNAL = {F, F, F, F, 3'b000, F, F, T, F}; //J
                6'b100011 : `SIGNAL = {F, F, T, T, 3'b000, F, T, F, F}; //LW
                6'b101011 : `SIGNAL = {F, F, F, T, 3'b000, T, F, F, F}; //SW
                6'b001111 : `SIGNAL = {F, F, F, T, 3'b011, F, T, F, F}; //LUI
                6'b001101 : `SIGNAL = {F, F, F, T, 3'b100, F, T, F, F}; //ORI
                default   : `SIGNAL = {F, F, F, F, 3'b111, F, F, F, F}; //异常
            endcase    
    end
    // initial
    //     begin
    //       $display("ctrl");
    //     end
endmodule //ctrl