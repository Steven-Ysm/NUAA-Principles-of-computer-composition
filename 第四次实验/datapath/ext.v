module ext (ExtOp, ins16, Extimm);
    
    input [15:0] ins16;
    input        ExtOp;     

    output reg [31:0] Extimm;

    always @(*) begin
        if(ExtOp)
            Extimm = {{16{ins16[15]}}, ins16[15:0]};
        else
            Extimm = {16'h0000, ins16[15:0]};
    end
    // initial
    //     begin
    //       $display("ext");
    //     end

endmodule //ext