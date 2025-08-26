`timescale 1ns / 1ps

module adaptive_TLC(
 input clk,
  input reset,
  input pedestrian_button,
  input [3:0] emergency,   
  input car_n, car_s, car_e, car_w,
  output reg [2:0] n, s, e, w
    );
    
  localparam GREEN  = 3'b001;
  localparam YELLOW = 3'b010;
  localparam RED    = 3'b100;

  localparam 
    IDLE     = 4'b0000,
    PED      = 4'b0001,

    N_GREEN  = 4'b0010, N_YELLOW  = 4'b0011,
    S_GREEN  = 4'b0100, S_YELLOW  = 4'b0101,
    E_GREEN  = 4'b0110, E_YELLOW  = 4'b0111,
    W_GREEN  = 4'b1000, W_YELLOW  = 4'b1001;

  reg [3:0] state;
  reg [3:0] count;
  reg [3:0] emergency_pending;
  reg pedestrian_pending;
  reg [3:0] car_pending;

  always @(posedge clk) begin 
    if (reset) begin
      state <= IDLE;
      count <= 4'd0;
      emergency_pending <= 4'b0000;
      pedestrian_pending <= 1'b0;
      car_pending <= 4'b0000;
    end
    
    else begin

      if (emergency != 4'b0000)
        emergency_pending <= emergency_pending | emergency;

      if (pedestrian_button)
        pedestrian_pending <= 1;

      if (car_n | car_s | car_e | car_w)
        car_pending <= car_pending | {car_n, car_s, car_e, car_w}; 

      case (state)

        IDLE: begin
          
          if (emergency_pending != 4'b0000) begin 
            if (emergency_pending[3]) begin
              state <= N_GREEN;
              emergency_pending[3] <= 0;
            end
            else if (emergency_pending[2]) begin
              state <= S_GREEN;
              emergency_pending[2] <= 0;
            end
            else if (emergency_pending[1]) begin
              state <= E_GREEN;
              emergency_pending[1] <= 0;
            end
            else if (emergency_pending[0]) begin
              state <= W_GREEN;
              emergency_pending[0] <= 0;
            end
            count <= 0;
          end
          
          else if (pedestrian_pending) begin
            state <= PED;
            pedestrian_pending <= 0;
            count <= 0;
          end
          
          else if (car_pending != 4'b0000) begin
            if (car_pending[3]) begin
              state <= N_GREEN;
              car_pending[3] <= 0;
            end
            else if (car_pending[2]) begin
              state <= S_GREEN;
              car_pending[2] <= 0;
            end
            else if (car_pending[1]) begin
              state <= E_GREEN;
              car_pending[1] <= 0;
            end
            else if (car_pending[0]) begin
              state <= W_GREEN;
              car_pending[0] <= 0;
            end
            count <= 0;
          end
          else begin
            state <= IDLE;
          end
        end

        PED: begin
          if (count == 4'd4) begin  
            count <= 0;
            state <= IDLE;
          end
          else begin
            count <= count + 1;
            state <= PED;
          end
        end

        N_GREEN: begin
          if (count == 4'd7) begin
            count <= 0;
            state <= N_YELLOW;
          end
          else begin
            count <= count + 1;
            state <= N_GREEN;
          end
        end

        N_YELLOW: begin
          if (count == 4'd3) begin
            count <= 0;
            state <= IDLE;
          end
          else begin
            count <= count + 1;
            state <= N_YELLOW;
          end
        end

        S_GREEN: begin
          if (count == 4'd7) begin
            count <= 0;
            state <= S_YELLOW;
          end
          else begin
            count <= count + 1;
            state <= S_GREEN;
          end
        end
        
        S_YELLOW: begin
          if (count == 4'd3) begin
            count <= 0;
            state <= IDLE;
          end
          else begin
            count <= count + 1;
            state <= S_YELLOW;
          end
        end

        E_GREEN: begin
          if (count == 4'd7) begin
            count <= 0;
            state <= E_YELLOW;
          end
          else begin
            count <= count + 1;
            state <= E_GREEN;
          end
        end

        E_YELLOW: begin
          if (count == 4'd3) begin
            count <= 0;
            state <= IDLE;
          end
          else begin
            count <= count + 1;
            state <= E_YELLOW;
          end
        end

        W_GREEN: begin
          if (count == 4'd7) begin
            count <= 0;
            state <= W_YELLOW;
          end
          else begin
            count <= count + 1;
            state <= W_GREEN;
          end
        end

        W_YELLOW: begin
          if (count == 4'd3) begin
            count <= 0;
            state <= IDLE;
          end
          else begin
            count <= count + 1;
            state <= W_YELLOW;
          end
        end

        default: begin
          state <= IDLE;
          count <= 0;
        end

      endcase
    end
  end

  always @(state) begin
    case (state)
      IDLE, PED: begin
        n = RED; s = RED; e = RED; w = RED;
      end

      N_GREEN: begin n = GREEN; s = RED; e = RED; w = RED; end
      N_YELLOW: begin n = YELLOW; s = RED; e = RED; w = RED; end

      S_GREEN: begin n = RED; s = GREEN; e = RED; w = RED; end
      S_YELLOW: begin n = RED; s = YELLOW; e = RED; w = RED; end

      E_GREEN: begin n = RED; s = RED; e = GREEN; w = RED; end
      E_YELLOW: begin n = RED; s = RED; e = YELLOW; w = RED; end

      W_GREEN: begin n = RED; s = RED; e = RED; w = GREEN; end
      W_YELLOW: begin n = RED; s = RED; e = RED; w = YELLOW; end

      default: begin n = RED; s = RED; e = RED; w = RED; end
    endcase
  end

endmodule