module npc(PC, Branch, Jump, Zero, ext_imm, imm26, NPC);
    input Branch, Jump, Zero; 
    input [31:0] PC; //当前指令地址
    input [31:0] ext_imm;
    input [25:0] imm26;
    output reg [31:0] NPC; //NextPc

    wire [31:0] pc4; //用在后面正常的下一条指令pc+4
    assign pc4 = PC + 3'b100;

    always @(*)
    begin
        if(Zero && Branch)
            begin
                NPC = ({{14{ext_imm[15]}}, ext_imm[15:0], 2'b00}) + pc4; //beq
            end   
        else if (Jump)
            begin
                NPC = {PC[31:28], imm26[25:0], 2'b00}; //j
            end
        else
            begin
              NPC = pc4;
            end
    end
endmodule //npc