module alu_ctrl (func, ALUOp, AluCtrlOut);

    input [5:0] func;
    input [2:0] ALUOp;

    output reg [3:0] AluCtrlOut;

    always @(*) begin
        case(ALUOp)
            3'b000:
                begin
                    case(func)
                        6'b100000: AluCtrlOut = 4'b0010; //ADD
                        6'b100100: AluCtrlOut = 4'b0000; //AND
                        6'b100101: AluCtrlOut = 4'b0001; //OR
                        6'b101010: AluCtrlOut = 4'b0111; //SLT
                        6'b100010: AluCtrlOut = 4'b0110; //SUB
                        6'b100110: AluCtrlOut = 4'b0110; //XOR
                    endcase
                end

            3'b010: AluCtrlOut = 4'b0010; //ADDI
            3'b010: AluCtrlOut = 4'b0010; //ADDIU
            3'b010: AluCtrlOut = 4'b0010; //LW
            3'b010: AluCtrlOut = 4'b0010; //SW

            3'b110: AluCtrlOut = 4'b0110; //BEQ

            3'b100: AluCtrlOut = 4'b0100; //LUI
            
            3'b001: AluCtrlOut = 4'b0001; //ORI

        endcase
    end

    // initial
    //     begin
    //       $display("aluctr");
    //     end
endmodule //aluctrl