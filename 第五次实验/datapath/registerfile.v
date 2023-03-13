module register_file (clk , rst, rs, rt, rd, writedata, WB_RegWrite, ReadData1, ReadData2);
    
    input        clk;
    input        rst;

    input        WB_RegWrite;

    input [4:0]  rs;
    input [4:0]  rt;
    input [4:0]  rd;
    input [31:0] writedata;

    output [31:0] ReadData1;
    output [31:0] ReadData2;

    reg [31:0] Registers [31:0];
    
    integer i;
    
    always @(posedge clk or posedge rst)
    begin
        if(rst == 1)
            for(i = 0; i < 32; i=i+1)
                Registers[i] <= 32'h0000_0000;
        else if(WB_RegWrite && rd != 5'b00000) 
            begin
                Registers[rd] <= writedata;
                $display("reg:$%d<=%h", rd, writedata);
            end
    end

    assign ReadData1 = (rs==0) ? 0 : Registers[rs];
    assign ReadData2 = (rt==0) ? 0 : Registers[rt];

    // initial
    //     begin
    //       $display("rf");
    //     end
endmodule //register_file