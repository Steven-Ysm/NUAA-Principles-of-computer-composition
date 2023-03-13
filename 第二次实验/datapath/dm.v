module dm(alu_out, din, MemWrite, clk, dm_out);
    input [11:2] alu_out; //输入访存地址
    input [31:0] din; //输入数据
    input MemWrite; //写入使能信号
    input clk; //时钟信号
    output [31:0] dm_out; //输出

    reg [31:0] dm[1023:0];

    initial 
        begin
            $readmemh("./data.txt", dm, 0, 1023);  
        end

    always @ (negedge clk) begin
        if (MemWrite == 1)
            begin
                dm[alu_out] <= din;
                //$display("dm:%d<=%h", alu_out, din);
            end
        //$display("dm  alu_out:%h din:%h MemWrite:%h clk:%h dm_out:%h", alu_out, din, MemWrite, clk, dm_out);
    end

    assign dm_out = dm[alu_out];

    

endmodule //dm