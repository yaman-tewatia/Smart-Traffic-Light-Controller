`timescale 1ns / 1ps

module TLC_testbench( );
  reg clk;
  reg reset;
  reg pedestrian_button;
  reg [3:0] emergency; 
  reg car_n, car_s, car_e, car_w;
  wire [2:0] n, s, e, w;

  adaptive_TLC uut (
    .clk(clk),
    .reset(reset),
    .pedestrian_button(pedestrian_button),
    .emergency(emergency),
    .car_n(car_n), .car_s(car_s), .car_e(car_e), .car_w(car_w),
    .n(n), .s(s), .e(e), .w(w)
  );

  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
   
    reset = 1;
    pedestrian_button = 0;
    emergency = 4'b0000;
    car_n = 0; car_s = 0; car_e = 0; car_w = 0;

    #20 reset = 0;

    car_n = 1; #20; car_n = 0;      
    #200;                           
    car_s = 1; #20; car_s = 0;     
    #200;                           

    car_w = 1; #20; car_w = 0;      
    #30;                            
    emergency = 4'b1000; #20;      
    emergency = 4'b0000; #20;
    car_e = 1; #20; car_e = 0; 
    #200;
    
     car_s = 1; #20; car_s = 0;      
    #20; 
    pedestrian_button = 1;#20;
    pedestrian_button = 0;
    
    #200; 
    $finish;
  end

endmodule