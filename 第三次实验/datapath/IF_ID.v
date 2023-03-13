module IF_ID (clk, IF_PC, IF_ins, ID_PC, ID_ins);
    
    input  clk;

    input  [31:0] IF_PC;
    input  [31:0] IF_ins;
    
    output reg [31:0] ID_PC;
    output reg [31:0] ID_ins;

    always @(posedge clk) begin
        ID_PC <= IF_PC;
        ID_ins <= IF_ins;
    end

endmodule //IF_ID