module HazardUnit(clk, rst,
    mux_RegDst_out, rs, rt, EX_Reg_Write, 
    ID_MemRead, ID_RegWrite, EX_RegWrite, PCSrc, Jump, EX_MemRead, Branch,
    PCWrite, IFflush, IFWrite, ctrflush, Branch_1);

    input clk, rst;

    input [4:0] mux_RegDst_out, rs, rt, EX_Reg_Write; 

    input ID_MemRead, ID_RegWrite, EX_RegWrite, EX_MemRead;
    input PCSrc; //根据 PCSrc 的值判断分支是否成功，若分支成功则对 IF级指令进行冲刷

    input Jump, Branch;

    output reg PCWrite; //控制 Pc 是否更新
    output reg IFflush; //控制 IF/ID 流水寄存器是否清零
    output reg IFWrite; //控制 IF/ID 是否可以写入数据
    output reg ctrflush; //控制 ID/EX 流水寄存器中存储的控制信号是否清零

    output reg Branch_1;

    always@(posedge clk) 
        begin
            if (PCSrc || (Jump))
                IFflush  = 1'b1; 
            else  
                IFflush = 1'b0;                                  
                PCWrite = 1'b1; 
                ctrflush = 1'b0;
                IFWrite = 1'b1;
                Branch_1=1'b1;
        
            if(Branch)//beq 冒险
                begin
                if((ID_RegWrite && (mux_RegDst_out == rs || mux_RegDst_out == rt)) || (EX_MemRead && EX_RegWrite && (EX_Reg_Write == rs || EX_Reg_Write == rt)) )
                    begin
                        PCWrite = 1'b0;  
                        IFWrite = 1'b0;   
                        ctrflush = 1'b1; 
                        Branch_1 = 1'b0;                
                    end
                end  

            if (ID_MemRead && ((mux_RegDst_out == rs) || (mux_RegDst_out == rt)))     
                begin 
                    PCWrite = 1'b0; 
                    ctrflush = 1'b1; 
                    IFWrite = 1'b0; 
                end  
        end

        // initial
        // begin
        //   $display("hazardunit");
        // end
endmodule