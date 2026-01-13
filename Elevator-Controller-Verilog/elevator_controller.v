`timescale 1ns / 1ps

module elevator_controller (
    input clk,
    input reset,

    input  [3:0] inside_request,
    input  [3:0] call_up,
    input  [3:0] call_down,

    output reg [1:0] current_floor,
    output reg moving_up,
    output reg moving_down,
    output reg door_open
);

    parameter FLOORS = 4;

    parameter IDLE = 2'b00,
              UP   = 2'b01,
              DOWN = 2'b10,
              DOOR = 2'b11;

    reg [1:0] state, next_state;

    reg  [3:0] pending_requests;
    wire [3:0] new_requests;

    assign new_requests = inside_request | call_up | call_down;

    integer i;
    reg req_above, req_below;

    always @(posedge clk or posedge reset) begin
        if (reset)
            pending_requests <= 4'b0000;
        else
            pending_requests <= pending_requests | new_requests;
    end

    always @(*) begin
        req_above = 0;
        req_below = 0;

        for (i = 0; i < FLOORS; i = i + 1) begin
            if (i > current_floor && pending_requests[i])
                req_above = 1;
            else if (i < current_floor && pending_requests[i])
                req_below = 1;
        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            IDLE: begin
                if (pending_requests[current_floor])
                    next_state = DOOR;
                else if (req_above)
                    next_state = UP;
                else if (req_below)
                    next_state = DOWN;
            end

            UP: begin
                if (pending_requests[current_floor])
                    next_state = DOOR;
                else if (!req_above && req_below)
                    next_state = DOWN;
                else if (!req_above && !req_below)
                    next_state = IDLE;
            end

            DOWN: begin
                if (pending_requests[current_floor])
                    next_state = DOOR;
                else if (!req_below && req_above)
                    next_state = UP;
                else if (!req_above && !req_below)
                    next_state = IDLE;
            end

            DOOR: begin
                next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_floor <= 0;
            moving_up <= 0;
            moving_down <= 0;
            door_open <= 0;
        end else begin
            moving_up <= 0;
            moving_down <= 0;
            door_open <= 0;

            case (state)
                IDLE: begin end

                UP: begin
                    moving_up <= 1;
                    if (current_floor < FLOORS-1)
                        current_floor <= current_floor + 1;
                end

                DOWN: begin
                    moving_down <= 1;
                    if (current_floor > 0)
                        current_floor <= current_floor - 1;
                end

                DOOR: begin
                    door_open <= 1;
                    pending_requests[current_floor] <= 0;
                end
            endcase
        end
    end

endmodule
