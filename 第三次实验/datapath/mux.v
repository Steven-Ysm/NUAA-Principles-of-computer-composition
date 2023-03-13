module mux_RegDst(rt, rd, RegDst, mux_RegDst_out);
    
    input RegDst;

    input [4:0] rt;
    input [4:0] rd;
    
    output reg [4:0] mux_RegDst_out;

    always @(*) begin
        if(RegDst)
            mux_RegDst_out <= rd;
        else
            mux_RegDst_out <= rt;
    end

endmodule

module mux_ALUSrc(ALUSrc, rtData, Imm, mux_ALUSrc_out);
    
    input ALUSrc;

    input [31:0] rtData;
    input [31:0] Imm;
    
    output reg [31:0] mux_ALUSrc_out;

    always @(*) begin
        if(ALUSrc)
            mux_ALUSrc_out <= rtData;
        else    
            mux_ALUSrc_out <= Imm;
    end

endmodule

module mux_MemToReg(MemtoReg, DmData, ALUData, mux_MemToReg_out);
    
    input MemtoReg;
    
    input [31:0] DmData;
    input [31:0] ALUData;

    output reg [31:0] mux_MemToReg_out;

    always @(*) begin
        if(MemtoReg)
            mux_MemToReg_out <= DmData;
        else
            mux_MemToReg_out <= ALUData;
    end
endmodule

module mux_forward(forward_C, rs_rt_imm, writedata, alu_out, mux_forward_out);

    input [1:0] forward_C;
    input [31:0] rs_rt_imm;
    input [31:0] writedata;
    input [31:0] alu_out;

    output wire [31:0] mux_forward_out;

    assign mux_forward_out = (forward_C == 2'b10) ? alu_out : (forward_C == 2'b01) ? writedata : rs_rt_imm;
endmodule //mux_forward