module npc(PC, Branch, Compare_Zero, Jump, PC_add_4, Beq_ext_imm, Jump_ins_add, NPC);
    input              Branch;         
    input              Compare_Zero;        
    input              Jump;     

    input      [31:0]  PC;
       
    input      [31:0]  PC_add_4;
    input      [31:0]  Beq_ext_imm;
    input      [31:0]  Jump_ins_add;     
    output reg [31:0]  NPC;

    always @(*)
        if(Jump)//Jump
            begin
                NPC = {PC[31:28], Jump_ins_add[25:0], 2'b00};
            end
        else if(Branch && Compare_Zero)//Beq
            begin
                NPC = (Beq_ext_imm << 2) + PC_add_4;
            end
        else
            begin
                NPC = PC + 4;
            end
    // initial
    //     begin
    //       $display("npc");
    //     end
endmodule //npc