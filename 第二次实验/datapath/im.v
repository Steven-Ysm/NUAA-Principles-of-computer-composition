module im(PC, out_ins);
    input [11:2] PC; //输入指令地址
    output [31:0] out_ins; //输出指令编码
    
    reg [31:0] im[1023:0]; //32字节*1024

    initial 
    begin
      $readmemh("./code.txt", im, 0, 1023); //加载指令
      
    end

    assign out_ins = im[PC];
    always @(out_ins) begin
      //$display("Im pc:%h, ins:%h", PC, out_ins);
    end
    

endmodule //im