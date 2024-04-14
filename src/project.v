/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_wuehr1999_servotester #( parameter MAX_COUNT = 200000, parameter MAX_SIG = 40, parameter DEC_BASE = 51 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire reset = ! rst_n;
  
  reg [20 : 0] counter;
  reg [20 : 0] signal_counter;
  reg [7: 0] signal;
  assign uio_oe = 8'b11111111;
  assign uio_out[7] = signal < ui_in | counter > (MAX_COUNT - MAX_SIG * DEC_BASE);
  assign uio_out[6 : 0] = 0;
  assign uo_out = ui_in;

  always @(posedge clk) begin
    if(reset) begin
      counter <= 0;
      signal <= 0;
      signal_counter <= 0;
    end else if(ena) begin
      if(counter > MAX_COUNT) begin
          counter <= 0;
          signal <= 0;
          signal_counter <= 0;
      end else begin
        counter <= counter + 1;
        if(signal_counter > MAX_SIG) begin
          signal_counter <= 0;
          if(signal < ui_in) begin
            signal <= signal + 1;
          end
        end else begin
          signal_counter <= signal_counter + 1;
        end
      end
    end
  end
endmodule

