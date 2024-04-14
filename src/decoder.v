
/*
      -- 1 --
     |       |
     6       2
     |       |
      -- 7 --
     |       |
     5       3
     |       |
      -- 4 --
*/

module seg7 #( parameter BASE = 51 ) (
    input wire [7:0] counter,
    output reg [6:0] segments
);

    always @(*) begin
      if(counter < BASE) begin
        segments = 7'b0010000;
      end else if(counter < 2 * BASE) begin
        segments = 7'b0100000;
      end else if(counter < 3 * BASE) begin
        segments = 7'b0000001;
      end else if(counter < 4 * BASE) begin
        segments = 7'b0000010;
      end else begin
        segments = 7'b0000100;
      end
    end
endmodule

