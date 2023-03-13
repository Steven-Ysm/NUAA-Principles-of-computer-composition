module branch_add(EX_PC, Extimm, branch_add_out);
    
    input [31:0] EX_PC, Extimm;
    output [31:0] branch_add_out;

    assign branch_add_out = (Extimm << 2) + EX_PC;
  always @(branch_add_out) begin
        //$display("branchadd: expc:%h EXtimm:%h branchaddout:%h ", EX_PC, Extimm, branch_add_out);
    end

endmodule // branch_add_out