module forward_unit_1(clk, rst,
    EX_RegWrite, EX_Reg_Write, EX_rs,
    MEM_RegWrite, MEM_Reg_Write, EX_rt,
    ForwardA_1, ForwardB_1);

    input clk, rst;

    input EX_RegWrite;
    input [4:0] EX_Reg_Write; //EX_rd
    input [4:0] EX_rs;

    input MEM_RegWrite;
    input [4:0] MEM_Reg_Write; //MEM_rd
    input [4:0]EX_rt;

    output reg [1:0] ForwardA_1; 
    output reg [1:0] ForwardB_1;

    always @(posedge clk) 
        begin
            if (EX_RegWrite && (EX_Reg_Write != 0) && (EX_Reg_Write == EX_rs))
                begin
                    ForwardA_1 = 2'b10;
                end
            else if ((MEM_RegWrite) && (MEM_Reg_Write != 0) && (MEM_Reg_Write == EX_rs)) 
                begin
                    ForwardA_1 = 2'b01;
                end
            else 
                begin
                    ForwardA_1 = 2'b00;  
                end 
            
            if ((EX_RegWrite) && (EX_Reg_Write != 0) && (EX_Reg_Write == EX_rt))
                begin
                    ForwardB_1 = 2'b10;
                end
            else if ((MEM_RegWrite) && (MEM_Reg_Write != 0) && (MEM_Reg_Write == EX_rt))
                begin
                    ForwardB_1 = 2'b01;
                end
            else 
                begin
                    ForwardB_1 = 2'b00;
                end
        end

    // initial
    //     begin
    //       $display("forwarrdunit1");
    //     end
endmodule

module forward_unit_2(clk, rst,
    rs, rt, EX_Reg_Write,
    Branch, EX_RegWrite,
    ForwardA_2, ForwardB_2);

    input clk;
    input rst;

    input [4:0] rs;
    input [4:0] rt;
    input [4:0] EX_Reg_Write; //EX_rd

    input Branch;
    input EX_RegWrite;

    output reg ForwardA_2; 
    output reg ForwardB_2;

    always @(posedge clk) 
        begin
            if(Branch && EX_RegWrite && (EX_Reg_Write!= 0) && (EX_Reg_Write == rs)) 
                begin
                    ForwardA_2 = 1'b1;
                end
            else 
                begin
                    ForwardA_2 = 1'b0;
                end

            if(Branch && EX_RegWrite && (EX_Reg_Write != 0) && (EX_Reg_Write == rt)) 
                begin
                    ForwardB_2 = 1'b1;
                end
            else 
                begin
                    ForwardB_2 = 1'b0;
                end
        end

    // initial
    //     begin
    //       $display("forwarrdunit2");
    //     end

endmodule