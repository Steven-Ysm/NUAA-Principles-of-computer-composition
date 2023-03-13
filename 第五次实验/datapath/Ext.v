module Ext(Ext_op, ins16, Extimm);

    input Ext_op;

    input [15:0] ins16;

    output reg [31:0] Extimm;

    always @(*) begin
        if(Ext_op)
            Extimm = {{16{ins16[15]}}, ins16[15:0]};
        else
            Extimm = {16'h0000, ins16[15:0]};
    end
    // initial
    //     begin
    //       $display("ext");
    //     end

endmodule //ext