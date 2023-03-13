`define SIGNAL {RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, ExtOp}

module ctrl (Opcode, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, ExtOp);
    
    input [31:26] Opcode;

    output reg                  RegDst;    
    output reg                  Jump;      
    output reg                  Branch;    
    output reg                  MemRead;   
    output reg                  MemtoReg;  
    output reg [2:0]  ALUOp;
    output reg                  MemWrite;  
    output reg                  ALUSrc;  
    output reg                  RegWrite;  
    output reg                  ExtOp;   

    always @(*) begin
        if(Opcode == 6'b000000)
            `SIGNAL = {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 3'b000, 1'b0, 1'b1, 1'b1, 1'b1};
        else
            case(Opcode)
                6'b001000: `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 3'b010, 1'b0, 1'b0, 1'b1, 1'b0}; //ADDIU
                6'b001001: `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 3'b010, 1'b0, 1'b0, 1'b1, 1'b1}; //ADDI
                6'b001101: `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 3'b001, 1'b0, 1'b0, 1'b1, 1'b0}; //ORI
                6'b001111: `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 3'b100, 1'b0, 1'b0, 1'b1, 1'b0}; //LUI
                6'b100011: `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 3'b010, 1'b0, 1'b0, 1'b1, 1'b0}; //LW
                6'b101011: `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 3'b010, 1'b1, 1'b0, 1'b0, 1'b0}; //SW
                6'b000100: `SIGNAL = {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 3'b110, 1'b0, 1'b1, 1'b0, 1'b1}; //BEQ
                6'b000010: `SIGNAL = {1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 3'b111, 1'b0, 1'b0, 1'b0, 1'b0}; //J
            endcase
    end

    // initial
    //     begin
    //       $display("ctrl");
    //     end
endmodule //ctrl