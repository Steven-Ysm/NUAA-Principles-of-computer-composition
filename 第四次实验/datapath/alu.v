module alu (AluCtrlOut, rs, rt, Zero, AluOut);

    input [31:0] rs;
    input [31:0] rt; // or Immediate
    input [3:0] AluCtrlOut;

    output  Zero;
    output reg [31:0] AluOut;

    always @(AluCtrlOut or rs or rt) begin
        case(AluCtrlOut)
            4'b0010: AluOut = rs + rt; //ADD
            4'b0110: AluOut = rs - rt; //SUB
            4'b0000: AluOut = rs & rt; //AND
            4'b0001: AluOut = rs | rt; //OR
            4'b0010: AluOut = rs ^ rt; //XOR
            4'b0100: AluOut = {rt, 16'h0000}; //LUI
            4'b0111: AluOut = (rs < rt) ? 32'b1 : 32'b0; //SLT
        endcase
    end

    assign Zero = (AluOut==0) ? 1 : 0;

    // initial
    //     begin
    //       $display("alu");
    //     end
endmodule //alu