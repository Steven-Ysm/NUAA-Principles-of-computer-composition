module MEM_WB (clk, 
    MEM_MemtoReg, MEM_RegWrite, 
    MEM_Data_in, MEM_ALU, MEM_Reg_Write,
    WB_MemtoReg, WB_RegWrite, 
    WB_Data_out, WB_ALU, WB_Reg_Write);
    
    input clk;

    input MEM_MemtoReg;
    input MEM_RegWrite;

    input [31:0] MEM_Data_in;
    input [31:0] MEM_ALU;
    input [4:0]  MEM_Reg_Write;

    output reg WB_MemtoReg;
    output reg WB_RegWrite;

    output reg [31:0] WB_Data_out;
    output reg [31:0] WB_ALU;
    output reg [4:0]  WB_Reg_Write;

    always @(posedge clk) begin
        WB_MemtoReg   <= MEM_MemtoReg;
        WB_RegWrite   <= MEM_RegWrite;
        WB_Data_out   <= MEM_Data_in;
        WB_ALU   <= MEM_ALU;
        WB_Reg_Write  <= MEM_Reg_Write;
    end
endmodule //MEM_WB