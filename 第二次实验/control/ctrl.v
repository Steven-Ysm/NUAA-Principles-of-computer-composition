module ctrl(ins, Branch, Jump, RegDst, RegWrite, ALUSrc, MemWrite, MemtoReg, AluOp, extOp);
    input [31:0] ins;

    output reg Branch;
    output reg Jump;
    output reg RegDst;
    output reg RegWrite;
    output reg ALUSrc;
    output reg MemWrite;
    output reg MemtoReg;
    output reg [2:0] AluOp;
    output reg extOp;

    wire [5:0] op;
    wire [5:0] func;

    assign op = ins[31:26]; //J型，I型
    assign func = ins[5:0]; //R型

    parameter R = 6'b000000;
    parameter ADDI = 6'b001000;
    parameter ADDIU = 6'b001001;
    parameter BEQ = 6'b000100;
    parameter J = 6'b000010;
    parameter LUI = 6'b001111;
    parameter LW  = 6'b100011;
    parameter ORI = 6'b001101;
    parameter SW = 6'b101011;
    parameter ADD = 6'b100000;
    parameter AND = 6'b100100;
    parameter OR  = 6'b100101;
    parameter SLT = 6'b101010;
    parameter SUB = 6'b100010;
    parameter XOR = 6'b100110;

    always @(*) 
    begin
        case (op)
            R:
                begin
                  Branch = 0;
                  Jump = 0;
                  RegDst = 1;
                  RegWrite = 1;
                  ALUSrc = 0;
                  MemWrite = 0;
                  MemtoReg = 0;
                  case (func)
                    ADD: AluOp = 3'b000;
                    AND: AluOp = 3'b001;
                    OR:  AluOp = 3'b010;
                    SLT: AluOp = 3'b011;
                    SUB: AluOp = 3'b100;
                    XOR: AluOp = 3'b101;
                  endcase
                end
            ADDI:
                begin
                  Branch = 0;
                  Jump = 0;
                  RegDst = 0;
                  RegWrite = 1;
                  ALUSrc = 1;
                  MemWrite = 0;
                  MemtoReg = 0;
                  extOp = 1;
                  AluOp = 3'b000; //ADD
                end
            ADDIU:
                begin
                  Branch = 0;
                  Jump = 0;
                  RegDst = 0;
                  RegWrite = 1;
                  ALUSrc = 1;
                  MemWrite = 0;
                  MemtoReg = 0;
                  extOp = 1;
                  AluOp = 3'b000; //ADD
                end
            BEQ:
                begin
                  Branch = 1;
                  Jump = 0;
                  RegWrite = 0;
                  ALUSrc = 0;
                  MemWrite = 0;
                  extOp = 0;
                  AluOp = 3'b100; //SUB
                end
            J:
                begin
                  Branch = 0;
                  Jump = 1;
                  RegWrite = 0;
                  MemWrite = 0;
                end
            LUI:
                begin
                  Branch = 0;
                  Jump = 0;
                  RegDst = 0;
                  RegWrite = 1;
                  ALUSrc = 1;
                  MemWrite = 0;
                  MemtoReg = 0;
                  AluOp = 3'b110;
                end
            LW:
                begin
                  Branch = 0;
                  Jump = 0;
                  RegDst = 0;
                  RegWrite = 1;
                  ALUSrc = 1;
                  MemWrite = 0;
                  MemtoReg = 1;
                  extOp = 1;
                  AluOp = 3'b000;
                end
            ORI:
                begin
                  Branch = 0;
                  Jump = 0;
                  RegDst = 0;
                  RegWrite = 1;
                  ALUSrc = 1;
                  MemWrite = 0;
                  MemtoReg = 0;
                  extOp = 0;
                  AluOp = 3'b010;
                end
            SW:
                begin
                  Branch = 0;
                  Jump = 0;
                  //RegDst = 0;
                  RegWrite = 0;
                  ALUSrc = 1;
                  MemWrite = 1;
                  //MemtoReg = 0;
                  extOp = 1;
                  AluOp = 3'b000;
                end
        endcase
        ////$display("ctrl  op:%h func:%h ins:%h Branch:%h Jump:%h RegDst:%h RegWrite:%h ALUSrc:%h MemWrite:%h MemtoReg:%h AluOp:%h extOp:%h",op, func, ins, Branch, Jump, RegDst, RegWrite, ALUSrc, MemWrite, MemtoReg, AluOp, extOp);
    end
endmodule //control