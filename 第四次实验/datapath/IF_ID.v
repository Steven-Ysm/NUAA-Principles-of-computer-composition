module IF_ID (clk, rst, IFflush, IFWrite,
    IF_PC, IF_ins, 
    ID_PC, ID_ins);
    
    input clk;
    input rst;
    input IFflush;
    input IFWrite;

    input  [31:0] IF_PC;
    input  [31:0] IF_ins;
    
    output reg [31:0] ID_PC;
    output reg [31:0] ID_ins;

    always @(posedge clk) begin
        if (rst)
            begin
                ID_PC = 32'b0;
                ID_ins = 32'b0;
            end
        
        if(IFflush)
            begin
                ID_PC = 32'b0;
                ID_ins = 32'b0;
            end
        else if (IFWrite)
            begin
                ID_PC = IF_PC;
                ID_ins = IF_ins;
            end
    end


    // initial
    //     begin
    //       $display("if_id");
    //     end

endmodule //IF_ID