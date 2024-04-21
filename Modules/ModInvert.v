module ModInvert(
  input           clock,
  input           reset,
  output          din_ready, // @[\\src\\main\\scala\\operator\\ModInvert.scala 17:17]
  input           din_valid, // @[\\src\\main\\scala\\operator\\ModInvert.scala 17:17]
  input  [1023:0] din_bits_base, // @[\\src\\main\\scala\\operator\\ModInvert.scala 17:17]
  input  [1023:0] din_bits_mod, // @[\\src\\main\\scala\\operator\\ModInvert.scala 17:17]
  input           dout_ready, // @[\\src\\main\\scala\\operator\\ModInvert.scala 18:18]
  output          dout_valid, // @[\\src\\main\\scala\\operator\\ModInvert.scala 18:18]
  output [1023:0] dout_bits_res // @[\\src\\main\\scala\\operator\\ModInvert.scala 18:18]
);
`ifdef RANDOMIZE_REG_INIT
  reg [1023:0] _RAND_0;
  reg [1023:0] _RAND_1;
  reg [1055:0] _RAND_2;
  reg [1055:0] _RAND_3;
  reg [1023:0] _RAND_4;
  reg [1023:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [1023:0] u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 20:20]
  reg [1023:0] v; // @[\\src\\main\\scala\\operator\\ModInvert.scala 21:20]
  reg [1024:0] x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20]
  reg [1024:0] y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20]
  reg [1023:0] res; // @[\\src\\main\\scala\\operator\\ModInvert.scala 24:22]
  reg [1023:0] mod; // @[\\src\\main\\scala\\operator\\ModInvert.scala 25:22]
  reg [2:0] status; // @[\\src\\main\\scala\\operator\\ModInvert.scala 31:25]
  wire  _T_3 = din_ready & din_valid; // @[\\src\\main\\scala\\operator\\ModInvert.scala 39:28]
  wire [2:0] _GEN_1 = u != 1024'h0 ? 3'h3 : 3'h5; // @[\\src\\main\\scala\\operator\\ModInvert.scala 54:28 55:24 57:24]
  wire  _T_15 = ~u[0]; // @[\\src\\main\\scala\\operator\\ModInvert.scala 61:23]
  wire  _T_17 = ~v[0]; // @[\\src\\main\\scala\\operator\\ModInvert.scala 61:39]
  wire [1023:0] _u_T = {{1'd0}, u[1023:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 62:24]
  wire [1023:0] _v_T = {{1'd0}, v[1023:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 63:24]
  wire [1024:0] _x_T = {{1'd0}, x[1024:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 65:28]
  wire [1024:0] _GEN_70 = {{1'd0}, mod}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 67:29]
  wire [1024:0] _x_T_2 = x + _GEN_70; // @[\\src\\main\\scala\\operator\\ModInvert.scala 67:29]
  wire [1024:0] _x_T_3 = {{1'd0}, _x_T_2[1024:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 67:36]
  wire [1024:0] _GEN_2 = ~x[0] ? _x_T : _x_T_3; // @[\\src\\main\\scala\\operator\\ModInvert.scala 64:35 65:23 67:23]
  wire [1024:0] _y_T = {{1'd0}, y[1024:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 70:28]
  wire [1024:0] _y_T_2 = y + _GEN_70; // @[\\src\\main\\scala\\operator\\ModInvert.scala 72:29]
  wire [1024:0] _y_T_3 = {{1'd0}, _y_T_2[1024:1]}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 72:36]
  wire [1024:0] _GEN_3 = ~y[0] ? _y_T : _y_T_3; // @[\\src\\main\\scala\\operator\\ModInvert.scala 69:35 70:23 72:23]
  wire [1023:0] _GEN_6 = u[0] & _T_17 ? {{1'd0}, v[1023:1]} : v; // @[\\src\\main\\scala\\operator\\ModInvert.scala 83:53 84:19 21:20]
  wire [1024:0] _GEN_7 = u[0] & _T_17 ? _GEN_3 : y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20 83:53]
  wire [2:0] _GEN_8 = u[0] & _T_17 ? status : 3'h4; // @[\\src\\main\\scala\\operator\\ModInvert.scala 31:25 83:53 91:24]
  wire [1023:0] _GEN_9 = _T_15 & v[0] ? {{1'd0}, u[1023:1]} : u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 75:53 76:19 20:20]
  wire [1024:0] _GEN_10 = _T_15 & v[0] ? _GEN_2 : x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20 75:53]
  wire [2:0] _GEN_11 = _T_15 & v[0] ? 3'h4 : _GEN_8; // @[\\src\\main\\scala\\operator\\ModInvert.scala 75:53 82:24]
  wire [1023:0] _GEN_12 = _T_15 & v[0] ? v : _GEN_6; // @[\\src\\main\\scala\\operator\\ModInvert.scala 21:20 75:53]
  wire [1024:0] _GEN_13 = _T_15 & v[0] ? y : _GEN_7; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20 75:53]
  wire [1023:0] _GEN_14 = ~u[0] & ~v[0] ? _u_T : _GEN_9; // @[\\src\\main\\scala\\operator\\ModInvert.scala 61:47 62:19]
  wire [1023:0] _GEN_15 = ~u[0] & ~v[0] ? _v_T : _GEN_12; // @[\\src\\main\\scala\\operator\\ModInvert.scala 61:47 63:19]
  wire [1024:0] _GEN_16 = ~u[0] & ~v[0] ? _GEN_2 : _GEN_10; // @[\\src\\main\\scala\\operator\\ModInvert.scala 61:47]
  wire [1024:0] _GEN_17 = ~u[0] & ~v[0] ? _GEN_3 : _GEN_13; // @[\\src\\main\\scala\\operator\\ModInvert.scala 61:47]
  wire [2:0] _GEN_18 = ~u[0] & ~v[0] ? 3'h4 : _GEN_11; // @[\\src\\main\\scala\\operator\\ModInvert.scala 61:47 74:24]
  wire [1023:0] _u_T_3 = u - v; // @[\\src\\main\\scala\\operator\\ModInvert.scala 96:24]
  wire [1024:0] _x_T_9 = x - y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 98:28]
  wire [1024:0] _x_T_13 = _x_T_2 - y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 100:36]
  wire [1024:0] _GEN_19 = x >= y ? _x_T_9 : _x_T_13; // @[\\src\\main\\scala\\operator\\ModInvert.scala 100:23 97:29 98:23]
  wire [1023:0] _v_T_3 = v - u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 104:24]
  wire [1024:0] _y_T_9 = y - x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 106:28]
  wire [1024:0] _y_T_13 = _y_T_2 - x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 108:36]
  wire [1024:0] _GEN_20 = y >= x ? _y_T_9 : _y_T_13; // @[\\src\\main\\scala\\operator\\ModInvert.scala 105:29 106:23 108:23]
  wire [1023:0] _GEN_21 = u >= v ? _u_T_3 : u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 95:25 96:19 20:20]
  wire [1024:0] _GEN_22 = u >= v ? _GEN_19 : x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20 95:25]
  wire [1023:0] _GEN_24 = u >= v ? v : _v_T_3; // @[\\src\\main\\scala\\operator\\ModInvert.scala 104:19 21:20 95:25]
  wire [1024:0] _GEN_25 = u >= v ? y : _GEN_20; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20 95:25]
  wire [1024:0] _res_T_2 = y - _GEN_70; // @[\\src\\main\\scala\\operator\\ModInvert.scala 114:35]
  wire [1024:0] _res_T_3 = y > _GEN_70 ? _res_T_2 : y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 114:23]
  wire [1024:0] _GEN_26 = 3'h5 == status ? _res_T_3 : {{1'd0}, res}; // @[\\src\\main\\scala\\operator\\ModInvert.scala 114:17 37:19 24:22]
  wire [2:0] _GEN_28 = 3'h5 == status ? 3'h0 : status; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 116:20 31:25]
  wire [1023:0] _GEN_29 = 3'h4 == status ? _GEN_21 : u; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 20:20]
  wire [1024:0] _GEN_30 = 3'h4 == status ? _GEN_22 : x; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 22:20]
  wire [2:0] _GEN_31 = 3'h4 == status ? 3'h2 : _GEN_28; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [1023:0] _GEN_32 = 3'h4 == status ? _GEN_24 : v; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 21:20]
  wire [1024:0] _GEN_33 = 3'h4 == status ? _GEN_25 : y; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 23:20]
  wire [1024:0] _GEN_34 = 3'h4 == status ? {{1'd0}, res} : _GEN_26; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire  _GEN_35 = 3'h4 == status ? 1'h0 : 3'h5 == status; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  wire [1023:0] _GEN_36 = 3'h3 == status ? _GEN_14 : _GEN_29; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [1023:0] _GEN_37 = 3'h3 == status ? _GEN_15 : _GEN_32; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [1024:0] _GEN_38 = 3'h3 == status ? _GEN_16 : _GEN_30; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [1024:0] _GEN_39 = 3'h3 == status ? _GEN_17 : _GEN_33; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [2:0] _GEN_40 = 3'h3 == status ? _GEN_18 : _GEN_31; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
  wire [1024:0] _GEN_41 = 3'h3 == status ? {{1'd0}, res} : _GEN_34; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire  _GEN_42 = 3'h3 == status ? 1'h0 : _GEN_35; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  wire [1024:0] _GEN_48 = 3'h2 == status ? {{1'd0}, res} : _GEN_41; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire  _GEN_49 = 3'h2 == status ? 1'h0 : _GEN_42; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  wire [1024:0] _GEN_56 = 3'h1 == status ? {{1'd0}, res} : _GEN_48; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire  _GEN_57 = 3'h1 == status ? 1'h0 : _GEN_49; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  wire [1024:0] _GEN_64 = 3'h0 == status ? {{1'd0}, res} : _GEN_56; // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19 24:22]
  wire [1024:0] _GEN_85 = reset ? 1025'h0 : _GEN_64; // @[\\src\\main\\scala\\operator\\ModInvert.scala 24:{22,22}]
  assign din_ready = 1'h1; // @[\\src\\main\\scala\\operator\\ModInvert.scala 33:15]
  assign dout_valid = 3'h0 == status ? 1'h0 : _GEN_57; // @[\\src\\main\\scala\\operator\\ModInvert.scala 35:16 37:19]
  assign dout_bits_res = res; // @[\\src\\main\\scala\\operator\\ModInvert.scala 119:35 120:23]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 20:20]
      u <= 1024'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 20:20]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        u <= din_bits_base; // @[\\src\\main\\scala\\operator\\ModInvert.scala 46:15]
      end else if (!(3'h2 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        u <= _GEN_36;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 21:20]
      v <= 1024'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 21:20]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        v <= din_bits_mod; // @[\\src\\main\\scala\\operator\\ModInvert.scala 47:15]
      end else if (!(3'h2 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        v <= _GEN_37;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20]
      x <= 1025'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 22:20]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        x <= 1025'h1; // @[\\src\\main\\scala\\operator\\ModInvert.scala 49:15]
      end else if (!(3'h2 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        x <= _GEN_38;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20]
      y <= 1025'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 23:20]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        y <= 1025'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 50:15]
      end else if (!(3'h2 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        y <= _GEN_39;
      end
    end
    res <= _GEN_85[1023:0]; // @[\\src\\main\\scala\\operator\\ModInvert.scala 24:{22,22}]
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 25:22]
      mod <= 1024'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 25:22]
    end else if (!(3'h0 == status)) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
        mod <= din_bits_mod; // @[\\src\\main\\scala\\operator\\ModInvert.scala 48:17]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 31:25]
      status <= 3'h0; // @[\\src\\main\\scala\\operator\\ModInvert.scala 31:25]
    end else if (3'h0 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      status <= {{2'd0}, _T_3};
    end else if (3'h1 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      status <= 3'h2; // @[\\src\\main\\scala\\operator\\ModInvert.scala 51:20]
    end else if (3'h2 == status) begin // @[\\src\\main\\scala\\operator\\ModInvert.scala 37:19]
      status <= _GEN_1;
    end else begin
      status <= _GEN_40;
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
  _RAND_0 = {32{`RANDOM}};
  u = _RAND_0[1023:0];
  _RAND_1 = {32{`RANDOM}};
  v = _RAND_1[1023:0];
  _RAND_2 = {33{`RANDOM}};
  x = _RAND_2[1024:0];
  _RAND_3 = {33{`RANDOM}};
  y = _RAND_3[1024:0];
  _RAND_4 = {32{`RANDOM}};
  res = _RAND_4[1023:0];
  _RAND_5 = {32{`RANDOM}};
  mod = _RAND_5[1023:0];
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
