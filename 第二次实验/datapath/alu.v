//没有溢出
module alu(aluop, a, b, zero, alu_out);
    input [2:0] aluop; //alu控制信号
    input [31:0] a; //rs
    input [31:0] b; //rt

    output zero;
    output reg [31:0] alu_out;

    parameter ADD = 3'b000;
    parameter AND = 3'b001;
    parameter OR = 3'b010;
    parameter SLT = 3'b011;
    parameter SUB = 3'b100;
    parameter XOR = 3'b101;
    parameter LUI = 3'b110;

    always @ (aluop or a or b) begin
      case (aluop)
        ADD: alu_out = a + b;
        AND: alu_out = a & b;
        OR: alu_out = a | b;
        SLT: alu_out = a < b ? 32'b1 : 32'b0;
        SUB: alu_out = a - b;
        XOR: alu_out = a ^ b;
        LUI: alu_out = {b, 16'b0000_0000};
        default: alu_out = 0;
      endcase
      //$display("alu  aluop:%h a:%h b:%h zero:%h alu_out:%h", aluop, a, b, zero, alu_out);
    end

    assign zero = (alu_out == 0) ? 1 : 0;

    

endmodule//alu