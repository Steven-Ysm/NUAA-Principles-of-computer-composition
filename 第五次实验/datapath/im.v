module im (PC, out_ins);
    input [31:0] PC;

    output [31:0] out_ins;

    reg [31:0] IM[1023:0]; 

    initial begin
        $readmemh("./code.txt", IM, 0, 1023);
        // $display("%h",IM[0]);
    end

    assign out_ins = IM[PC[11:2]];

    // initial
    //     begin
    //       $display("im");
    //     end

endmodule //im  

