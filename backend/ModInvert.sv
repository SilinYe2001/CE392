module ModInvert(
  input          clock,
  input          reset,
  output         din_ready, // @[\\src\\main\\scala\\operator\\ModInvert.scala 17:17]
  input          din_valid, // @[\\src\\main\\scala\\operator\\ModInvert.scala 17:17]
  input  [127:0] din_bits_base, // @[\\src\\main\\scala\\operator\\ModInvert.scala 17:17]
  input  [127:0] din_bits_mod, // @[\\src\\main\\scala\\operator\\ModInvert.scala 17:17]
  input          dout_ready, // @[\\src\\main\\scala\\operator\\ModInvert.scala 18:18]
  output         dout_valid, // @[\\src\\main\\scala\\operator\\ModInvert.scala 18:18]
  output [127:0] dout_bits_res // @[\\src\\main\\scala\\operator\\ModInvert.scala 18:18]
);
`ifdef RANDOMIZE_REG_INIT
  reg [127:0] _RAND_0;
  reg [127:0] _RAND_1;
  reg [159:0] _RAND_2;
  reg [159:0] _RAND_3;
  reg [127:0] _RAND_4;
  reg [127:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [127:0] u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 20:20]
  reg [127:0] v; // @[\\src\\main\\scala\\operator\\ModInvert.scala 21:20]
  reg [128:0] x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20]
  reg [128:0] y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20]
  reg [127:0] res; // @[\\src\\main\\scala\\operator\\ModInvert.scala 24:22]
  reg [127:0] mod; // @[\\src\\main\\scala\\operator\\ModInvert.scala 25:22]
  reg [2:0] status; // @[\\src\\main\\scala\\operator\\ModInvert.scala 31:25]
  wire [2:0] _GEN_1 = u != 128'h0 ? 3'h3 : 3'h5; // @[\\src\\main\\scala\\operator\\ModInvert.scala 55:28 56:24 58:24]
  wire  _T_14 = ~u[0]; // @[\\src\\main\\scala\\operator\\ModInvert.scala 62:23]
  wire  _T_16 = ~v[0]; // @[\\src\\main\\scala\\operator\\ModInvert.scala 62:39]
  wire [127:0] _u_T = {{1'd0}, u[127:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 63:24]
  wire [127:0] _v_T = {{1'd0}, v[127:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 64:24]
  wire [128:0] _x_T = {{1'd0}, x[128:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 66:28]
  wire [128:0] _GEN_72 = {{1'd0}, mod}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 68:29]
  wire [128:0] _x_T_2 = x + _GEN_72; // @[\\src\\main\\scala\\operator\\ModInvert.scala 68:29]
  wire [128:0] _x_T_3 = {{1'd0}, _x_T_2[128:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 68:36]
  wire [128:0] _GEN_2 = ~x[0] ? _x_T : _x_T_3; // @[\\src\\main\\scala\\operator\\ModInvert.scala 65:35 66:23 68:23]
  wire [128:0] _y_T = {{1'd0}, y[128:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 71:28]
  wire [128:0] _y_T_2 = y + _GEN_72; // @[\\src\\main\\scala\\operator\\ModInvert.scala 73:29]
  wire [128:0] _y_T_3 = {{1'd0}, _y_T_2[128:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 73:36]
  wire [128:0] _GEN_3 = ~y[0] ? _y_T : _y_T_3; // @[\\src\\main\\scala\\operator\\ModInvert.scala 70:35 71:23 73:23]
  wire [127:0] _GEN_6 = u[0] & _T_16 ? {{1'd0}, v[127:1]} : v; // @[\\src\\main\\scala\\operator\\ModInvert.scala 84:53 85:19 21:20]
  wire [128:0] _GEN_7 = u[0] & _T_16 ? _GEN_3 : y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20 84:53]
  wire [2:0] _GEN_8 = u[0] & _T_16 ? status : 3'h4; // @[\\src\\main\\scala\\operator\\ModInvert.scala 31:25 84:53 92:24]
  wire [127:0] _GEN_9 = _T_14 & v[0] ? {{1'd0}, u[127:1]} : u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 76:53 77:19 20:20]
  wire [128:0] _GEN_10 = _T_14 & v[0] ? _GEN_2 : x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20 76:53]
  wire [2:0] _GEN_11 = _T_14 & v[0] ? 3'h4 : _GEN_8; // @[\\src\\main\\scala\\operator\\ModInvert.scala 76:53 83:24]
  wire [127:0] _GEN_12 = _T_14 & v[0] ? v : _GEN_6; // @[\\src\\main\\scala\\operator\\ModInvert.scala 21:20 76:53]
  wire [128:0] _GEN_13 = _T_14 & v[0] ? y : _GEN_7; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20 76:53]
  wire [127:0] _GEN_14 = ~u[0] & ~v[0] ? _u_T : _GEN_9; // @[\\src\\main\\scala\\operator\\ModInvert.scala 62:47 63:19]
  wire [127:0] _GEN_15 = ~u[0] & ~v[0] ? _v_T : _GEN_12; // @[\\src\\main\\scala\\operator\\ModInvert.scala 62:47 64:19]
  wire [128:0] _GEN_16 = ~u[0] & ~v[0] ? _GEN_2 : _GEN_10; // @[\\src\\main\\scala\\operator\\ModInvert.scala 62:47]
  wire [128:0] _GEN_17 = ~u[0] & ~v[0] ? _GEN_3 : _GEN_13; // @[\\src\\main\\scala\\operator\\ModInvert.scala 62:47]
  wire [2:0] _GEN_18 = ~u[0] & ~v[0] ? 3'h4 : _GEN_11; // @[\\src\\main\\scala\\operator\\ModInvert.scala 62:47 75:24]
  wire [127:0] _u_T_3 = u - v; // @[\\src\\main\\scala\\operator\\ModInvert.scala 97:24]
  wire [128:0] _x_T_9 = x - y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 99:28]
  wire [128:0] _x_T_13 = _x_T_2 - y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 101:36]
  wire [128:0] _GEN_19 = x >= y ? _x_T_9 : _x_T_13; // @[\\src\\main\\scala\\operator\\ModInvert.scala 101:23 98:29 99:23]
  wire [127:0] _v_T_3 = v - u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 105:24]
  wire [128:0] _y_T_9 = y - x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 107:28]
  wire [128:0] _y_T_13 = _y_T_2 - x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 109:36]
  wire [128:0] _GEN_20 = y >= x ? _y_T_9 : _y_T_13; // @[\\src\\main\\scala\\operator\\ModInvert.scala 106:29 107:23 109:23]
  wire [127:0] _GEN_21 = u >= v ? _u_T_3 : u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 96:25 97:19 20:20]
  wire [128:0] _GEN_22 = u >= v ? _GEN_19 : x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20 96:25]
  wire [127:0] _GEN_24 = u >= v ? v : _v_T_3; // @[\\src\\main\\scala\\operator\\ModInvert.scala 105:19 21:20 96:25]
  wire [128:0] _GEN_25 = u >= v ? y : _GEN_20; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20 96:25]
  wire [128:0] _res_T_2 = y - _GEN_72; // @[\\src\\main\\scala\\operator\\ModInvert.scala 115:35]
  wire [128:0] _res_T_3 = y > _GEN_72 ? _res_T_2 : y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 115:23]
  wire [2:0] _GEN_26 = din_valid ? 3'h1 : 3'h5; // @[\\src\\main\\scala\\operator\\ModInvert.scala 119:28 120:24 122:24]
  wire [128:0] _GEN_27 = 3'h5 == status ? _res_T_3 : {{1'd0}, res}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 115:17 37:19 24:22]
  wire [2:0] _GEN_29 = 3'h5 == status ? _GEN_26 : status; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 31:25]
  wire [127:0] _GEN_30 = 3'h4 == status ? _GEN_21 : u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 20:20]
  wire [128:0] _GEN_31 = 3'h4 == status ? _GEN_22 : x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 22:20]
  wire [2:0] _GEN_32 = 3'h4 == status ? 3'h2 : _GEN_29; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [127:0] _GEN_33 = 3'h4 == status ? _GEN_24 : v; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 21:20]
  wire [128:0] _GEN_34 = 3'h4 == status ? _GEN_25 : y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 23:20]
  wire [128:0] _GEN_35 = 3'h4 == status ? {{1'd0}, res} : _GEN_27; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire  _GEN_36 = 3'h4 == status ? 1'h0 : 3'h5 == status; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  wire [127:0] _GEN_37 = 3'h3 == status ? _GEN_14 : _GEN_30; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [127:0] _GEN_38 = 3'h3 == status ? _GEN_15 : _GEN_33; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [128:0] _GEN_39 = 3'h3 == status ? _GEN_16 : _GEN_31; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [128:0] _GEN_40 = 3'h3 == status ? _GEN_17 : _GEN_34; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [2:0] _GEN_41 = 3'h3 == status ? _GEN_18 : _GEN_32; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [128:0] _GEN_42 = 3'h3 == status ? {{1'd0}, res} : _GEN_35; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire  _GEN_43 = 3'h3 == status ? 1'h0 : _GEN_36; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  wire [128:0] _GEN_49 = 3'h2 == status ? {{1'd0}, res} : _GEN_42; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire  _GEN_50 = 3'h2 == status ? 1'h0 : _GEN_43; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  wire [128:0] _GEN_57 = 3'h1 == status ? {{1'd0}, res} : _GEN_49; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire  _GEN_58 = 3'h1 == status ? 1'h0 : _GEN_50; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  wire [128:0] _GEN_66 = 3'h0 == status ? {{1'd0}, res} : _GEN_57; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire [128:0] _GEN_87 = reset ? 129'h0 : _GEN_66; // @[\\src\\main\\scala\\operator\\ModInvert.scala 24:{22,22}]
  assign din_ready = 3'h0 == status | _GEN_58; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 39:23]
  assign dout_valid = 3'h0 == status ? 1'h0 : _GEN_58; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  assign dout_bits_res = res; // @[\\src\\main\\scala\\operator\\ModInvert.scala 126:35 127:23]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 20:20]
      u <= 128'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 20:20]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        u <= din_bits_base; // @[\\src\\main\\scala\\operator\\ModInvert.scala 47:15]
      end else if (!(3'h2 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        u <= _GEN_37;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 21:20]
      v <= 128'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 21:20]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        v <= din_bits_mod; // @[\\src\\main\\scala\\operator\\ModInvert.scala 48:15]
      end else if (!(3'h2 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        v <= _GEN_38;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20]
      x <= 129'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        x <= 129'h1; // @[\\src\\main\\scala\\operator\\ModInvert.scala 50:15]
      end else if (!(3'h2 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        x <= _GEN_39;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20]
      y <= 129'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        y <= 129'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 51:15]
      end else if (!(3'h2 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        y <= _GEN_40;
      end
    end
    res <= _GEN_87[127:0]; // @[\\src\\main\\scala\\operator\\ModInvert.scala 24:{22,22}]
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 25:22]
      mod <= 128'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 25:22]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        mod <= din_bits_mod; // @[\\src\\main\\scala\\operator\\ModInvert.scala 49:17]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 31:25]
      status <= 3'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 31:25]
    end else if (3'h0 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      status <= {{2'd0}, din_valid};
    end else if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      status <= 3'h2; // @[\\src\\main\\scala\\operator\\ModInvert.scala 52:20]
    end else if (3'h2 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      status <= _GEN_1;
    end else begin
      status <= _GEN_41;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {4{`RANDOM}};
  u = _RAND_0[127:0];
  _RAND_1 = {4{`RANDOM}};
  v = _RAND_1[127:0];
  _RAND_2 = {5{`RANDOM}};
  x = _RAND_2[128:0];
  _RAND_3 = {5{`RANDOM}};
  y = _RAND_3[128:0];
  _RAND_4 = {4{`RANDOM}};
  res = _RAND_4[127:0];
  _RAND_5 = {4{`RANDOM}};
  mod = _RAND_5[127:0];
  _RAND_6 = {1{`RANDOM}};
  status = _RAND_6[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
