`timescale 1ns / 1ps

module tb_vending_machine;
    reg clk, reset, N, D;
    wire newspaper;

    Vending_machine uut (.clk(clk), .reset(reset), .N(N), .D(D), .newspaper(newspaper));

    // Clock
    always #5 clk = ~clk;
	 
	  initial begin
        $monitor("Time=%0d state=%b N=%b D=%b -> Newspaper=%b", $time, uut.current_state, N, D, newspaper);
        clk = 0; reset = 1; N = 0; D = 0;
        #10 reset = 0;

        // Case 1: N + D = 15
        #10 N=1; #10 N=0;
        #10 D=1; #10 D=0;

        // Case 2: D + N = 15
        #20 D=1; #10 D=0;
        #10 N=1; #10 N=0;
		  
		   // Case 3: N + N + N = 15
        #20 N=1; #10 N=0;
        #10 N=1; #10 N=0;
        #10 N=1; #10 N=0;

        // Case 4: D + D = 20
        #20 D=1; #10 D=0;
        #10 D=1; #10 D=0;

        #50;
    end
endmodule


