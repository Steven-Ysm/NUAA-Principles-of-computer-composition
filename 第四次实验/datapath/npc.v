module npc (PC_add_4, Branch, Zero, Jump, Beq_ext_imm, Jump_ins_add, NPC);
    
    input Branch; 
    input Zero;  
    input Jump;   
    
    input [31:0] PC_add_4;
    input [31:0] Beq_ext_imm; // Beq
    input [25:0] Jump_ins_add;  // Jump 

    output reg [31:0] NPC;

    // reg [31:0]  PC_cur;

    always @(*) begin
        if(Jump)//Jump
            begin
                // PC_cur  = PC_add_4 - 4;
                NPC = {PC_add_4[31:28], Jump_ins_add[25:0], 2'b00};
            end
        else if(Branch && Zero)//Beq
            begin
                NPC = (Beq_ext_imm << 2) + PC_add_4;
            end
        else
            begin
                NPC = PC_add_4;
            end
    end

    // initial
    //     begin
    //       $display("npc");
    //     end
endmodule //npc
