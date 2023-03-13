module Alu (op,a,b,zero,result);
    input [3:0] op;
    input [31:0] a,b;
    output reg zero;
    output reg[31:0] result;

always@(*)
begin
    case(op)
        //And
        4'b0000:
            begin
                result = a & b; 
                zero = (result == 0) ? 1 : 0;
            end
        //or
        4'b0001:
            begin
                result = a | b;
                zero = (result == 0) ? 1: 0;
            end
        //add
        4'b0010:
            begin
                result = a + b;
                zero = (result == 0) ? 1 : 0; 
            end
        //sub
        4'b0011:
            begin
                result = a - b;
                zero = (result == 0) ? 1 : 0;
            end
        //xor
        4'b0101:
            begin
                result = a ^ b;
                zero = (result == 0) ? 1 : 0;
            end
    endcase
end
endmodule