module mux_RegDst(rt, rd, EX_RegDst, mux_RegDst_out);
    
    input EX_RegDst;

    input [4:0] rt;
    input [4:0] rd;
    
    output reg [4:0] mux_RegDst_out;

    always @(*) begin
        if(EX_RegDst)
            mux_RegDst_out <= rd;
        else
            mux_RegDst_out <= rt;
    end

    // initial
    //     begin
    //       $display("mux_regdst");
    //     end
endmodule


module mux_ALUSrc(mux_forward_out2, Extimm, EX_ALUSrc, mux_ALUSrc_out);

    input EX_ALUSrc;     

    input [31:0] mux_forward_out2;
    input [31:0] Extimm;

    output reg [31:0] mux_ALUSrc_out;

    always @(*) begin
        if (EX_ALUSrc)
            mux_ALUSrc_out <= Extimm;
        else
            mux_ALUSrc_out <= mux_forward_out2;
    end
    // initial
    //     begin
    //       $display("mux_alusrc");
    //     end
endmodule



module mux_MemToReg(WB_dm_out, WB_AluOut, WB_MemtoReg, mux_MemToReg_out);

    input WB_MemtoReg;    

    input [31:0] WB_dm_out;      
    input [31:0] WB_AluOut;     

    output reg  [31:0] mux_MemToReg_out;   

    always @(*) begin
        if (WB_MemtoReg)
            mux_MemToReg_out <= WB_dm_out;
        else
            mux_MemToReg_out <= WB_AluOut;
    end
    // initial
    //     begin
    //       $display("mux_memtoreg");
    //     end
endmodule


module mux_forward(forward, EX_ReadData, mux_MemToReg_out, MEM_AluOut, mux_forward_out);

    input [1:0] forward;

    input [31:0] EX_ReadData;
    input [31:0] mux_MemToReg_out;
    input [31:0] MEM_AluOut;

    output reg [31:0] mux_forward_out;

    always @(*) begin
        mux_forward_out = (forward == 2'b10) ? MEM_AluOut : (forward == 2'b01) ? mux_MemToReg_out : EX_ReadData;
    end

    // initial
    //     begin
    //       $display("mux_forward");
    //     end
endmodule //mux_forward