module dm (clk, MEM_ALU, MEM_WriteData, MemWrite, MemRead, dm_out);
    
    input        clk;
    input        MemWrite;
    input        MemRead;

    input [31:0] MEM_ALU;
    input [31:0] MEM_WriteData;

    output reg [31:0] dm_out;

    reg [31:0] DM [1023:0];
    
    initial 
        $readmemh("./data.txt", DM, 0, 1023);

    always @(negedge clk) begin   
        if(MemWrite)
            begin
                DM[MEM_ALU[11:2]] = MEM_WriteData;
                $display("dm:%d<=%h", MEM_ALU, MEM_WriteData);
            end
    end
    
    always @(*) begin               
        if(MemRead)
            dm_out = DM[MEM_ALU[11:2]];
    end

endmodule //dm