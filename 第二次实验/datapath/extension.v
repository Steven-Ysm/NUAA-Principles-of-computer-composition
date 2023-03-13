module extension(imm16, extop, dout);
    input extop; //扩展信号
    input [15:0] imm16; //输入立即数
    output reg [31:0] dout; //输出立即数

  always @( * ) begin
    case (extop) 
        1'b0: dout = {16'h0000, imm16}; //无符号扩展
        1'b1: dout = {{16{imm16[15]}}, imm16}; //符号扩展
    endcase
    //$display("extension  imm16:%h extop:%h dout:%h", imm16, extop, dout);
  end

  
endmodule//extension