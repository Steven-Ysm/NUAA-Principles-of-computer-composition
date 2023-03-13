module alu( A, B, AluCtrlOut, zero, AluOut, overflow);
    input [31:0] A;        
    input [31:0] B;       
    input [2:0] AluCtrlOut;

    output zero;           
    output reg [31:0] AluOut;
    output reg overflow;      
    reg        [32:0]temp;

    always @(*) begin
        case(AluCtrlOut)
            3'b000: //AND
                begin
                    AluOut = A & B;
                    overflow = 0;
                end

            3'b001: //OR
                begin
                    AluOut = A | B;
                    overflow = 0;
                end

            3'b010: //ADD
                begin
                    temp = {A[31], A} + {B[31], B};
                    if(temp[32] != temp[31])
                        begin
                            overflow = 1;
                        end
                    else
                        begin
                            AluOut = temp;
                            overflow = 0;
                        end
                end

            3'b110: //SUB
                begin
                    temp = {A[31], A} - {B[31], B};
                    if(temp[32] != temp[31])
                        begin
                            overflow = 1;
                        end
                    else
                        begin
                            AluOut = temp;
                            overflow = 0;
                        end
                end

            3'b011: //XOR
                begin
                    AluOut = A ^ B;
                    overflow = 0;
                end

            3'b101: //LUI
                begin
                    AluOut = {B, 16'b0000_0000};
                    overflow = 0;
                end

            3'b111: //SLT
                begin
                    AluOut = (A < B) ? 32'b1 : 32'b0;
                    overflow = 0;
                end
        endcase
    end
    
    assign zero = (AluOut == 0) ? 1 : 0;

    // initial
    //     begin
    //       $display("alu");
    //     end
endmodule //alu