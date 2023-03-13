module Compare(ReadData1,MEM_AluOut,forwardrsd,
            ReadData2,forwardrtd,Compare_Zero,AluOut);

    input [31:0] ReadData1;
    input [31:0] ReadData2;
    
    input [31:0] MEM_AluOut;
    input [31:0] AluOut;

    input [1:0] forwardrsd;
    input [1:0] forwardrtd;
    
    output reg Compare_Zero;

    reg [31:0] num1;
    reg [31:0] num2;

    initial
        begin
            Compare_Zero = 1'b0;
        end
    always @(*) begin
        if(forwardrsd  ==  2'b01)
            num1 = MEM_AluOut;
        else if(forwardrsd == 2'b00)
            num1 = ReadData1;
        else
            num1 = AluOut; 

        if(forwardrtd == 2'b01)
            num2 = MEM_AluOut;
        else if(forwardrtd == 2'b00)
            num2 = ReadData2;
        else
            num2 = AluOut;


        if(num1 == num2)
            Compare_Zero = 1'b1;
        else
            Compare_Zero = 1'b0;
    end

    // initial
    // begin
    //   $display("compare");
    // end
endmodule