module PC_add (PC, PC_add_4);

    input [31:0] PC;

    output reg [31:0] PC_add_4;

    always @(*) begin
        PC_add_4 <= PC + 4;
    end
endmodule //PC_add