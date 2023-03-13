module alu_ctrl(func, EX_ALUOp, AluCtrlOut, undefine);
    input       [5:0] func;
    input       [2:0] EX_ALUOp;

    output reg  [2:0] AluCtrlOut;
    output reg  undefine;
    
    always @(*) begin
        case(EX_ALUOp)
            3'b000 : AluCtrlOut = 3'b010; //LW
            3'b000 : AluCtrlOut = 3'b010; //SW
            3'b001 : AluCtrlOut = 3'b110; //BEQ
            3'b011 : AluCtrlOut = 3'b101; //LUI
            3'b100 : AluCtrlOut = 3'b001; //ORI
            3'b111 : AluCtrlOut = 3'b100; //异常

            3'b010://R型指令
                begin
                    case(func)
                        6'b100000 : AluCtrlOut = 3'b010; //ADD
                        6'b100010 : AluCtrlOut = 3'b110; //SUB
                        6'b100100 : AluCtrlOut = 3'b000; //AND
                        6'b100101 : AluCtrlOut = 3'b001; //OR
                        6'b101010 : AluCtrlOut = 3'b111; //SLT
                        6'b100110 : AluCtrlOut = 3'b011; //XOR
                        default   : AluCtrlOut = 3'b100; //异常
                    endcase
                end
        endcase    

        if(AluCtrlOut == 3'b100)//未定义
            begin
                undefine = 1;
            end
        else
            begin
                undefine = 0;
            end
    end

    // initial
    //     begin
    //       $display("aluctr");
    //     end
endmodule //aluctrl