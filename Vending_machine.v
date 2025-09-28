`timescale 1ns / 1ps
module Vending_machine (
    input clk, reset,
    input N, D,         // Nickel=5, Dime=10
    output reg newspaper
);

    // State encoding
    localparam S0  = 3'd0,
               S5  = 3'd1,
               S10 = 3'd2,
               S15 = 3'd3,
               S20 = 3'd4;

    reg [2:0] current_state, next_state;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= S0;
        else 
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        newspaper = 0;

        case (current_state)
            S0: begin
                if (N) next_state = S5;
                else if (D) next_state = S10;
            end
    S5: begin
                if (N) next_state = S10;
                else if (D) next_state = S15;
            end
            S10: begin
                if (N) next_state = S15;
                else if (D) next_state = S20;
            end
            S15: begin
                newspaper = 1;
                next_state = S0;
            end
            S20: begin
                newspaper = 1;
                next_state = S0;
            end
        endcase
    end

endmodule
