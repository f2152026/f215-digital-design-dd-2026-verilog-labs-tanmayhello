// rca64.v
//
// A plain 64-bit ripple-carry adder.
//
// The circuit consists of 64 one-bit FA_Gate instances. The carry-out
// from each full adder becomes the carry-in of the next full adder.
//
// FA_Gate already contains the required gate delays, so no additional
// delays are needed on the FA_Gate instantiations here.

module rca64(

  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout

);

  // c[i] is the carry entering bit i.
  // c[0] is the external carry-in.
  // c[64] is the final carry-out.
  wire [64:0] c;

  // Connect the external carry-in to the first full adder.
  assign c[0] = cin;

  // Instantiate 64 full adders.
  //
  // FA 0:
  //   a[0], b[0], c[0] -> sum[0], c[1]
  //
  // FA 1:
  //   a[1], b[1], c[1] -> sum[1], c[2]
  //
  // ...
  //
  // FA 63:
  //   a[63], b[63], c[63] -> sum[63], c[64]

  genvar i;

  generate
    for (i = 0; i < 64; i = i + 1) begin : gen_fa

      FA_Gate FA (
        .a(a[i]),
        .b(b[i]),
        .cin(c[i]),
        .sum(sum[i]),
        .cout(c[i+1])
      );

    end
  endgenerate

  // Final carry-out.
  assign cout = c[64];

endmodule