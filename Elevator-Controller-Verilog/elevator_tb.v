`timescale 1ns / 1ps

module elevator_tb;

    reg clk;
    reg reset;

    reg  [3:0] inside_request;
    reg  [3:0] call_up;
    reg  [3:0] call_down;

    wire [1:0] current_floor;
    wire moving_up;
    wire moving_down;
    wire door_open;

    elevator_controller DUT (
        .clk(clk),
        .reset(reset),
        .inside_request(inside_request),
        .call_up(call_up),
        .call_down(call_down),
        .current_floor(current_floor),
        .moving_up(moving_up),
        .moving_down(moving_down),
        .door_open(door_open)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("elevator.vcd");
        $dumpvars(0, elevator_tb);

        clk = 0;
        reset = 1;
        inside_request = 0;
        call_up = 0;
        call_down = 0;

        #20 reset = 0;

        #10 inside_request[2] = 1;
        #10 inside_request[2] = 0;

        #50 call_down[3] = 1;
        #10 call_down[3] = 0;

        #30 inside_request[1] = 1;
            call_up[2] = 1;
        #10 inside_request[1] = 0;
            call_up[2] = 0;

        #80 call_down[1] = 1;
        #10 call_down[1] = 0;

        #200 $finish;
    end

endmodule
