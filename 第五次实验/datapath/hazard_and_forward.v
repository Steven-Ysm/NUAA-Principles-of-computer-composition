module Hazard_and_Forward(MEM_RegWrite, WB_RegWrite, MEM_MemtoReg, Compare_Zero,
    MEM_mux_RegDst_out, rd, EX_rs, EX_rt, ID_rs,ID_rt,mux_RegDst_out,
    forwardrs,forwardrt,PCWrite,EXflush,IFWrite,
    Jump,Branch,EX_RegWrite,EX_MemtoReg,EX_MemWrite,
    forward_rs_compare,forward_rt_compare,IFflush);

    //data hazard
    input MEM_RegWrite;
    input MEM_MemtoReg;
    input WB_RegWrite;
    input Compare_Zero;

    input [4:0] MEM_mux_RegDst_out;
    input [4:0] rd;
    
    input [4:0] EX_rs;
    input [4:0] EX_rt;
    
    input [4:0] ID_rs;
    input [4:0] ID_rt;
    input [4:0] mux_RegDst_out;

    output reg [1:0] forwardrs;
    output reg [1:0] forwardrt;

    output reg EXflush;
    output reg PCWrite;
    output reg IFWrite;

    //ctrl hazard
    input Jump;
    input Branch;
    input EX_RegWrite;
    input EX_MemtoReg;
    input EX_MemWrite;

    output reg [1:0] forward_rs_compare;             
    output reg [1:0] forward_rt_compare;
    output reg IFflush;

    reg CBD;
    reg CLDERS;
    reg CLDERT;
    reg CBDMRS;
    reg CBDMRT;

    initial
        begin
            forwardrs = 2'b00;
            forwardrt = 2'b00;
            forward_rs_compare = 2'b00;
            forward_rt_compare = 2'b00;

            EXflush = 1'b0;
            PCWrite = 1'b1;
            IFWrite = 1'b1;
            IFflush = 1'b0;
        end


    always @(*) begin   
        // data hazard
        forwardrs = 2'b00;
        forwardrt = 2'b00;
        forward_rs_compare = 2'b00;
        forward_rt_compare = 2'b00;

        EXflush = 1'b0;
        PCWrite = 1'b1;
        IFWrite = 1'b1;
        CBD = 1'b0;
        IFflush = 1'b0;


      //rs forward or not
        if((EX_rs != 0) & (EX_rs == MEM_mux_RegDst_out) & MEM_RegWrite)
            forwardrs = 2'b10;
        else if((EX_rs != 0)&(EX_rs == rd ) & WB_RegWrite)
            forwardrs = 2'b01;

      //rt......
        if((EX_rt != 0) & (EX_rt == MEM_mux_RegDst_out) & MEM_RegWrite)
            forwardrt = 2'b10;
        else if((EX_rt !=0) & (EX_rt == rd) & WB_RegWrite)
            forwardrt = 2'b01;
            
        // add_lw
        if((ID_rs == mux_RegDst_out) && EX_MemWrite)
            begin
                CLDERS = 1'b1;
            end
        else
            CLDERS=1'b0;
        if((ID_rt == mux_RegDst_out) && EX_MemWrite)
            begin
                CLDERT = 1'b1;
            end
        else
            CLDERT = 1'b0;


        CBDMRS = (ID_rs == MEM_mux_RegDst_out) & MEM_RegWrite;
        CBDMRT = (ID_rt == MEM_mux_RegDst_out) & MEM_RegWrite;
        if(CBDMRS)
            forward_rs_compare = 2'b01;
        else
            forward_rs_compare = 2'b00;
        if(CBDMRT)
            forward_rt_compare = 2'b01;
        else
            forward_rt_compare = 2'b00;

        if(Branch&(ID_rs==mux_RegDst_out|ID_rt==mux_RegDst_out)&(EX_MemtoReg|EX_RegWrite))
            CBD =1 'b1;
        else if(Branch&MEM_MemtoReg&(ID_rs==MEM_mux_RegDst_out|ID_rt==MEM_mux_RegDst_out))
            CBD = 1'b1;
        else
            CBD = 1'b0;

        if(CLDERS)
            PCWrite = 1'b0;
        else if(CLDERT)
            PCWrite = 1'b0;
        else if(CBD)
            PCWrite = 1'b0;
        else
            PCWrite = 1'b1;

        if(CLDERS)
            IFWrite=1'b0;
        else if(CLDERT)
            IFWrite=1'b0;
        else if(CBD)
            IFWrite=1'b0;
        else
            IFWrite=1'b1;

        if(Branch & Compare_Zero)
            IFflush = 1'b1;
        else if(Jump)
            IFflush = 1'b1;
        else
            IFflush = 1'b0;

        if(CLDERS)
            EXflush = 1'b1;
        else if(CLDERT)
            EXflush = 1'b1;
        else if(CBD)
            EXflush = 1'b1;
        else
            EXflush = 1'b0;
        
    end
    // initial
    // begin
    //   $display("hazardunit");
    // end
endmodule