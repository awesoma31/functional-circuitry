`timescale 1ns/1ps

module fec_saylinx_board_top_tb;
    reg         CLK;
    reg         RST_N;

    reg         KEY2_N;
    reg         KEY3_N;
    reg         KEY4_N;

    // GPIO
    reg  [16:0] GPIO_0_input_pullup;
    wire [16:0] GPIO_0_out_zero_value;

    reg  [16:0] GPIO_1_input_pullup;
    wire [16:0] GPIO_1_out_zero_value;

    wire [3:0]  LED;
    wire [7:0]  SEG_DATA;
    wire [7:0]  SEG_SEL;

    fec_saylinx_board_top dut (
        .CLK                 (CLK),
        .RST_N               (RST_N),
        .KEY2_N              (KEY2_N),
        .KEY3_N              (KEY3_N),
        .KEY4_N              (KEY4_N),
        .LED                 (LED),
        .SEG_DATA            (SEG_DATA),
        .SEG_SEL             (SEG_SEL),
        .GPIO_0_out_zero_value (GPIO_0_out_zero_value),
        .GPIO_0_input_pullup   (GPIO_0_input_pullup),
        .GPIO_1_out_zero_value (GPIO_1_out_zero_value),
        .GPIO_1_input_pullup   (GPIO_1_input_pullup)
    );

    initial begin
        CLK = 1'b0;
        forever #5 CLK = ~CLK;  
    end

    task press_key2;
    begin
        KEY2_N = 1'b0;                    
        repeat (1100000) @(posedge CLK);  
        KEY2_N = 1'b1;                    
        repeat (20) @(posedge CLK);       
    end
    endtask

    task press_key3;
    begin
        KEY3_N = 1'b0;
        repeat (1100000) @(posedge CLK);
        KEY3_N = 1'b1;
        repeat (20) @(posedge CLK);
    end
    endtask

    task press_key4;
    begin
        KEY4_N = 1'b0;
        repeat (1100000) @(posedge CLK);
        KEY4_N = 1'b1;
        repeat (20) @(posedge CLK);
    end
    endtask

    task run_case(input [7:0] a, input [7:0] b);
    begin

        GPIO_0_input_pullup[7:0]   = ~a;
        GPIO_0_input_pullup[15:8]  = ~b;
        GPIO_0_input_pullup[16]    = 1'b1;

        press_key2;

        press_key4;

        press_key3;

        wait (LED[3] == 1'b1);
		  
        repeat (1000) @(posedge CLK);
    end
    endtask

    initial begin
        RST_N               = 1'b0;  
        KEY2_N              = 1'b1;
        KEY3_N              = 1'b1;
        KEY4_N              = 1'b1;
        GPIO_0_input_pullup = 17'h1FFFF; 
        GPIO_1_input_pullup = 17'h1FFFF;

        repeat (10) @(posedge CLK);
        RST_N = 1'b1;  

        repeat (1000) @(posedge CLK);

        // a = 8'd5, b = 8'd3
        run_case(8'd5, 8'd3);

        repeat (500000) @(posedge CLK);

        // a = 8'd10, b = 8'd7
        run_case(8'd10, 8'd7);

        repeat (500000) @(posedge CLK);
        $stop;
    end

    initial begin
        $display("Time(ns)\tLED\tSEG_DATA\tSEG_SEL\tGPIO0[15:0]");
        $monitor("%0t\t%b\t%h\t%h\t%h",
                 $time, LED, SEG_DATA, SEG_SEL, GPIO_0_input_pullup[15:0]);
    end

endmodule