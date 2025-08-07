`timescale 1ns / 1ps

module smart_traffic_light_tb;

  reg clk;
  reg reset;
  reg pedestrian_button;
  reg [3:0] emergency;
  reg car_n, car_s, car_e, car_w;

  wire [2:0] n, s, e, w;

  // Instantiate the DUT
  smart_traffic_light uut (
    .clk(clk),
    .reset(reset),
    .pedestrian_button(pedestrian_button),
    .emergency(emergency),
    .car_n(car_n),
    .car_s(car_s),
    .car_e(car_e),
    .car_w(car_w),
    .n(n),
    .s(s),
    .e(e),
    .w(w)
  );

  
  initial clk = 0;
  always #5 clk = ~clk;  

  initial begin
   
    reset = 1;
    pedestrian_button = 0;
    emergency = 4'b0000;
    car_n = 0; car_s = 0; car_e = 0; car_w = 0;

    #10; reset = 0;

   
    car_n = 1;
    #120;
    car_n = 0;
    #50;

   
    car_s = 1;
    #30;
    emergency = 4'b0010;  
    #10;
    emergency = 4'b0000;
    #120;
    car_s = 0;
    #50;

   
    car_n = 1;
    #100;
    pedestrian_button = 1;
    #50;
    car_n = 0;
    #100;
    pedestrian_button = 0;
    #120;

   
    car_w = 1;
    #30;
    car_w = 0;
    #50;

    $finish;
  end

endmodule
