`timescale 1ns/1ps

module func_tb;  
  reg clk = 0;
  reg rst = 1;

  reg        start = 0;
  reg [7:0]  a = 0, b = 0;

  wire       busy;
  wire       valid;
  wire [23:0] y;

  func dut (
    .clk(clk), .rst(rst),
    .start(start),
    .a(a), .b(b),
    .busy(busy), .valid(valid), .y(y)
  );

  // 100 ???: ?????? 10 ??
  always #5 clk = ~clk;

// ?????????? ??????? ??????
  integer cycle = 0;
  always @(posedge clk) cycle <= cycle + 1;

  // helper: ????? ???????????
  task run_case(input [7:0] ta, input [7:0] tb, input [23:0] expected, input [255:0] name);
      integer c_start, c_done, lat;
  begin
      @(negedge clk);
      a <= ta; b <= tb;
      start <= 1'b1;
      c_start = cycle;             
      @(negedge clk);
      start <= 1'b0;
    
      @(posedge valid);
      c_done = cycle;              
      lat = c_done - c_start;      
    
      if (y !== expected) begin
        $display("[FAIL] %0s: a=%0d b=%0d  got=%0d exp=%0d", name, ta, tb, y, expected);
        $fatal(1);
      end

      $display("[OK] ? %0s: y=%0d  LAT = %0d cycles  (~%0d ns)",
               name, y, lat, lat*10);
    
      repeat(2) @(posedge clk);
    end
    endtask


  initial begin
  $dumpfile("func_tb.vcd");
  $dumpvars(0, func_tb);

  repeat(5) @(posedge clk);
  rst <= 1'b0;

  run_case(8'd3,   8'd4,   24'd39,        "SMALL");
  run_case(8'd255, 8'd255, 24'd16646400,  "MAX");

  run_case(8'd0,   8'd0,   24'd0,         "T0");
  run_case(8'd1,   8'd0,   24'd1,         "T1");          // 1*0 + 1^3 = 1
  run_case(8'd0,   8'd1,   24'd0,         "T2");          // 0*1 + 0^3 = 0
  run_case(8'd7,   8'd5,   24'd378,       "T3");          // 7*5 + 343 = 378
  run_case(8'd10,  8'd10,  24'd1100,      "T4");          // 100 + 1000
  run_case(8'd15,  8'd2,   24'd3405,      "T5");          // 30 + 3375
  run_case(8'd37,  8'd19,  24'd51356,     "T6");          // 703 + 50653
  run_case(8'd128, 8'd1,   24'd2097280,   "T7");          // 128 + 2,097,152
  run_case(8'd200, 8'd53,  24'd8010600,   "T8");          // 10,600 + 8,000,000
  run_case(8'd255, 8'd0,   24'd16581375,  "T9");          // 0 + 255^3

  $finish;

  end
endmodule
