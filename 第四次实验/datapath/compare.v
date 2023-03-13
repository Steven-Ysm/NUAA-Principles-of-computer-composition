module compare (comparesrc_1, comparesrc_2, Zero);

    input [31:0] comparesrc_1;
    input [31:0] comparesrc_2;

    output Zero;

    assign Zero = (comparesrc_1 == comparesrc_2) ? 1 : 0;

    // initial
    //     begin
    //       $display("compare");
    //     end

endmodule //compare