module  dm_4k(clk, MEM_MemWrite, MEM_AluOut, MEM_writedata, dm_out);
    input clk;
    input MEM_MemWrite;
    
    input [31:0] MEM_AluOut;
    input [31:0] MEM_writedata;

    output [31:0] dm_out;
    
    reg[31:0] DM [1023:0];

    assign dm_out = DM[ MEM_AluOut [11:2] ];
    
    always @(posedge clk) begin
        if(MEM_MemWrite)
            begin
                DM[MEM_AluOut[11:2]]<=MEM_writedata;
                $display("dm:%d<=%h", MEM_AluOut[11:2], MEM_writedata);
            end
    end
    // initial
    //     begin
    //       $display("dm");
    //     end

endmodule //dm
