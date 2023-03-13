`include "mips.v"

module Testbench();
    reg    clk ;
    reg    rst ;

    initial begin
    
    end
    
    Mips mips(clk, rst);

    
    initial 
        begin
            clk <= 0 ;
            rst <= 1 ;
            #10 rst <= 0 ; 
            #3000 $finish;
        end
            
    integer cnt = 0;
    always@(*)
    begin
         #20 clk<=~clk;
         cnt = cnt + 1;
    end
    initial 
    begin
        $dumpfile("wave.vcd");
        $dumpvars;    
    end
//iverilog -o test testbench1.v
    
endmodule