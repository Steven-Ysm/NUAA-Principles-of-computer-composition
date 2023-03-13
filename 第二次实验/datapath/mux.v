module mux#(parameter length = 32)(a, b, ctrl_src, dout);
    input [length-1:0] a; //输入
    input [length-1:0] b; //输入
    input ctrl_src; //输入信号，aluSrc和PcsRC
    output reg [length-1:0] dout;

    always @(*)
        begin
          dout <= (ctrl_src) ? b : a;
          //$display("mux a:%h b:%h ctrl_src:%h dout:%h",a, b, ctrl_src, dout);
        end

endmodule//mux