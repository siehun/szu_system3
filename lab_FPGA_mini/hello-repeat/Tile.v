module CSR(
  input         clock,
  input         reset,
  input         io_stall,
  input  [2:0]  io_cmd,
  input  [31:0] io_in,
  output [31:0] io_out,
  input  [31:0] io_pc,
  input  [31:0] io_addr,
  input  [31:0] io_inst,
  input         io_illegal,
  input  [1:0]  io_st_type,
  input  [2:0]  io_ld_type,
  input         io_pc_check,
  output        io_expt,
  output [31:0] io_evec,
  output [31:0] io_epc
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  wire [11:0] csr_addr = io_inst[31:20]; // @[CSR.scala 137:25]
  wire [4:0] rs1_addr = io_inst[19:15]; // @[CSR.scala 138:25]
  reg [31:0] time_; // @[CSR.scala 141:21]
  reg [31:0] timeh; // @[CSR.scala 142:22]
  reg [31:0] cycle; // @[CSR.scala 143:22]
  reg [31:0] cycleh; // @[CSR.scala 144:23]
  reg [31:0] instret; // @[CSR.scala 145:24]
  reg [31:0] instreth; // @[CSR.scala 146:25]
  reg [1:0] PRV; // @[CSR.scala 158:20]
  reg [1:0] PRV1; // @[CSR.scala 159:21]
  reg  IE; // @[CSR.scala 162:19]
  reg  IE1; // @[CSR.scala 163:20]
  wire [31:0] mstatus = {22'h0,3'h0,1'h0,PRV1,IE1,PRV,IE}; // @[Cat.scala 31:58]
  reg  MTIP; // @[CSR.scala 179:21]
  reg  MTIE; // @[CSR.scala 182:21]
  reg  MSIP; // @[CSR.scala 185:21]
  reg  MSIE; // @[CSR.scala 188:21]
  wire [31:0] mip = {24'h0,MTIP,1'h0,2'h0,MSIP,1'h0,2'h0}; // @[Cat.scala 31:58]
  wire [31:0] mie = {24'h0,MTIE,1'h0,2'h0,MSIE,1'h0,2'h0}; // @[Cat.scala 31:58]
  reg [31:0] mtimecmp; // @[CSR.scala 194:21]
  reg [31:0] mscratch; // @[CSR.scala 196:21]
  reg [31:0] mepc; // @[CSR.scala 198:17]
  reg [31:0] mcause; // @[CSR.scala 199:19]
  reg [31:0] mbadaddr; // @[CSR.scala 200:21]
  reg [31:0] mtohost; // @[CSR.scala 202:24]
  reg [31:0] mfromhost; // @[CSR.scala 203:22]
  wire  _io_out_T_1 = 12'hc00 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_3 = 12'hc01 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_5 = 12'hc02 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_7 = 12'hc80 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_9 = 12'hc81 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_11 = 12'hc82 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_13 = 12'h900 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_15 = 12'h901 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_17 = 12'h902 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_19 = 12'h980 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_21 = 12'h981 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_23 = 12'h982 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_25 = 12'hf00 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_27 = 12'hf01 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_29 = 12'hf10 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_31 = 12'h301 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_33 = 12'h302 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_35 = 12'h304 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_37 = 12'h321 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_39 = 12'h701 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_41 = 12'h741 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_43 = 12'h340 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_45 = 12'h341 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_47 = 12'h342 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_49 = 12'h343 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_51 = 12'h344 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_53 = 12'h780 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_55 = 12'h781 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_57 = 12'h300 == csr_addr; // @[Lookup.scala 31:38]
  wire [31:0] _io_out_T_58 = _io_out_T_57 ? mstatus : 32'h0; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_59 = _io_out_T_55 ? mfromhost : _io_out_T_58; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_60 = _io_out_T_53 ? mtohost : _io_out_T_59; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_61 = _io_out_T_51 ? mip : _io_out_T_60; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_62 = _io_out_T_49 ? mbadaddr : _io_out_T_61; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_63 = _io_out_T_47 ? mcause : _io_out_T_62; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_64 = _io_out_T_45 ? mepc : _io_out_T_63; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_65 = _io_out_T_43 ? mscratch : _io_out_T_64; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_66 = _io_out_T_41 ? timeh : _io_out_T_65; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_67 = _io_out_T_39 ? time_ : _io_out_T_66; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_68 = _io_out_T_37 ? mtimecmp : _io_out_T_67; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_69 = _io_out_T_35 ? mie : _io_out_T_68; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_70 = _io_out_T_33 ? 32'h0 : _io_out_T_69; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_71 = _io_out_T_31 ? 32'h100 : _io_out_T_70; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_72 = _io_out_T_29 ? 32'h0 : _io_out_T_71; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_73 = _io_out_T_27 ? 32'h0 : _io_out_T_72; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_74 = _io_out_T_25 ? 32'h100100 : _io_out_T_73; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_75 = _io_out_T_23 ? instreth : _io_out_T_74; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_76 = _io_out_T_21 ? timeh : _io_out_T_75; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_77 = _io_out_T_19 ? cycleh : _io_out_T_76; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_78 = _io_out_T_17 ? instret : _io_out_T_77; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_79 = _io_out_T_15 ? time_ : _io_out_T_78; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_80 = _io_out_T_13 ? cycle : _io_out_T_79; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_81 = _io_out_T_11 ? instreth : _io_out_T_80; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_82 = _io_out_T_9 ? timeh : _io_out_T_81; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_83 = _io_out_T_7 ? cycleh : _io_out_T_82; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_84 = _io_out_T_5 ? instret : _io_out_T_83; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_85 = _io_out_T_3 ? time_ : _io_out_T_84; // @[Lookup.scala 34:39]
  wire  privValid = csr_addr[9:8] <= PRV; // @[CSR.scala 243:34]
  wire  privInst = io_cmd == 3'h4; // @[CSR.scala 244:25]
  wire  _isEcall_T_2 = privInst & ~csr_addr[0]; // @[CSR.scala 245:26]
  wire  _isEcall_T_4 = ~csr_addr[8]; // @[CSR.scala 245:45]
  wire  isEcall = privInst & ~csr_addr[0] & ~csr_addr[8]; // @[CSR.scala 245:42]
  wire  isEbreak = privInst & csr_addr[0] & _isEcall_T_4; // @[CSR.scala 246:42]
  wire  isEret = _isEcall_T_2 & csr_addr[8]; // @[CSR.scala 247:41]
  wire  csrValid = _io_out_T_1 | _io_out_T_3 | _io_out_T_5 | _io_out_T_7 | _io_out_T_9 | _io_out_T_11 | _io_out_T_13 |
    _io_out_T_15 | _io_out_T_17 | _io_out_T_19 | _io_out_T_21 | _io_out_T_23 | _io_out_T_25 | _io_out_T_27 |
    _io_out_T_29 | _io_out_T_31 | _io_out_T_33 | _io_out_T_35 | _io_out_T_37 | _io_out_T_39 | _io_out_T_41 |
    _io_out_T_43 | _io_out_T_45 | _io_out_T_47 | _io_out_T_49 | _io_out_T_51 | _io_out_T_53 | _io_out_T_55 |
    _io_out_T_57; // @[CSR.scala 248:58]
  wire  csrRO = &csr_addr[11:10] | csr_addr == 12'h301 | csr_addr == 12'h302; // @[CSR.scala 249:63]
  wire  wen = io_cmd == 3'h1 | io_cmd[1] & |rs1_addr; // @[CSR.scala 250:30]
  wire [31:0] _wdata_T = io_out | io_in; // @[CSR.scala 256:24]
  wire [31:0] _wdata_T_1 = ~io_in; // @[CSR.scala 257:26]
  wire [31:0] _wdata_T_2 = io_out & _wdata_T_1; // @[CSR.scala 257:24]
  wire [31:0] _wdata_T_4 = 3'h1 == io_cmd ? io_in : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _wdata_T_6 = 3'h2 == io_cmd ? _wdata_T : _wdata_T_4; // @[Mux.scala 81:58]
  wire [31:0] wdata = 3'h3 == io_cmd ? _wdata_T_2 : _wdata_T_6; // @[Mux.scala 81:58]
  wire  iaddrInvalid = io_pc_check & io_addr[1]; // @[CSR.scala 260:34]
  wire  _laddrInvalid_T_1 = |io_addr[1:0]; // @[CSR.scala 264:40]
  wire  _laddrInvalid_T_7 = 3'h2 == io_ld_type ? io_addr[0] : 3'h1 == io_ld_type & _laddrInvalid_T_1; // @[Mux.scala 81:58]
  wire  laddrInvalid = 3'h4 == io_ld_type ? io_addr[0] : _laddrInvalid_T_7; // @[Mux.scala 81:58]
  wire  saddrInvalid = 2'h2 == io_st_type ? io_addr[0] : 2'h1 == io_st_type & _laddrInvalid_T_1; // @[Mux.scala 81:58]
  wire  _io_expt_T_6 = ~privValid; // @[CSR.scala 269:39]
  wire  _io_expt_T_8 = |io_cmd[1:0] & (~csrValid | ~privValid); // @[CSR.scala 269:22]
  wire  _io_expt_T_9 = io_illegal | iaddrInvalid | laddrInvalid | saddrInvalid | _io_expt_T_8; // @[CSR.scala 268:73]
  wire  _io_expt_T_13 = privInst & _io_expt_T_6; // @[CSR.scala 270:15]
  wire  _io_expt_T_14 = _io_expt_T_9 | wen & csrRO | _io_expt_T_13; // @[CSR.scala 269:67]
  wire [7:0] _io_evec_T = {PRV, 6'h0}; // @[CSR.scala 271:27]
  wire [31:0] _GEN_260 = {{24'd0}, _io_evec_T}; // @[CSR.scala 271:20]
  wire [31:0] _time_T_1 = time_ + 32'h1; // @[CSR.scala 275:16]
  wire [31:0] _timeh_T_1 = timeh + 32'h1; // @[CSR.scala 276:36]
  wire [31:0] _GEN_1 = &time_ ? _timeh_T_1 : timeh; // @[CSR.scala 276:19 142:22 276:27]
  wire [31:0] _cycle_T_1 = cycle + 32'h1; // @[CSR.scala 277:18]
  wire [31:0] _cycleh_T_1 = cycleh + 32'h1; // @[CSR.scala 278:39]
  wire [31:0] _GEN_2 = &cycle ? _cycleh_T_1 : cycleh; // @[CSR.scala 278:20 144:23 278:29]
  wire  _isInstRet_T_5 = ~io_stall; // @[CSR.scala 279:88]
  wire  isInstRet = io_inst != 32'h13 & (~io_expt | isEcall | isEbreak) & ~io_stall; // @[CSR.scala 279:85]
  wire [31:0] _instret_T_1 = instret + 32'h1; // @[CSR.scala 280:40]
  wire [31:0] _GEN_3 = isInstRet ? _instret_T_1 : instret; // @[CSR.scala 280:19 145:24 280:29]
  wire [31:0] _instreth_T_1 = instreth + 32'h1; // @[CSR.scala 281:58]
  wire [31:0] _GEN_4 = isInstRet & &instret ? _instreth_T_1 : instreth; // @[CSR.scala 146:25 281:{35,46}]
  wire [31:0] _mepc_T_1 = {io_pc[31:2], 2'h0}; // @[CSR.scala 285:26]
  wire [3:0] _GEN_261 = {{2'd0}, PRV}; // @[CSR.scala 295:38]
  wire [3:0] _mcause_T_1 = 4'h8 + _GEN_261; // @[CSR.scala 295:38]
  wire [1:0] _mcause_T_2 = isEbreak ? 2'h3 : 2'h2; // @[CSR.scala 295:48]
  wire [3:0] _mcause_T_3 = isEcall ? _mcause_T_1 : {{2'd0}, _mcause_T_2}; // @[CSR.scala 295:16]
  wire [3:0] _mcause_T_4 = saddrInvalid ? 4'h6 : _mcause_T_3; // @[CSR.scala 292:14]
  wire [3:0] _mcause_T_5 = laddrInvalid ? 4'h4 : _mcause_T_4; // @[CSR.scala 289:12]
  wire [3:0] _mcause_T_6 = iaddrInvalid ? 4'h0 : _mcause_T_5; // @[CSR.scala 286:20]
  wire [31:0] _mepc_T_2 = {{2'd0}, wdata[31:2]}; // @[CSR.scala 328:58]
  wire [33:0] _GEN_263 = {_mepc_T_2, 2'h0}; // @[CSR.scala 328:65]
  wire [34:0] _mepc_T_3 = {{1'd0}, _GEN_263}; // @[CSR.scala 328:65]
  wire [31:0] _mcause_T_7 = wdata & 32'h8000000f; // @[CSR.scala 329:62]
  wire [31:0] _GEN_6 = csr_addr == 12'h982 ? wdata : _GEN_4; // @[CSR.scala 338:{47,58}]
  wire [31:0] _GEN_7 = csr_addr == 12'h981 ? wdata : _GEN_1; // @[CSR.scala 337:{44,52}]
  wire [31:0] _GEN_8 = csr_addr == 12'h981 ? _GEN_4 : _GEN_6; // @[CSR.scala 337:44]
  wire [31:0] _GEN_9 = csr_addr == 12'h980 ? wdata : _GEN_2; // @[CSR.scala 336:{45,54}]
  wire [31:0] _GEN_10 = csr_addr == 12'h980 ? _GEN_1 : _GEN_7; // @[CSR.scala 336:45]
  wire [31:0] _GEN_11 = csr_addr == 12'h980 ? _GEN_4 : _GEN_8; // @[CSR.scala 336:45]
  wire [31:0] _GEN_12 = csr_addr == 12'h902 ? wdata : _GEN_3; // @[CSR.scala 335:{46,56}]
  wire [31:0] _GEN_13 = csr_addr == 12'h902 ? _GEN_2 : _GEN_9; // @[CSR.scala 335:46]
  wire [31:0] _GEN_14 = csr_addr == 12'h902 ? _GEN_1 : _GEN_10; // @[CSR.scala 335:46]
  wire [31:0] _GEN_15 = csr_addr == 12'h902 ? _GEN_4 : _GEN_11; // @[CSR.scala 335:46]
  wire [31:0] _GEN_16 = csr_addr == 12'h901 ? wdata : _time_T_1; // @[CSR.scala 334:{43,50} 275:8]
  wire [31:0] _GEN_17 = csr_addr == 12'h901 ? _GEN_3 : _GEN_12; // @[CSR.scala 334:43]
  wire [31:0] _GEN_18 = csr_addr == 12'h901 ? _GEN_2 : _GEN_13; // @[CSR.scala 334:43]
  wire [31:0] _GEN_19 = csr_addr == 12'h901 ? _GEN_1 : _GEN_14; // @[CSR.scala 334:43]
  wire [31:0] _GEN_20 = csr_addr == 12'h901 ? _GEN_4 : _GEN_15; // @[CSR.scala 334:43]
  wire [31:0] _GEN_21 = csr_addr == 12'h900 ? wdata : _cycle_T_1; // @[CSR.scala 333:{44,52} 277:9]
  wire [31:0] _GEN_22 = csr_addr == 12'h900 ? _time_T_1 : _GEN_16; // @[CSR.scala 333:44 275:8]
  wire [31:0] _GEN_23 = csr_addr == 12'h900 ? _GEN_3 : _GEN_17; // @[CSR.scala 333:44]
  wire [31:0] _GEN_24 = csr_addr == 12'h900 ? _GEN_2 : _GEN_18; // @[CSR.scala 333:44]
  wire [31:0] _GEN_25 = csr_addr == 12'h900 ? _GEN_1 : _GEN_19; // @[CSR.scala 333:44]
  wire [31:0] _GEN_26 = csr_addr == 12'h900 ? _GEN_4 : _GEN_20; // @[CSR.scala 333:44]
  wire [31:0] _GEN_27 = csr_addr == 12'h781 ? wdata : mfromhost; // @[CSR.scala 332:{47,59}]
  wire [31:0] _GEN_28 = csr_addr == 12'h781 ? _cycle_T_1 : _GEN_21; // @[CSR.scala 332:47 277:9]
  wire [31:0] _GEN_29 = csr_addr == 12'h781 ? _time_T_1 : _GEN_22; // @[CSR.scala 332:47 275:8]
  wire [31:0] _GEN_30 = csr_addr == 12'h781 ? _GEN_3 : _GEN_23; // @[CSR.scala 332:47]
  wire [31:0] _GEN_31 = csr_addr == 12'h781 ? _GEN_2 : _GEN_24; // @[CSR.scala 332:47]
  wire [31:0] _GEN_32 = csr_addr == 12'h781 ? _GEN_1 : _GEN_25; // @[CSR.scala 332:47]
  wire [31:0] _GEN_33 = csr_addr == 12'h781 ? _GEN_4 : _GEN_26; // @[CSR.scala 332:47]
  wire [31:0] _GEN_34 = csr_addr == 12'h780 ? wdata : mtohost; // @[CSR.scala 202:24 331:{45,55}]
  wire [31:0] _GEN_35 = csr_addr == 12'h780 ? mfromhost : _GEN_27; // @[CSR.scala 331:45]
  wire [31:0] _GEN_36 = csr_addr == 12'h780 ? _cycle_T_1 : _GEN_28; // @[CSR.scala 331:45 277:9]
  wire [31:0] _GEN_37 = csr_addr == 12'h780 ? _time_T_1 : _GEN_29; // @[CSR.scala 331:45 275:8]
  wire [31:0] _GEN_38 = csr_addr == 12'h780 ? _GEN_3 : _GEN_30; // @[CSR.scala 331:45]
  wire [31:0] _GEN_39 = csr_addr == 12'h780 ? _GEN_2 : _GEN_31; // @[CSR.scala 331:45]
  wire [31:0] _GEN_40 = csr_addr == 12'h780 ? _GEN_1 : _GEN_32; // @[CSR.scala 331:45]
  wire [31:0] _GEN_41 = csr_addr == 12'h780 ? _GEN_4 : _GEN_33; // @[CSR.scala 331:45]
  wire [31:0] _GEN_42 = csr_addr == 12'h343 ? wdata : mbadaddr; // @[CSR.scala 200:21 330:{46,57}]
  wire [31:0] _GEN_43 = csr_addr == 12'h343 ? mtohost : _GEN_34; // @[CSR.scala 202:24 330:46]
  wire [31:0] _GEN_44 = csr_addr == 12'h343 ? mfromhost : _GEN_35; // @[CSR.scala 330:46]
  wire [31:0] _GEN_45 = csr_addr == 12'h343 ? _cycle_T_1 : _GEN_36; // @[CSR.scala 330:46 277:9]
  wire [31:0] _GEN_46 = csr_addr == 12'h343 ? _time_T_1 : _GEN_37; // @[CSR.scala 330:46 275:8]
  wire [31:0] _GEN_47 = csr_addr == 12'h343 ? _GEN_3 : _GEN_38; // @[CSR.scala 330:46]
  wire [31:0] _GEN_48 = csr_addr == 12'h343 ? _GEN_2 : _GEN_39; // @[CSR.scala 330:46]
  wire [31:0] _GEN_49 = csr_addr == 12'h343 ? _GEN_1 : _GEN_40; // @[CSR.scala 330:46]
  wire [31:0] _GEN_50 = csr_addr == 12'h343 ? _GEN_4 : _GEN_41; // @[CSR.scala 330:46]
  wire [31:0] _GEN_51 = csr_addr == 12'h342 ? _mcause_T_7 : mcause; // @[CSR.scala 199:19 329:{44,53}]
  wire [31:0] _GEN_52 = csr_addr == 12'h342 ? mbadaddr : _GEN_42; // @[CSR.scala 200:21 329:44]
  wire [31:0] _GEN_53 = csr_addr == 12'h342 ? mtohost : _GEN_43; // @[CSR.scala 202:24 329:44]
  wire [31:0] _GEN_54 = csr_addr == 12'h342 ? mfromhost : _GEN_44; // @[CSR.scala 329:44]
  wire [31:0] _GEN_55 = csr_addr == 12'h342 ? _cycle_T_1 : _GEN_45; // @[CSR.scala 329:44 277:9]
  wire [31:0] _GEN_56 = csr_addr == 12'h342 ? _time_T_1 : _GEN_46; // @[CSR.scala 329:44 275:8]
  wire [31:0] _GEN_57 = csr_addr == 12'h342 ? _GEN_3 : _GEN_47; // @[CSR.scala 329:44]
  wire [31:0] _GEN_58 = csr_addr == 12'h342 ? _GEN_2 : _GEN_48; // @[CSR.scala 329:44]
  wire [31:0] _GEN_59 = csr_addr == 12'h342 ? _GEN_1 : _GEN_49; // @[CSR.scala 329:44]
  wire [31:0] _GEN_60 = csr_addr == 12'h342 ? _GEN_4 : _GEN_50; // @[CSR.scala 329:44]
  wire [34:0] _GEN_61 = csr_addr == 12'h341 ? _mepc_T_3 : {{3'd0}, mepc}; // @[CSR.scala 198:17 328:{42,49}]
  wire [31:0] _GEN_62 = csr_addr == 12'h341 ? mcause : _GEN_51; // @[CSR.scala 199:19 328:42]
  wire [31:0] _GEN_63 = csr_addr == 12'h341 ? mbadaddr : _GEN_52; // @[CSR.scala 200:21 328:42]
  wire [31:0] _GEN_64 = csr_addr == 12'h341 ? mtohost : _GEN_53; // @[CSR.scala 202:24 328:42]
  wire [31:0] _GEN_65 = csr_addr == 12'h341 ? mfromhost : _GEN_54; // @[CSR.scala 328:42]
  wire [31:0] _GEN_66 = csr_addr == 12'h341 ? _cycle_T_1 : _GEN_55; // @[CSR.scala 328:42 277:9]
  wire [31:0] _GEN_67 = csr_addr == 12'h341 ? _time_T_1 : _GEN_56; // @[CSR.scala 328:42 275:8]
  wire [31:0] _GEN_68 = csr_addr == 12'h341 ? _GEN_3 : _GEN_57; // @[CSR.scala 328:42]
  wire [31:0] _GEN_69 = csr_addr == 12'h341 ? _GEN_2 : _GEN_58; // @[CSR.scala 328:42]
  wire [31:0] _GEN_70 = csr_addr == 12'h341 ? _GEN_1 : _GEN_59; // @[CSR.scala 328:42]
  wire [31:0] _GEN_71 = csr_addr == 12'h341 ? _GEN_4 : _GEN_60; // @[CSR.scala 328:42]
  wire [31:0] _GEN_72 = csr_addr == 12'h340 ? wdata : mscratch; // @[CSR.scala 196:21 327:{46,57}]
  wire [34:0] _GEN_73 = csr_addr == 12'h340 ? {{3'd0}, mepc} : _GEN_61; // @[CSR.scala 198:17 327:46]
  wire [31:0] _GEN_74 = csr_addr == 12'h340 ? mcause : _GEN_62; // @[CSR.scala 199:19 327:46]
  wire [31:0] _GEN_75 = csr_addr == 12'h340 ? mbadaddr : _GEN_63; // @[CSR.scala 200:21 327:46]
  wire [31:0] _GEN_76 = csr_addr == 12'h340 ? mtohost : _GEN_64; // @[CSR.scala 202:24 327:46]
  wire [31:0] _GEN_77 = csr_addr == 12'h340 ? mfromhost : _GEN_65; // @[CSR.scala 327:46]
  wire [31:0] _GEN_78 = csr_addr == 12'h340 ? _cycle_T_1 : _GEN_66; // @[CSR.scala 327:46 277:9]
  wire [31:0] _GEN_79 = csr_addr == 12'h340 ? _time_T_1 : _GEN_67; // @[CSR.scala 327:46 275:8]
  wire [31:0] _GEN_80 = csr_addr == 12'h340 ? _GEN_3 : _GEN_68; // @[CSR.scala 327:46]
  wire [31:0] _GEN_81 = csr_addr == 12'h340 ? _GEN_2 : _GEN_69; // @[CSR.scala 327:46]
  wire [31:0] _GEN_82 = csr_addr == 12'h340 ? _GEN_1 : _GEN_70; // @[CSR.scala 327:46]
  wire [31:0] _GEN_83 = csr_addr == 12'h340 ? _GEN_4 : _GEN_71; // @[CSR.scala 327:46]
  wire [31:0] _GEN_84 = csr_addr == 12'h321 ? wdata : mtimecmp; // @[CSR.scala 194:21 326:{46,57}]
  wire [31:0] _GEN_85 = csr_addr == 12'h321 ? mscratch : _GEN_72; // @[CSR.scala 196:21 326:46]
  wire [34:0] _GEN_86 = csr_addr == 12'h321 ? {{3'd0}, mepc} : _GEN_73; // @[CSR.scala 198:17 326:46]
  wire [31:0] _GEN_87 = csr_addr == 12'h321 ? mcause : _GEN_74; // @[CSR.scala 199:19 326:46]
  wire [31:0] _GEN_88 = csr_addr == 12'h321 ? mbadaddr : _GEN_75; // @[CSR.scala 200:21 326:46]
  wire [31:0] _GEN_89 = csr_addr == 12'h321 ? mtohost : _GEN_76; // @[CSR.scala 202:24 326:46]
  wire [31:0] _GEN_90 = csr_addr == 12'h321 ? mfromhost : _GEN_77; // @[CSR.scala 326:46]
  wire [31:0] _GEN_91 = csr_addr == 12'h321 ? _cycle_T_1 : _GEN_78; // @[CSR.scala 326:46 277:9]
  wire [31:0] _GEN_92 = csr_addr == 12'h321 ? _time_T_1 : _GEN_79; // @[CSR.scala 326:46 275:8]
  wire [31:0] _GEN_93 = csr_addr == 12'h321 ? _GEN_3 : _GEN_80; // @[CSR.scala 326:46]
  wire [31:0] _GEN_94 = csr_addr == 12'h321 ? _GEN_2 : _GEN_81; // @[CSR.scala 326:46]
  wire [31:0] _GEN_95 = csr_addr == 12'h321 ? _GEN_1 : _GEN_82; // @[CSR.scala 326:46]
  wire [31:0] _GEN_96 = csr_addr == 12'h321 ? _GEN_4 : _GEN_83; // @[CSR.scala 326:46]
  wire [31:0] _GEN_97 = csr_addr == 12'h741 ? wdata : _GEN_95; // @[CSR.scala 325:{44,52}]
  wire [31:0] _GEN_98 = csr_addr == 12'h741 ? mtimecmp : _GEN_84; // @[CSR.scala 194:21 325:44]
  wire [31:0] _GEN_99 = csr_addr == 12'h741 ? mscratch : _GEN_85; // @[CSR.scala 196:21 325:44]
  wire [34:0] _GEN_100 = csr_addr == 12'h741 ? {{3'd0}, mepc} : _GEN_86; // @[CSR.scala 198:17 325:44]
  wire [31:0] _GEN_101 = csr_addr == 12'h741 ? mcause : _GEN_87; // @[CSR.scala 199:19 325:44]
  wire [31:0] _GEN_102 = csr_addr == 12'h741 ? mbadaddr : _GEN_88; // @[CSR.scala 200:21 325:44]
  wire [31:0] _GEN_103 = csr_addr == 12'h741 ? mtohost : _GEN_89; // @[CSR.scala 202:24 325:44]
  wire [31:0] _GEN_104 = csr_addr == 12'h741 ? mfromhost : _GEN_90; // @[CSR.scala 325:44]
  wire [31:0] _GEN_105 = csr_addr == 12'h741 ? _cycle_T_1 : _GEN_91; // @[CSR.scala 325:44 277:9]
  wire [31:0] _GEN_106 = csr_addr == 12'h741 ? _time_T_1 : _GEN_92; // @[CSR.scala 325:44 275:8]
  wire [31:0] _GEN_107 = csr_addr == 12'h741 ? _GEN_3 : _GEN_93; // @[CSR.scala 325:44]
  wire [31:0] _GEN_108 = csr_addr == 12'h741 ? _GEN_2 : _GEN_94; // @[CSR.scala 325:44]
  wire [31:0] _GEN_109 = csr_addr == 12'h741 ? _GEN_4 : _GEN_96; // @[CSR.scala 325:44]
  wire [31:0] _GEN_110 = csr_addr == 12'h701 ? wdata : _GEN_106; // @[CSR.scala 324:{43,50}]
  wire [31:0] _GEN_111 = csr_addr == 12'h701 ? _GEN_1 : _GEN_97; // @[CSR.scala 324:43]
  wire [31:0] _GEN_112 = csr_addr == 12'h701 ? mtimecmp : _GEN_98; // @[CSR.scala 194:21 324:43]
  wire [31:0] _GEN_113 = csr_addr == 12'h701 ? mscratch : _GEN_99; // @[CSR.scala 196:21 324:43]
  wire [34:0] _GEN_114 = csr_addr == 12'h701 ? {{3'd0}, mepc} : _GEN_100; // @[CSR.scala 198:17 324:43]
  wire [31:0] _GEN_115 = csr_addr == 12'h701 ? mcause : _GEN_101; // @[CSR.scala 199:19 324:43]
  wire [31:0] _GEN_116 = csr_addr == 12'h701 ? mbadaddr : _GEN_102; // @[CSR.scala 200:21 324:43]
  wire [31:0] _GEN_117 = csr_addr == 12'h701 ? mtohost : _GEN_103; // @[CSR.scala 202:24 324:43]
  wire [31:0] _GEN_118 = csr_addr == 12'h701 ? mfromhost : _GEN_104; // @[CSR.scala 324:43]
  wire [31:0] _GEN_119 = csr_addr == 12'h701 ? _cycle_T_1 : _GEN_105; // @[CSR.scala 324:43 277:9]
  wire [31:0] _GEN_120 = csr_addr == 12'h701 ? _GEN_3 : _GEN_107; // @[CSR.scala 324:43]
  wire [31:0] _GEN_121 = csr_addr == 12'h701 ? _GEN_2 : _GEN_108; // @[CSR.scala 324:43]
  wire [31:0] _GEN_122 = csr_addr == 12'h701 ? _GEN_4 : _GEN_109; // @[CSR.scala 324:43]
  wire  _GEN_123 = csr_addr == 12'h304 ? wdata[7] : MTIE; // @[CSR.scala 320:41 321:16 182:21]
  wire  _GEN_124 = csr_addr == 12'h304 ? wdata[3] : MSIE; // @[CSR.scala 320:41 322:16 188:21]
  wire [31:0] _GEN_125 = csr_addr == 12'h304 ? _time_T_1 : _GEN_110; // @[CSR.scala 320:41 275:8]
  wire [31:0] _GEN_126 = csr_addr == 12'h304 ? _GEN_1 : _GEN_111; // @[CSR.scala 320:41]
  wire [31:0] _GEN_127 = csr_addr == 12'h304 ? mtimecmp : _GEN_112; // @[CSR.scala 194:21 320:41]
  wire [31:0] _GEN_128 = csr_addr == 12'h304 ? mscratch : _GEN_113; // @[CSR.scala 196:21 320:41]
  wire [34:0] _GEN_129 = csr_addr == 12'h304 ? {{3'd0}, mepc} : _GEN_114; // @[CSR.scala 198:17 320:41]
  wire [31:0] _GEN_130 = csr_addr == 12'h304 ? mcause : _GEN_115; // @[CSR.scala 199:19 320:41]
  wire [31:0] _GEN_131 = csr_addr == 12'h304 ? mbadaddr : _GEN_116; // @[CSR.scala 200:21 320:41]
  wire [31:0] _GEN_132 = csr_addr == 12'h304 ? mtohost : _GEN_117; // @[CSR.scala 202:24 320:41]
  wire [31:0] _GEN_133 = csr_addr == 12'h304 ? mfromhost : _GEN_118; // @[CSR.scala 320:41]
  wire [31:0] _GEN_134 = csr_addr == 12'h304 ? _cycle_T_1 : _GEN_119; // @[CSR.scala 320:41 277:9]
  wire [31:0] _GEN_135 = csr_addr == 12'h304 ? _GEN_3 : _GEN_120; // @[CSR.scala 320:41]
  wire [31:0] _GEN_136 = csr_addr == 12'h304 ? _GEN_2 : _GEN_121; // @[CSR.scala 320:41]
  wire [31:0] _GEN_137 = csr_addr == 12'h304 ? _GEN_4 : _GEN_122; // @[CSR.scala 320:41]
  wire  _GEN_138 = csr_addr == 12'h344 ? wdata[7] : MTIP; // @[CSR.scala 316:41 317:16 179:21]
  wire  _GEN_139 = csr_addr == 12'h344 ? wdata[3] : MSIP; // @[CSR.scala 316:41 318:16 185:21]
  wire  _GEN_140 = csr_addr == 12'h344 ? MTIE : _GEN_123; // @[CSR.scala 182:21 316:41]
  wire  _GEN_141 = csr_addr == 12'h344 ? MSIE : _GEN_124; // @[CSR.scala 188:21 316:41]
  wire [31:0] _GEN_142 = csr_addr == 12'h344 ? _time_T_1 : _GEN_125; // @[CSR.scala 316:41 275:8]
  wire [31:0] _GEN_143 = csr_addr == 12'h344 ? _GEN_1 : _GEN_126; // @[CSR.scala 316:41]
  wire [31:0] _GEN_144 = csr_addr == 12'h344 ? mtimecmp : _GEN_127; // @[CSR.scala 194:21 316:41]
  wire [31:0] _GEN_145 = csr_addr == 12'h344 ? mscratch : _GEN_128; // @[CSR.scala 196:21 316:41]
  wire [34:0] _GEN_146 = csr_addr == 12'h344 ? {{3'd0}, mepc} : _GEN_129; // @[CSR.scala 198:17 316:41]
  wire [31:0] _GEN_147 = csr_addr == 12'h344 ? mcause : _GEN_130; // @[CSR.scala 199:19 316:41]
  wire [31:0] _GEN_148 = csr_addr == 12'h344 ? mbadaddr : _GEN_131; // @[CSR.scala 200:21 316:41]
  wire [31:0] _GEN_149 = csr_addr == 12'h344 ? mtohost : _GEN_132; // @[CSR.scala 202:24 316:41]
  wire [31:0] _GEN_150 = csr_addr == 12'h344 ? mfromhost : _GEN_133; // @[CSR.scala 316:41]
  wire [31:0] _GEN_151 = csr_addr == 12'h344 ? _cycle_T_1 : _GEN_134; // @[CSR.scala 316:41 277:9]
  wire [31:0] _GEN_152 = csr_addr == 12'h344 ? _GEN_3 : _GEN_135; // @[CSR.scala 316:41]
  wire [31:0] _GEN_153 = csr_addr == 12'h344 ? _GEN_2 : _GEN_136; // @[CSR.scala 316:41]
  wire [31:0] _GEN_154 = csr_addr == 12'h344 ? _GEN_4 : _GEN_137; // @[CSR.scala 316:41]
  wire [1:0] _GEN_155 = csr_addr == 12'h300 ? wdata[5:4] : PRV1; // @[CSR.scala 310:38 311:14 159:21]
  wire  _GEN_156 = csr_addr == 12'h300 ? wdata[3] : IE1; // @[CSR.scala 310:38 312:13 163:20]
  wire [1:0] _GEN_157 = csr_addr == 12'h300 ? wdata[2:1] : PRV; // @[CSR.scala 310:38 313:13 158:20]
  wire  _GEN_158 = csr_addr == 12'h300 ? wdata[0] : IE; // @[CSR.scala 310:38 314:12 162:19]
  wire  _GEN_159 = csr_addr == 12'h300 ? MTIP : _GEN_138; // @[CSR.scala 179:21 310:38]
  wire  _GEN_160 = csr_addr == 12'h300 ? MSIP : _GEN_139; // @[CSR.scala 185:21 310:38]
  wire  _GEN_161 = csr_addr == 12'h300 ? MTIE : _GEN_140; // @[CSR.scala 182:21 310:38]
  wire  _GEN_162 = csr_addr == 12'h300 ? MSIE : _GEN_141; // @[CSR.scala 188:21 310:38]
  wire [31:0] _GEN_163 = csr_addr == 12'h300 ? _time_T_1 : _GEN_142; // @[CSR.scala 310:38 275:8]
  wire [31:0] _GEN_164 = csr_addr == 12'h300 ? _GEN_1 : _GEN_143; // @[CSR.scala 310:38]
  wire [31:0] _GEN_165 = csr_addr == 12'h300 ? mtimecmp : _GEN_144; // @[CSR.scala 194:21 310:38]
  wire [31:0] _GEN_166 = csr_addr == 12'h300 ? mscratch : _GEN_145; // @[CSR.scala 196:21 310:38]
  wire [34:0] _GEN_167 = csr_addr == 12'h300 ? {{3'd0}, mepc} : _GEN_146; // @[CSR.scala 198:17 310:38]
  wire [31:0] _GEN_168 = csr_addr == 12'h300 ? mcause : _GEN_147; // @[CSR.scala 199:19 310:38]
  wire [31:0] _GEN_169 = csr_addr == 12'h300 ? mbadaddr : _GEN_148; // @[CSR.scala 200:21 310:38]
  wire [31:0] _GEN_170 = csr_addr == 12'h300 ? mtohost : _GEN_149; // @[CSR.scala 202:24 310:38]
  wire [31:0] _GEN_171 = csr_addr == 12'h300 ? mfromhost : _GEN_150; // @[CSR.scala 310:38]
  wire [31:0] _GEN_172 = csr_addr == 12'h300 ? _cycle_T_1 : _GEN_151; // @[CSR.scala 310:38 277:9]
  wire [31:0] _GEN_173 = csr_addr == 12'h300 ? _GEN_3 : _GEN_152; // @[CSR.scala 310:38]
  wire [31:0] _GEN_174 = csr_addr == 12'h300 ? _GEN_2 : _GEN_153; // @[CSR.scala 310:38]
  wire [31:0] _GEN_175 = csr_addr == 12'h300 ? _GEN_4 : _GEN_154; // @[CSR.scala 310:38]
  wire [1:0] _GEN_176 = wen ? _GEN_155 : PRV1; // @[CSR.scala 159:21 309:21]
  wire  _GEN_177 = wen ? _GEN_156 : IE1; // @[CSR.scala 163:20 309:21]
  wire [1:0] _GEN_178 = wen ? _GEN_157 : PRV; // @[CSR.scala 158:20 309:21]
  wire  _GEN_179 = wen ? _GEN_158 : IE; // @[CSR.scala 162:19 309:21]
  wire  _GEN_180 = wen ? _GEN_159 : MTIP; // @[CSR.scala 179:21 309:21]
  wire  _GEN_181 = wen ? _GEN_160 : MSIP; // @[CSR.scala 185:21 309:21]
  wire  _GEN_182 = wen ? _GEN_161 : MTIE; // @[CSR.scala 182:21 309:21]
  wire  _GEN_183 = wen ? _GEN_162 : MSIE; // @[CSR.scala 188:21 309:21]
  wire [31:0] _GEN_184 = wen ? _GEN_163 : _time_T_1; // @[CSR.scala 309:21 275:8]
  wire [31:0] _GEN_185 = wen ? _GEN_164 : _GEN_1; // @[CSR.scala 309:21]
  wire [34:0] _GEN_188 = wen ? _GEN_167 : {{3'd0}, mepc}; // @[CSR.scala 198:17 309:21]
  wire [31:0] _GEN_191 = wen ? _GEN_170 : mtohost; // @[CSR.scala 309:21 202:24]
  wire [31:0] _GEN_193 = wen ? _GEN_172 : _cycle_T_1; // @[CSR.scala 309:21 277:9]
  wire [31:0] _GEN_194 = wen ? _GEN_173 : _GEN_3; // @[CSR.scala 309:21]
  wire [31:0] _GEN_195 = wen ? _GEN_174 : _GEN_2; // @[CSR.scala 309:21]
  wire [31:0] _GEN_196 = wen ? _GEN_175 : _GEN_4; // @[CSR.scala 309:21]
  wire  _GEN_200 = isEret | _GEN_177; // @[CSR.scala 304:24 308:11]
  wire [34:0] _GEN_209 = isEret ? {{3'd0}, mepc} : _GEN_188; // @[CSR.scala 198:17 304:24]
  wire [34:0] _GEN_218 = io_expt ? {{3'd0}, _mepc_T_1} : _GEN_209; // @[CSR.scala 284:19 285:12]
  wire [34:0] _GEN_239 = _isInstRet_T_5 ? _GEN_218 : {{3'd0}, mepc}; // @[CSR.scala 198:17 283:19]
  assign io_out = _io_out_T_1 ? cycle : _io_out_T_85; // @[Lookup.scala 34:39]
  assign io_expt = _io_expt_T_14 | isEcall | isEbreak; // @[CSR.scala 270:41]
  assign io_evec = 32'h100 + _GEN_260; // @[CSR.scala 271:20]
  assign io_epc = mepc; // @[CSR.scala 272:10]
  always @(posedge clock) begin
    if (reset) begin // @[CSR.scala 141:21]
      time_ <= 32'h0; // @[CSR.scala 141:21]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        time_ <= _time_T_1; // @[CSR.scala 275:8]
      end else if (isEret) begin // @[CSR.scala 304:24]
        time_ <= _time_T_1; // @[CSR.scala 275:8]
      end else begin
        time_ <= _GEN_184;
      end
    end else begin
      time_ <= _time_T_1; // @[CSR.scala 275:8]
    end
    if (reset) begin // @[CSR.scala 142:22]
      timeh <= 32'h0; // @[CSR.scala 142:22]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        timeh <= _GEN_1;
      end else if (isEret) begin // @[CSR.scala 304:24]
        timeh <= _GEN_1;
      end else begin
        timeh <= _GEN_185;
      end
    end else begin
      timeh <= _GEN_1;
    end
    if (reset) begin // @[CSR.scala 143:22]
      cycle <= 32'h0; // @[CSR.scala 143:22]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        cycle <= _cycle_T_1; // @[CSR.scala 277:9]
      end else if (isEret) begin // @[CSR.scala 304:24]
        cycle <= _cycle_T_1; // @[CSR.scala 277:9]
      end else begin
        cycle <= _GEN_193;
      end
    end else begin
      cycle <= _cycle_T_1; // @[CSR.scala 277:9]
    end
    if (reset) begin // @[CSR.scala 144:23]
      cycleh <= 32'h0; // @[CSR.scala 144:23]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        cycleh <= _GEN_2;
      end else if (isEret) begin // @[CSR.scala 304:24]
        cycleh <= _GEN_2;
      end else begin
        cycleh <= _GEN_195;
      end
    end else begin
      cycleh <= _GEN_2;
    end
    if (reset) begin // @[CSR.scala 145:24]
      instret <= 32'h0; // @[CSR.scala 145:24]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        instret <= _GEN_3;
      end else if (isEret) begin // @[CSR.scala 304:24]
        instret <= _GEN_3;
      end else begin
        instret <= _GEN_194;
      end
    end else begin
      instret <= _GEN_3;
    end
    if (reset) begin // @[CSR.scala 146:25]
      instreth <= 32'h0; // @[CSR.scala 146:25]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        instreth <= _GEN_4;
      end else if (isEret) begin // @[CSR.scala 304:24]
        instreth <= _GEN_4;
      end else begin
        instreth <= _GEN_196;
      end
    end else begin
      instreth <= _GEN_4;
    end
    if (reset) begin // @[CSR.scala 158:20]
      PRV <= 2'h3; // @[CSR.scala 158:20]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        PRV <= 2'h3; // @[CSR.scala 299:11]
      end else if (isEret) begin // @[CSR.scala 304:24]
        PRV <= PRV1; // @[CSR.scala 305:11]
      end else begin
        PRV <= _GEN_178;
      end
    end
    if (reset) begin // @[CSR.scala 159:21]
      PRV1 <= 2'h3; // @[CSR.scala 159:21]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        PRV1 <= PRV; // @[CSR.scala 301:12]
      end else if (isEret) begin // @[CSR.scala 304:24]
        PRV1 <= 2'h0; // @[CSR.scala 307:12]
      end else begin
        PRV1 <= _GEN_176;
      end
    end
    if (reset) begin // @[CSR.scala 162:19]
      IE <= 1'h0; // @[CSR.scala 162:19]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        IE <= 1'h0; // @[CSR.scala 300:10]
      end else if (isEret) begin // @[CSR.scala 304:24]
        IE <= IE1; // @[CSR.scala 306:10]
      end else begin
        IE <= _GEN_179;
      end
    end
    if (reset) begin // @[CSR.scala 163:20]
      IE1 <= 1'h0; // @[CSR.scala 163:20]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        IE1 <= IE; // @[CSR.scala 302:11]
      end else begin
        IE1 <= _GEN_200;
      end
    end
    if (reset) begin // @[CSR.scala 179:21]
      MTIP <= 1'h0; // @[CSR.scala 179:21]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (!(io_expt)) begin // @[CSR.scala 284:19]
        if (!(isEret)) begin // @[CSR.scala 304:24]
          MTIP <= _GEN_180;
        end
      end
    end
    if (reset) begin // @[CSR.scala 182:21]
      MTIE <= 1'h0; // @[CSR.scala 182:21]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (!(io_expt)) begin // @[CSR.scala 284:19]
        if (!(isEret)) begin // @[CSR.scala 304:24]
          MTIE <= _GEN_182;
        end
      end
    end
    if (reset) begin // @[CSR.scala 185:21]
      MSIP <= 1'h0; // @[CSR.scala 185:21]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (!(io_expt)) begin // @[CSR.scala 284:19]
        if (!(isEret)) begin // @[CSR.scala 304:24]
          MSIP <= _GEN_181;
        end
      end
    end
    if (reset) begin // @[CSR.scala 188:21]
      MSIE <= 1'h0; // @[CSR.scala 188:21]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (!(io_expt)) begin // @[CSR.scala 284:19]
        if (!(isEret)) begin // @[CSR.scala 304:24]
          MSIE <= _GEN_183;
        end
      end
    end
    if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (!(io_expt)) begin // @[CSR.scala 284:19]
        if (!(isEret)) begin // @[CSR.scala 304:24]
          if (wen) begin // @[CSR.scala 309:21]
            mtimecmp <= _GEN_165;
          end
        end
      end
    end
    if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (!(io_expt)) begin // @[CSR.scala 284:19]
        if (!(isEret)) begin // @[CSR.scala 304:24]
          if (wen) begin // @[CSR.scala 309:21]
            mscratch <= _GEN_166;
          end
        end
      end
    end
    mepc <= _GEN_239[31:0];
    if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        mcause <= {{28'd0}, _mcause_T_6}; // @[CSR.scala 286:14]
      end else if (!(isEret)) begin // @[CSR.scala 304:24]
        if (wen) begin // @[CSR.scala 309:21]
          mcause <= _GEN_168;
        end
      end
    end
    if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (io_expt) begin // @[CSR.scala 284:19]
        if (iaddrInvalid | laddrInvalid | saddrInvalid) begin // @[CSR.scala 303:58]
          mbadaddr <= io_addr; // @[CSR.scala 303:69]
        end
      end else if (!(isEret)) begin // @[CSR.scala 304:24]
        if (wen) begin // @[CSR.scala 309:21]
          mbadaddr <= _GEN_169;
        end
      end
    end
    if (reset) begin // @[CSR.scala 202:24]
      mtohost <= 32'h0; // @[CSR.scala 202:24]
    end else if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (!(io_expt)) begin // @[CSR.scala 284:19]
        if (!(isEret)) begin // @[CSR.scala 304:24]
          mtohost <= _GEN_191;
        end
      end
    end
    if (_isInstRet_T_5) begin // @[CSR.scala 283:19]
      if (!(io_expt)) begin // @[CSR.scala 284:19]
        if (!(isEret)) begin // @[CSR.scala 304:24]
          if (wen) begin // @[CSR.scala 309:21]
            mfromhost <= _GEN_171;
          end
        end
      end
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
  _RAND_0 = {1{`RANDOM}};
  time_ = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  timeh = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  cycle = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  cycleh = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  instret = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  instreth = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  PRV = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  PRV1 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  IE = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  IE1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  MTIP = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  MTIE = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  MSIP = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  MSIE = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  mtimecmp = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  mscratch = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  mepc = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  mcause = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  mbadaddr = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mtohost = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  mfromhost = _RAND_20[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegFile(
  input         clock,
  input  [4:0]  io_raddr1,
  input  [4:0]  io_raddr2,
  output [31:0] io_rdata1,
  output [31:0] io_rdata2,
  input         io_wen,
  input  [4:0]  io_waddr,
  input  [31:0] io_wdata
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regs [0:31]; // @[RegFile.scala 19:17]
  wire  regs_io_rdata1_MPORT_en; // @[RegFile.scala 19:17]
  wire [4:0] regs_io_rdata1_MPORT_addr; // @[RegFile.scala 19:17]
  wire [31:0] regs_io_rdata1_MPORT_data; // @[RegFile.scala 19:17]
  wire  regs_io_rdata2_MPORT_en; // @[RegFile.scala 19:17]
  wire [4:0] regs_io_rdata2_MPORT_addr; // @[RegFile.scala 19:17]
  wire [31:0] regs_io_rdata2_MPORT_data; // @[RegFile.scala 19:17]
  wire [31:0] regs_MPORT_data; // @[RegFile.scala 19:17]
  wire [4:0] regs_MPORT_addr; // @[RegFile.scala 19:17]
  wire  regs_MPORT_mask; // @[RegFile.scala 19:17]
  wire  regs_MPORT_en; // @[RegFile.scala 19:17]
  wire  _T = |io_waddr; // @[RegFile.scala 22:26]
  assign regs_io_rdata1_MPORT_en = 1'h1;
  assign regs_io_rdata1_MPORT_addr = io_raddr1;
  assign regs_io_rdata1_MPORT_data = regs[regs_io_rdata1_MPORT_addr]; // @[RegFile.scala 19:17]
  assign regs_io_rdata2_MPORT_en = 1'h1;
  assign regs_io_rdata2_MPORT_addr = io_raddr2;
  assign regs_io_rdata2_MPORT_data = regs[regs_io_rdata2_MPORT_addr]; // @[RegFile.scala 19:17]
  assign regs_MPORT_data = io_wdata;
  assign regs_MPORT_addr = io_waddr;
  assign regs_MPORT_mask = 1'h1;
  assign regs_MPORT_en = io_wen & _T;
  assign io_rdata1 = |io_raddr1 ? regs_io_rdata1_MPORT_data : 32'h0; // @[RegFile.scala 20:19]
  assign io_rdata2 = |io_raddr2 ? regs_io_rdata2_MPORT_data : 32'h0; // @[RegFile.scala 21:19]
  always @(posedge clock) begin
    if (regs_MPORT_en & regs_MPORT_mask) begin
      regs[regs_MPORT_addr] <= regs_MPORT_data; // @[RegFile.scala 19:17]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regs[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AluArea(
  input  [31:0] io_A,
  input  [31:0] io_B,
  input  [3:0]  io_alu_op,
  output [31:0] io_out,
  output [31:0] io_sum
);
  wire [31:0] _sum_T_2 = 32'h0 - io_B; // @[Alu.scala 73:38]
  wire [31:0] _sum_T_3 = io_alu_op[0] ? _sum_T_2 : io_B; // @[Alu.scala 73:23]
  wire [31:0] sum = io_A + _sum_T_3; // @[Alu.scala 73:18]
  wire  _cmp_T_7 = io_alu_op[1] ? io_B[31] : io_A[31]; // @[Alu.scala 75:65]
  wire  cmp = io_A[31] == io_B[31] ? sum[31] : _cmp_T_7; // @[Alu.scala 75:8]
  wire [4:0] shamt = io_B[4:0]; // @[Alu.scala 76:19]
  wire [31:0] _GEN_0 = {{16'd0}, io_A[31:16]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_4 = _GEN_0 & 32'hffff; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_6 = {io_A[15:0], 16'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shin_T_8 = _shin_T_6 & 32'hffff0000; // @[Bitwise.scala 105:80]
  wire [31:0] _shin_T_9 = _shin_T_4 | _shin_T_8; // @[Bitwise.scala 105:39]
  wire [31:0] _GEN_1 = {{8'd0}, _shin_T_9[31:8]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_14 = _GEN_1 & 32'hff00ff; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_16 = {_shin_T_9[23:0], 8'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shin_T_18 = _shin_T_16 & 32'hff00ff00; // @[Bitwise.scala 105:80]
  wire [31:0] _shin_T_19 = _shin_T_14 | _shin_T_18; // @[Bitwise.scala 105:39]
  wire [31:0] _GEN_2 = {{4'd0}, _shin_T_19[31:4]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_24 = _GEN_2 & 32'hf0f0f0f; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_26 = {_shin_T_19[27:0], 4'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shin_T_28 = _shin_T_26 & 32'hf0f0f0f0; // @[Bitwise.scala 105:80]
  wire [31:0] _shin_T_29 = _shin_T_24 | _shin_T_28; // @[Bitwise.scala 105:39]
  wire [31:0] _GEN_3 = {{2'd0}, _shin_T_29[31:2]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_34 = _GEN_3 & 32'h33333333; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_36 = {_shin_T_29[29:0], 2'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shin_T_38 = _shin_T_36 & 32'hcccccccc; // @[Bitwise.scala 105:80]
  wire [31:0] _shin_T_39 = _shin_T_34 | _shin_T_38; // @[Bitwise.scala 105:39]
  wire [31:0] _GEN_4 = {{1'd0}, _shin_T_39[31:1]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_44 = _GEN_4 & 32'h55555555; // @[Bitwise.scala 105:31]
  wire [31:0] _shin_T_46 = {_shin_T_39[30:0], 1'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shin_T_48 = _shin_T_46 & 32'haaaaaaaa; // @[Bitwise.scala 105:80]
  wire [31:0] _shin_T_49 = _shin_T_44 | _shin_T_48; // @[Bitwise.scala 105:39]
  wire [31:0] shin = io_alu_op[3] ? io_A : _shin_T_49; // @[Alu.scala 77:17]
  wire  _shiftr_T_2 = io_alu_op[0] & shin[31]; // @[Alu.scala 78:34]
  wire [32:0] _shiftr_T_4 = {_shiftr_T_2,shin}; // @[Alu.scala 78:60]
  wire [32:0] _shiftr_T_5 = $signed(_shiftr_T_4) >>> shamt; // @[Alu.scala 78:67]
  wire [31:0] shiftr = _shiftr_T_5[31:0]; // @[Alu.scala 78:76]
  wire [31:0] _GEN_5 = {{16'd0}, shiftr[31:16]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_3 = _GEN_5 & 32'hffff; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_5 = {shiftr[15:0], 16'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shiftl_T_7 = _shiftl_T_5 & 32'hffff0000; // @[Bitwise.scala 105:80]
  wire [31:0] _shiftl_T_8 = _shiftl_T_3 | _shiftl_T_7; // @[Bitwise.scala 105:39]
  wire [31:0] _GEN_6 = {{8'd0}, _shiftl_T_8[31:8]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_13 = _GEN_6 & 32'hff00ff; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_15 = {_shiftl_T_8[23:0], 8'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shiftl_T_17 = _shiftl_T_15 & 32'hff00ff00; // @[Bitwise.scala 105:80]
  wire [31:0] _shiftl_T_18 = _shiftl_T_13 | _shiftl_T_17; // @[Bitwise.scala 105:39]
  wire [31:0] _GEN_7 = {{4'd0}, _shiftl_T_18[31:4]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_23 = _GEN_7 & 32'hf0f0f0f; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_25 = {_shiftl_T_18[27:0], 4'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shiftl_T_27 = _shiftl_T_25 & 32'hf0f0f0f0; // @[Bitwise.scala 105:80]
  wire [31:0] _shiftl_T_28 = _shiftl_T_23 | _shiftl_T_27; // @[Bitwise.scala 105:39]
  wire [31:0] _GEN_8 = {{2'd0}, _shiftl_T_28[31:2]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_33 = _GEN_8 & 32'h33333333; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_35 = {_shiftl_T_28[29:0], 2'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shiftl_T_37 = _shiftl_T_35 & 32'hcccccccc; // @[Bitwise.scala 105:80]
  wire [31:0] _shiftl_T_38 = _shiftl_T_33 | _shiftl_T_37; // @[Bitwise.scala 105:39]
  wire [31:0] _GEN_9 = {{1'd0}, _shiftl_T_38[31:1]}; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_43 = _GEN_9 & 32'h55555555; // @[Bitwise.scala 105:31]
  wire [31:0] _shiftl_T_45 = {_shiftl_T_38[30:0], 1'h0}; // @[Bitwise.scala 105:70]
  wire [31:0] _shiftl_T_47 = _shiftl_T_45 & 32'haaaaaaaa; // @[Bitwise.scala 105:80]
  wire [31:0] shiftl = _shiftl_T_43 | _shiftl_T_47; // @[Bitwise.scala 105:39]
  wire  _out_T_2 = io_alu_op == 4'h0 | io_alu_op == 4'h1; // @[Alu.scala 84:29]
  wire  _out_T_5 = io_alu_op == 4'h5 | io_alu_op == 4'h7; // @[Alu.scala 87:31]
  wire  _out_T_8 = io_alu_op == 4'h9 | io_alu_op == 4'h8; // @[Alu.scala 90:33]
  wire  _out_T_9 = io_alu_op == 4'h6; // @[Alu.scala 93:23]
  wire  _out_T_10 = io_alu_op == 4'h2; // @[Alu.scala 96:25]
  wire [31:0] _out_T_11 = io_A & io_B; // @[Alu.scala 97:20]
  wire  _out_T_12 = io_alu_op == 4'h3; // @[Alu.scala 99:27]
  wire [31:0] _out_T_13 = io_A | io_B; // @[Alu.scala 100:22]
  wire [31:0] _out_T_15 = io_A ^ io_B; // @[Alu.scala 101:49]
  wire [31:0] _out_T_17 = io_alu_op == 4'ha ? io_A : io_B; // @[Alu.scala 101:60]
  wire [31:0] _out_T_18 = io_alu_op == 4'h4 ? _out_T_15 : _out_T_17; // @[Alu.scala 101:20]
  wire [31:0] _out_T_19 = _out_T_12 ? _out_T_13 : _out_T_18; // @[Alu.scala 98:18]
  wire [31:0] _out_T_20 = _out_T_10 ? _out_T_11 : _out_T_19; // @[Alu.scala 95:16]
  wire [31:0] _out_T_21 = _out_T_9 ? shiftl : _out_T_20; // @[Alu.scala 92:14]
  wire [31:0] _out_T_22 = _out_T_8 ? shiftr : _out_T_21; // @[Alu.scala 89:12]
  wire [31:0] _out_T_23 = _out_T_5 ? {{31'd0}, cmp} : _out_T_22; // @[Alu.scala 86:10]
  assign io_out = _out_T_2 ? sum : _out_T_23; // @[Alu.scala 83:8]
  assign io_sum = io_A + _sum_T_3; // @[Alu.scala 73:18]
endmodule
module ImmGenWire(
  input  [31:0] io_inst,
  input  [2:0]  io_sel,
  output [31:0] io_out
);
  wire [11:0] Iimm = io_inst[31:20]; // @[ImmGen.scala 22:30]
  wire [11:0] Simm = {io_inst[31:25],io_inst[11:7]}; // @[ImmGen.scala 23:51]
  wire [12:0] Bimm = {io_inst[31],io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[ImmGen.scala 24:86]
  wire [31:0] Uimm = {io_inst[31:12],12'h0}; // @[ImmGen.scala 25:46]
  wire [20:0] Jimm = {io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:25],io_inst[24:21],1'h0}; // @[ImmGen.scala 26:105]
  wire [5:0] Zimm = {1'b0,$signed(io_inst[19:15])}; // @[ImmGen.scala 27:30]
  wire [11:0] _io_out_T_1 = $signed(Iimm) & -12'sh2; // @[ImmGen.scala 31:10]
  wire [11:0] _io_out_T_3 = 3'h1 == io_sel ? $signed(Iimm) : $signed(_io_out_T_1); // @[Mux.scala 81:58]
  wire [11:0] _io_out_T_5 = 3'h2 == io_sel ? $signed(Simm) : $signed(_io_out_T_3); // @[Mux.scala 81:58]
  wire [12:0] _io_out_T_7 = 3'h5 == io_sel ? $signed(Bimm) : $signed({{1{_io_out_T_5[11]}},_io_out_T_5}); // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_9 = 3'h3 == io_sel ? $signed(Uimm) : $signed({{19{_io_out_T_7[12]}},_io_out_T_7}); // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_11 = 3'h4 == io_sel ? $signed({{11{Jimm[20]}},Jimm}) : $signed(_io_out_T_9); // @[Mux.scala 81:58]
  assign io_out = 3'h6 == io_sel ? $signed({{26{Zimm[5]}},Zimm}) : $signed(_io_out_T_11); // @[ImmGen.scala 33:5]
endmodule
module BrCondArea(
  input  [31:0] io_rs1,
  input  [31:0] io_rs2,
  input  [2:0]  io_br_type,
  output        io_taken
);
  wire [31:0] diff = io_rs1 - io_rs2; // @[BrCond.scala 41:21]
  wire  neq = |diff; // @[BrCond.scala 42:18]
  wire  eq = ~neq; // @[BrCond.scala 43:12]
  wire  isSameSign = io_rs1[31] == io_rs2[31]; // @[BrCond.scala 44:37]
  wire  lt = isSameSign ? diff[31] : io_rs1[31]; // @[BrCond.scala 45:15]
  wire  ltu = isSameSign ? diff[31] : io_rs2[31]; // @[BrCond.scala 46:16]
  wire  ge = ~lt; // @[BrCond.scala 47:12]
  wire  geu = ~ltu; // @[BrCond.scala 48:13]
  wire  _io_taken_T_3 = io_br_type == 3'h6 & neq; // @[BrCond.scala 51:31]
  wire  _io_taken_T_4 = io_br_type == 3'h3 & eq | _io_taken_T_3; // @[BrCond.scala 50:36]
  wire  _io_taken_T_6 = io_br_type == 3'h2 & lt; // @[BrCond.scala 52:31]
  wire  _io_taken_T_7 = _io_taken_T_4 | _io_taken_T_6; // @[BrCond.scala 51:39]
  wire  _io_taken_T_9 = io_br_type == 3'h5 & ge; // @[BrCond.scala 53:31]
  wire  _io_taken_T_10 = _io_taken_T_7 | _io_taken_T_9; // @[BrCond.scala 52:38]
  wire  _io_taken_T_12 = io_br_type == 3'h1 & ltu; // @[BrCond.scala 54:32]
  wire  _io_taken_T_13 = _io_taken_T_10 | _io_taken_T_12; // @[BrCond.scala 53:38]
  wire  _io_taken_T_15 = io_br_type == 3'h4 & geu; // @[BrCond.scala 55:32]
  assign io_taken = _io_taken_T_13 | _io_taken_T_15; // @[BrCond.scala 54:40]
endmodule
module Datapath(
  input         clock,
  input         reset,
  output        io_icache_req_valid,
  output [31:0] io_icache_req_bits_addr,
  input         io_icache_resp_valid,
  input  [31:0] io_icache_resp_bits_data,
  output        io_dcache_abort,
  output        io_dcache_req_valid,
  output [31:0] io_dcache_req_bits_addr,
  output [31:0] io_dcache_req_bits_data,
  output [3:0]  io_dcache_req_bits_mask,
  input         io_dcache_resp_valid,
  input  [31:0] io_dcache_resp_bits_data,
  output [31:0] io_ctrl_inst,
  input  [1:0]  io_ctrl_pc_sel,
  input         io_ctrl_inst_kill,
  input         io_ctrl_A_sel,
  input         io_ctrl_B_sel,
  input  [2:0]  io_ctrl_imm_sel,
  input  [3:0]  io_ctrl_alu_op,
  input  [2:0]  io_ctrl_br_type,
  input  [1:0]  io_ctrl_st_type,
  input  [2:0]  io_ctrl_ld_type,
  input  [1:0]  io_ctrl_wb_sel,
  input         io_ctrl_wb_en,
  input  [2:0]  io_ctrl_csr_cmd,
  input         io_ctrl_illegal
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [63:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire  csr_clock; // @[Datapath.scala 38:19]
  wire  csr_reset; // @[Datapath.scala 38:19]
  wire  csr_io_stall; // @[Datapath.scala 38:19]
  wire [2:0] csr_io_cmd; // @[Datapath.scala 38:19]
  wire [31:0] csr_io_in; // @[Datapath.scala 38:19]
  wire [31:0] csr_io_out; // @[Datapath.scala 38:19]
  wire [31:0] csr_io_pc; // @[Datapath.scala 38:19]
  wire [31:0] csr_io_addr; // @[Datapath.scala 38:19]
  wire [31:0] csr_io_inst; // @[Datapath.scala 38:19]
  wire  csr_io_illegal; // @[Datapath.scala 38:19]
  wire [1:0] csr_io_st_type; // @[Datapath.scala 38:19]
  wire [2:0] csr_io_ld_type; // @[Datapath.scala 38:19]
  wire  csr_io_pc_check; // @[Datapath.scala 38:19]
  wire  csr_io_expt; // @[Datapath.scala 38:19]
  wire [31:0] csr_io_evec; // @[Datapath.scala 38:19]
  wire [31:0] csr_io_epc; // @[Datapath.scala 38:19]
  wire  regFile_clock; // @[Datapath.scala 39:23]
  wire [4:0] regFile_io_raddr1; // @[Datapath.scala 39:23]
  wire [4:0] regFile_io_raddr2; // @[Datapath.scala 39:23]
  wire [31:0] regFile_io_rdata1; // @[Datapath.scala 39:23]
  wire [31:0] regFile_io_rdata2; // @[Datapath.scala 39:23]
  wire  regFile_io_wen; // @[Datapath.scala 39:23]
  wire [4:0] regFile_io_waddr; // @[Datapath.scala 39:23]
  wire [31:0] regFile_io_wdata; // @[Datapath.scala 39:23]
  wire [31:0] alu_io_A; // @[Datapath.scala 40:19]
  wire [31:0] alu_io_B; // @[Datapath.scala 40:19]
  wire [3:0] alu_io_alu_op; // @[Datapath.scala 40:19]
  wire [31:0] alu_io_out; // @[Datapath.scala 40:19]
  wire [31:0] alu_io_sum; // @[Datapath.scala 40:19]
  wire [31:0] immGen_io_inst; // @[Datapath.scala 41:22]
  wire [2:0] immGen_io_sel; // @[Datapath.scala 41:22]
  wire [31:0] immGen_io_out; // @[Datapath.scala 41:22]
  wire [31:0] brCond_io_rs1; // @[Datapath.scala 42:22]
  wire [31:0] brCond_io_rs2; // @[Datapath.scala 42:22]
  wire [2:0] brCond_io_br_type; // @[Datapath.scala 42:22]
  wire  brCond_io_taken; // @[Datapath.scala 42:22]
  reg [31:0] fe_reg_inst; // @[Datapath.scala 50:23]
  reg [31:0] fe_reg_pc; // @[Datapath.scala 50:23]
  reg [31:0] ew_reg_inst; // @[Datapath.scala 59:23]
  reg [31:0] ew_reg_pc; // @[Datapath.scala 59:23]
  reg [31:0] ew_reg_alu; // @[Datapath.scala 59:23]
  reg [31:0] ew_reg_csr_in; // @[Datapath.scala 59:23]
  reg [1:0] st_type; // @[Datapath.scala 75:20]
  reg [2:0] ld_type; // @[Datapath.scala 76:20]
  reg [1:0] wb_sel; // @[Datapath.scala 77:19]
  reg  wb_en; // @[Datapath.scala 78:18]
  reg [2:0] csr_cmd; // @[Datapath.scala 79:20]
  reg  illegal; // @[Datapath.scala 80:20]
  reg  pc_check; // @[Datapath.scala 81:21]
  reg  started; // @[Datapath.scala 86:24]
  wire  stall = ~io_icache_resp_valid | ~io_dcache_resp_valid; // @[Datapath.scala 88:37]
  wire [31:0] _pc_T_1 = 32'h200 - 32'h4; // @[Datapath.scala 90:50]
  reg [32:0] pc; // @[Datapath.scala 90:19]
  wire [32:0] _next_pc_T_1 = pc + 33'h4; // @[Datapath.scala 93:8]
  wire  _next_pc_T_2 = io_ctrl_pc_sel == 2'h3; // @[Datapath.scala 97:23]
  wire  _next_pc_T_3 = io_ctrl_pc_sel == 2'h1; // @[Datapath.scala 98:24]
  wire  _next_pc_T_4 = io_ctrl_pc_sel == 2'h1 | brCond_io_taken; // @[Datapath.scala 98:36]
  wire [31:0] _next_pc_T_5 = {{1'd0}, alu_io_sum[31:1]}; // @[Datapath.scala 98:73]
  wire [32:0] _next_pc_T_6 = {_next_pc_T_5, 1'h0}; // @[Datapath.scala 98:80]
  wire  _next_pc_T_7 = io_ctrl_pc_sel == 2'h2; // @[Datapath.scala 99:23]
  wire [32:0] _next_pc_T_8 = _next_pc_T_7 ? pc : _next_pc_T_1; // @[Mux.scala 101:16]
  wire [32:0] _next_pc_T_9 = _next_pc_T_4 ? _next_pc_T_6 : _next_pc_T_8; // @[Mux.scala 101:16]
  wire [32:0] _next_pc_T_10 = _next_pc_T_2 ? {{1'd0}, csr_io_epc} : _next_pc_T_9; // @[Mux.scala 101:16]
  wire [32:0] _next_pc_T_11 = csr_io_expt ? {{1'd0}, csr_io_evec} : _next_pc_T_10; // @[Mux.scala 101:16]
  wire [32:0] next_pc = stall ? pc : _next_pc_T_11; // @[Mux.scala 101:16]
  wire [31:0] inst = started | io_ctrl_inst_kill | brCond_io_taken | csr_io_expt ? 32'h13 : io_icache_resp_bits_data; // @[Datapath.scala 103:8]
  wire  _io_icache_req_valid_T = ~stall; // @[Datapath.scala 108:26]
  wire [32:0] _GEN_0 = _io_icache_req_valid_T ? pc : {{1'd0}, fe_reg_pc}; // @[Datapath.scala 112:16 113:15 50:23]
  wire [4:0] rs1_addr = fe_reg_inst[19:15]; // @[Datapath.scala 124:29]
  wire [4:0] rs2_addr = fe_reg_inst[24:20]; // @[Datapath.scala 125:29]
  wire [4:0] wb_rd_addr = ew_reg_inst[11:7]; // @[Datapath.scala 134:31]
  wire  rs1hazard = wb_en & |rs1_addr & rs1_addr == wb_rd_addr; // @[Datapath.scala 135:41]
  wire  rs2hazard = wb_en & |rs2_addr & rs2_addr == wb_rd_addr; // @[Datapath.scala 136:41]
  wire  _rs1_T = wb_sel == 2'h0; // @[Datapath.scala 137:24]
  wire [31:0] rs1 = wb_sel == 2'h0 & rs1hazard ? ew_reg_alu : regFile_io_rdata1; // @[Datapath.scala 137:16]
  wire [31:0] rs2 = _rs1_T & rs2hazard ? ew_reg_alu : regFile_io_rdata2; // @[Datapath.scala 138:16]
  wire [31:0] _daddr_T = stall ? ew_reg_alu : alu_io_sum; // @[Datapath.scala 151:18]
  wire [31:0] _daddr_T_1 = {{2'd0}, _daddr_T[31:2]}; // @[Datapath.scala 151:50]
  wire [33:0] _GEN_26 = {_daddr_T_1, 2'h0}; // @[Datapath.scala 151:57]
  wire [34:0] daddr = {{1'd0}, _GEN_26}; // @[Datapath.scala 151:57]
  wire [4:0] _GEN_27 = {alu_io_sum[1], 4'h0}; // @[Datapath.scala 152:32]
  wire [7:0] _woffset_T_1 = {{3'd0}, _GEN_27}; // @[Datapath.scala 152:32]
  wire [3:0] _woffset_T_3 = {alu_io_sum[0], 3'h0}; // @[Datapath.scala 152:64]
  wire [7:0] _GEN_28 = {{4'd0}, _woffset_T_3}; // @[Datapath.scala 152:47]
  wire [7:0] woffset = _woffset_T_1 | _GEN_28; // @[Datapath.scala 152:47]
  wire [286:0] _GEN_13 = {{255'd0}, rs2}; // @[Datapath.scala 155:34]
  wire [286:0] _io_dcache_req_bits_data_T = _GEN_13 << woffset; // @[Datapath.scala 155:34]
  wire [1:0] _io_dcache_req_bits_mask_T = stall ? st_type : io_ctrl_st_type; // @[Datapath.scala 157:8]
  wire [4:0] _io_dcache_req_bits_mask_T_2 = 5'h3 << alu_io_sum[1:0]; // @[Datapath.scala 159:47]
  wire [3:0] _io_dcache_req_bits_mask_T_4 = 4'h1 << alu_io_sum[1:0]; // @[Datapath.scala 159:86]
  wire [3:0] _io_dcache_req_bits_mask_T_6 = 2'h1 == _io_dcache_req_bits_mask_T ? 4'hf : 4'h0; // @[Mux.scala 81:58]
  wire [4:0] _io_dcache_req_bits_mask_T_8 = 2'h2 == _io_dcache_req_bits_mask_T ? _io_dcache_req_bits_mask_T_2 : {{1
    'd0}, _io_dcache_req_bits_mask_T_6}; // @[Mux.scala 81:58]
  wire [4:0] _io_dcache_req_bits_mask_T_10 = 2'h3 == _io_dcache_req_bits_mask_T ? {{1'd0}, _io_dcache_req_bits_mask_T_4}
     : _io_dcache_req_bits_mask_T_8; // @[Mux.scala 81:58]
  wire  _T_6 = ~csr_io_expt; // @[Datapath.scala 170:24]
  wire [4:0] _GEN_29 = {ew_reg_alu[1], 4'h0}; // @[Datapath.scala 185:32]
  wire [7:0] _loffset_T_1 = {{3'd0}, _GEN_29}; // @[Datapath.scala 185:32]
  wire [3:0] _loffset_T_3 = {ew_reg_alu[0], 3'h0}; // @[Datapath.scala 185:64]
  wire [7:0] _GEN_30 = {{4'd0}, _loffset_T_3}; // @[Datapath.scala 185:47]
  wire [7:0] loffset = _loffset_T_1 | _GEN_30; // @[Datapath.scala 185:47]
  wire [31:0] lshift = io_dcache_resp_bits_data >> loffset; // @[Datapath.scala 186:41]
  wire [32:0] _load_T = {1'b0,$signed(io_dcache_resp_bits_data)}; // @[Datapath.scala 189:30]
  wire [15:0] _load_T_2 = lshift[15:0]; // @[Datapath.scala 191:30]
  wire [7:0] _load_T_4 = lshift[7:0]; // @[Datapath.scala 192:29]
  wire [16:0] _load_T_6 = {1'b0,$signed(lshift[15:0])}; // @[Datapath.scala 193:31]
  wire [8:0] _load_T_8 = {1'b0,$signed(lshift[7:0])}; // @[Datapath.scala 194:30]
  wire [32:0] _load_T_10 = 3'h2 == ld_type ? $signed({{17{_load_T_2[15]}},_load_T_2}) : $signed(_load_T); // @[Mux.scala 81:58]
  wire [32:0] _load_T_12 = 3'h3 == ld_type ? $signed({{25{_load_T_4[7]}},_load_T_4}) : $signed(_load_T_10); // @[Mux.scala 81:58]
  wire [32:0] _load_T_14 = 3'h4 == ld_type ? $signed({{16{_load_T_6[16]}},_load_T_6}) : $signed(_load_T_12); // @[Mux.scala 81:58]
  wire [32:0] load = 3'h5 == ld_type ? $signed({{24{_load_T_8[8]}},_load_T_8}) : $signed(_load_T_14); // @[Mux.scala 81:58]
  wire [32:0] _regWrite_T = {1'b0,$signed(ew_reg_alu)}; // @[Datapath.scala 215:18]
  wire [31:0] _regWrite_T_2 = ew_reg_pc + 32'h4; // @[Datapath.scala 216:48]
  wire [32:0] _regWrite_T_3 = {1'b0,$signed(_regWrite_T_2)}; // @[Datapath.scala 216:55]
  wire [32:0] _regWrite_T_4 = {1'b0,$signed(csr_io_out)}; // @[Datapath.scala 216:82]
  wire [32:0] _regWrite_T_6 = 2'h1 == wb_sel ? $signed(load) : $signed(_regWrite_T); // @[Mux.scala 81:58]
  wire [32:0] _regWrite_T_8 = 2'h2 == wb_sel ? $signed(_regWrite_T_3) : $signed(_regWrite_T_6); // @[Mux.scala 81:58]
  wire [32:0] regWrite = 2'h3 == wb_sel ? $signed(_regWrite_T_4) : $signed(_regWrite_T_8); // @[Datapath.scala 217:7]
  wire [32:0] _GEN_31 = reset ? 33'h0 : _GEN_0; // @[Datapath.scala 50:{23,23}]
  CSR csr ( // @[Datapath.scala 38:19]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_stall(csr_io_stall),
    .io_cmd(csr_io_cmd),
    .io_in(csr_io_in),
    .io_out(csr_io_out),
    .io_pc(csr_io_pc),
    .io_addr(csr_io_addr),
    .io_inst(csr_io_inst),
    .io_illegal(csr_io_illegal),
    .io_st_type(csr_io_st_type),
    .io_ld_type(csr_io_ld_type),
    .io_pc_check(csr_io_pc_check),
    .io_expt(csr_io_expt),
    .io_evec(csr_io_evec),
    .io_epc(csr_io_epc)
  );
  RegFile regFile ( // @[Datapath.scala 39:23]
    .clock(regFile_clock),
    .io_raddr1(regFile_io_raddr1),
    .io_raddr2(regFile_io_raddr2),
    .io_rdata1(regFile_io_rdata1),
    .io_rdata2(regFile_io_rdata2),
    .io_wen(regFile_io_wen),
    .io_waddr(regFile_io_waddr),
    .io_wdata(regFile_io_wdata)
  );
  AluArea alu ( // @[Datapath.scala 40:19]
    .io_A(alu_io_A),
    .io_B(alu_io_B),
    .io_alu_op(alu_io_alu_op),
    .io_out(alu_io_out),
    .io_sum(alu_io_sum)
  );
  ImmGenWire immGen ( // @[Datapath.scala 41:22]
    .io_inst(immGen_io_inst),
    .io_sel(immGen_io_sel),
    .io_out(immGen_io_out)
  );
  BrCondArea brCond ( // @[Datapath.scala 42:22]
    .io_rs1(brCond_io_rs1),
    .io_rs2(brCond_io_rs2),
    .io_br_type(brCond_io_br_type),
    .io_taken(brCond_io_taken)
  );
  assign io_icache_req_valid = ~stall; // @[Datapath.scala 108:26]
  assign io_icache_req_bits_addr = next_pc[31:0]; // @[Datapath.scala 105:27]
  assign io_dcache_abort = csr_io_expt; // @[Datapath.scala 224:19]
  assign io_dcache_req_valid = _io_icache_req_valid_T & (|io_ctrl_st_type | |io_ctrl_ld_type); // @[Datapath.scala 153:33]
  assign io_dcache_req_bits_addr = daddr[31:0]; // @[Datapath.scala 154:27]
  assign io_dcache_req_bits_data = _io_dcache_req_bits_data_T[31:0]; // @[Datapath.scala 155:27]
  assign io_dcache_req_bits_mask = _io_dcache_req_bits_mask_T_10[3:0]; // @[Datapath.scala 156:27]
  assign io_ctrl_inst = fe_reg_inst; // @[Datapath.scala 120:16]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_stall = ~io_icache_resp_valid | ~io_dcache_resp_valid; // @[Datapath.scala 88:37]
  assign csr_io_cmd = csr_cmd; // @[Datapath.scala 201:14]
  assign csr_io_in = ew_reg_csr_in; // @[Datapath.scala 200:13]
  assign csr_io_pc = ew_reg_pc; // @[Datapath.scala 203:13]
  assign csr_io_addr = ew_reg_alu; // @[Datapath.scala 204:15]
  assign csr_io_inst = ew_reg_inst; // @[Datapath.scala 202:15]
  assign csr_io_illegal = illegal; // @[Datapath.scala 205:18]
  assign csr_io_st_type = st_type; // @[Datapath.scala 208:18]
  assign csr_io_ld_type = ld_type; // @[Datapath.scala 207:18]
  assign csr_io_pc_check = pc_check; // @[Datapath.scala 206:19]
  assign regFile_clock = clock;
  assign regFile_io_raddr1 = fe_reg_inst[19:15]; // @[Datapath.scala 124:29]
  assign regFile_io_raddr2 = fe_reg_inst[24:20]; // @[Datapath.scala 125:29]
  assign regFile_io_wen = wb_en & _io_icache_req_valid_T & _T_6; // @[Datapath.scala 219:37]
  assign regFile_io_waddr = ew_reg_inst[11:7]; // @[Datapath.scala 134:31]
  assign regFile_io_wdata = regWrite[31:0]; // @[Datapath.scala 221:20]
  assign alu_io_A = io_ctrl_A_sel ? rs1 : fe_reg_pc; // @[Datapath.scala 141:18]
  assign alu_io_B = io_ctrl_B_sel ? rs2 : immGen_io_out; // @[Datapath.scala 142:18]
  assign alu_io_alu_op = io_ctrl_alu_op; // @[Datapath.scala 143:17]
  assign immGen_io_inst = fe_reg_inst; // @[Datapath.scala 130:18]
  assign immGen_io_sel = io_ctrl_imm_sel; // @[Datapath.scala 131:17]
  assign brCond_io_rs1 = wb_sel == 2'h0 & rs1hazard ? ew_reg_alu : regFile_io_rdata1; // @[Datapath.scala 137:16]
  assign brCond_io_rs2 = _rs1_T & rs2hazard ? ew_reg_alu : regFile_io_rdata2; // @[Datapath.scala 138:16]
  assign brCond_io_br_type = io_ctrl_br_type; // @[Datapath.scala 148:21]
  always @(posedge clock) begin
    if (reset) begin // @[Datapath.scala 50:23]
      fe_reg_inst <= 32'h13; // @[Datapath.scala 50:23]
    end else if (_io_icache_req_valid_T) begin // @[Datapath.scala 112:16]
      if (inst == 32'h0) begin // @[Datapath.scala 114:23]
        fe_reg_inst <= 32'h13;
      end else if (started | io_ctrl_inst_kill | brCond_io_taken | csr_io_expt) begin // @[Datapath.scala 103:8]
        fe_reg_inst <= 32'h13;
      end else begin
        fe_reg_inst <= io_icache_resp_bits_data;
      end
    end
    fe_reg_pc <= _GEN_31[31:0]; // @[Datapath.scala 50:{23,23}]
    if (reset) begin // @[Datapath.scala 59:23]
      ew_reg_inst <= 32'h13; // @[Datapath.scala 59:23]
    end else if (!(reset | _io_icache_req_valid_T & csr_io_expt)) begin // @[Datapath.scala 163:47]
      if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
        ew_reg_inst <= fe_reg_inst; // @[Datapath.scala 172:17]
      end
    end
    if (reset) begin // @[Datapath.scala 59:23]
      ew_reg_pc <= 32'h0; // @[Datapath.scala 59:23]
    end else if (!(reset | _io_icache_req_valid_T & csr_io_expt)) begin // @[Datapath.scala 163:47]
      if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
        ew_reg_pc <= fe_reg_pc; // @[Datapath.scala 171:15]
      end
    end
    if (reset) begin // @[Datapath.scala 59:23]
      ew_reg_alu <= 32'h0; // @[Datapath.scala 59:23]
    end else if (!(reset | _io_icache_req_valid_T & csr_io_expt)) begin // @[Datapath.scala 163:47]
      if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
        ew_reg_alu <= alu_io_out; // @[Datapath.scala 173:16]
      end
    end
    if (reset) begin // @[Datapath.scala 59:23]
      ew_reg_csr_in <= 32'h0; // @[Datapath.scala 59:23]
    end else if (!(reset | _io_icache_req_valid_T & csr_io_expt)) begin // @[Datapath.scala 163:47]
      if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
        if (io_ctrl_imm_sel == 3'h6) begin // @[Datapath.scala 174:25]
          ew_reg_csr_in <= immGen_io_out;
        end else begin
          ew_reg_csr_in <= rs1;
        end
      end
    end
    if (reset | _io_icache_req_valid_T & csr_io_expt) begin // @[Datapath.scala 163:47]
      st_type <= 2'h0; // @[Datapath.scala 164:13]
    end else if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
      st_type <= io_ctrl_st_type; // @[Datapath.scala 175:13]
    end
    if (reset | _io_icache_req_valid_T & csr_io_expt) begin // @[Datapath.scala 163:47]
      ld_type <= 3'h0; // @[Datapath.scala 165:13]
    end else if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
      ld_type <= io_ctrl_ld_type; // @[Datapath.scala 176:13]
    end
    if (!(reset | _io_icache_req_valid_T & csr_io_expt)) begin // @[Datapath.scala 163:47]
      if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
        wb_sel <= io_ctrl_wb_sel; // @[Datapath.scala 177:12]
      end
    end
    if (reset | _io_icache_req_valid_T & csr_io_expt) begin // @[Datapath.scala 163:47]
      wb_en <= 1'h0; // @[Datapath.scala 166:11]
    end else if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
      wb_en <= io_ctrl_wb_en; // @[Datapath.scala 178:11]
    end
    if (reset | _io_icache_req_valid_T & csr_io_expt) begin // @[Datapath.scala 163:47]
      csr_cmd <= 3'h0; // @[Datapath.scala 167:13]
    end else if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
      csr_cmd <= io_ctrl_csr_cmd; // @[Datapath.scala 179:13]
    end
    if (reset | _io_icache_req_valid_T & csr_io_expt) begin // @[Datapath.scala 163:47]
      illegal <= 1'h0; // @[Datapath.scala 168:13]
    end else if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
      illegal <= io_ctrl_illegal; // @[Datapath.scala 180:13]
    end
    if (reset | _io_icache_req_valid_T & csr_io_expt) begin // @[Datapath.scala 163:47]
      pc_check <= 1'h0; // @[Datapath.scala 169:14]
    end else if (_io_icache_req_valid_T & ~csr_io_expt) begin // @[Datapath.scala 170:38]
      pc_check <= _next_pc_T_3; // @[Datapath.scala 181:14]
    end
    started <= reset; // @[Datapath.scala 86:31]
    if (reset) begin // @[Datapath.scala 90:19]
      pc <= {{1'd0}, _pc_T_1}; // @[Datapath.scala 90:19]
    end else if (!(stall)) begin // @[Mux.scala 101:16]
      if (csr_io_expt) begin // @[Mux.scala 101:16]
        pc <= {{1'd0}, csr_io_evec};
      end else if (_next_pc_T_2) begin // @[Mux.scala 101:16]
        pc <= {{1'd0}, csr_io_epc};
      end else begin
        pc <= _next_pc_T_9;
      end
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
  _RAND_0 = {1{`RANDOM}};
  fe_reg_inst = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  fe_reg_pc = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  ew_reg_inst = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  ew_reg_pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  ew_reg_alu = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  ew_reg_csr_in = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  st_type = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  ld_type = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  wb_sel = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  wb_en = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  csr_cmd = _RAND_10[2:0];
  _RAND_11 = {1{`RANDOM}};
  illegal = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  pc_check = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  started = _RAND_13[0:0];
  _RAND_14 = {2{`RANDOM}};
  pc = _RAND_14[32:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Control(
  input  [31:0] io_inst,
  output [1:0]  io_pc_sel,
  output        io_inst_kill,
  output        io_A_sel,
  output        io_B_sel,
  output [2:0]  io_imm_sel,
  output [3:0]  io_alu_op,
  output [2:0]  io_br_type,
  output [1:0]  io_st_type,
  output [2:0]  io_ld_type,
  output [1:0]  io_wb_sel,
  output        io_wb_en,
  output [2:0]  io_csr_cmd,
  output        io_illegal
);
  wire [31:0] _ctrlSignals_T = io_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_1 = 32'h37 == _ctrlSignals_T; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_3 = 32'h17 == _ctrlSignals_T; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_5 = 32'h6f == _ctrlSignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _ctrlSignals_T_6 = io_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_7 = 32'h67 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_9 = 32'h63 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_11 = 32'h1063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_13 = 32'h4063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_15 = 32'h5063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_17 = 32'h6063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_19 = 32'h7063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_21 = 32'h3 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_23 = 32'h1003 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_25 = 32'h2003 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_27 = 32'h4003 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_29 = 32'h5003 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_31 = 32'h23 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_33 = 32'h1023 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_35 = 32'h2023 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_37 = 32'h13 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_39 = 32'h2013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_41 = 32'h3013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_43 = 32'h4013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_45 = 32'h6013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_47 = 32'h7013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire [31:0] _ctrlSignals_T_48 = io_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_49 = 32'h1013 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_51 = 32'h5013 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_53 = 32'h40005013 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_55 = 32'h33 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_57 = 32'h40000033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_59 = 32'h1033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_61 = 32'h2033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_63 = 32'h3033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_65 = 32'h4033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_67 = 32'h5033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_69 = 32'h40005033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_71 = 32'h6033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_73 = 32'h7033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire [31:0] _ctrlSignals_T_74 = io_inst & 32'hf00fffff; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_75 = 32'hf == _ctrlSignals_T_74; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_77 = 32'h100f == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_79 = 32'h1073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_81 = 32'h2073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_83 = 32'h3073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_85 = 32'h5073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_87 = 32'h6073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_89 = 32'h7073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_91 = 32'h73 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_93 = 32'h100073 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_95 = 32'h10000073 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_97 = 32'h10200073 == io_inst; // @[Lookup.scala 31:38]
  wire [1:0] _ctrlSignals_T_99 = _ctrlSignals_T_95 ? 2'h3 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_100 = _ctrlSignals_T_93 ? 2'h0 : _ctrlSignals_T_99; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_101 = _ctrlSignals_T_91 ? 2'h0 : _ctrlSignals_T_100; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_102 = _ctrlSignals_T_89 ? 2'h2 : _ctrlSignals_T_101; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_103 = _ctrlSignals_T_87 ? 2'h2 : _ctrlSignals_T_102; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_104 = _ctrlSignals_T_85 ? 2'h2 : _ctrlSignals_T_103; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_105 = _ctrlSignals_T_83 ? 2'h2 : _ctrlSignals_T_104; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_106 = _ctrlSignals_T_81 ? 2'h2 : _ctrlSignals_T_105; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_107 = _ctrlSignals_T_79 ? 2'h2 : _ctrlSignals_T_106; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_108 = _ctrlSignals_T_77 ? 2'h2 : _ctrlSignals_T_107; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_109 = _ctrlSignals_T_75 ? 2'h0 : _ctrlSignals_T_108; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_110 = _ctrlSignals_T_73 ? 2'h0 : _ctrlSignals_T_109; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_111 = _ctrlSignals_T_71 ? 2'h0 : _ctrlSignals_T_110; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_112 = _ctrlSignals_T_69 ? 2'h0 : _ctrlSignals_T_111; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_113 = _ctrlSignals_T_67 ? 2'h0 : _ctrlSignals_T_112; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_114 = _ctrlSignals_T_65 ? 2'h0 : _ctrlSignals_T_113; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_115 = _ctrlSignals_T_63 ? 2'h0 : _ctrlSignals_T_114; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_116 = _ctrlSignals_T_61 ? 2'h0 : _ctrlSignals_T_115; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_117 = _ctrlSignals_T_59 ? 2'h0 : _ctrlSignals_T_116; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_118 = _ctrlSignals_T_57 ? 2'h0 : _ctrlSignals_T_117; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_119 = _ctrlSignals_T_55 ? 2'h0 : _ctrlSignals_T_118; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_120 = _ctrlSignals_T_53 ? 2'h0 : _ctrlSignals_T_119; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_121 = _ctrlSignals_T_51 ? 2'h0 : _ctrlSignals_T_120; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_122 = _ctrlSignals_T_49 ? 2'h0 : _ctrlSignals_T_121; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_123 = _ctrlSignals_T_47 ? 2'h0 : _ctrlSignals_T_122; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_124 = _ctrlSignals_T_45 ? 2'h0 : _ctrlSignals_T_123; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_125 = _ctrlSignals_T_43 ? 2'h0 : _ctrlSignals_T_124; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_126 = _ctrlSignals_T_41 ? 2'h0 : _ctrlSignals_T_125; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_127 = _ctrlSignals_T_39 ? 2'h0 : _ctrlSignals_T_126; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_128 = _ctrlSignals_T_37 ? 2'h0 : _ctrlSignals_T_127; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_129 = _ctrlSignals_T_35 ? 2'h0 : _ctrlSignals_T_128; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_130 = _ctrlSignals_T_33 ? 2'h0 : _ctrlSignals_T_129; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_131 = _ctrlSignals_T_31 ? 2'h0 : _ctrlSignals_T_130; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_132 = _ctrlSignals_T_29 ? 2'h2 : _ctrlSignals_T_131; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_133 = _ctrlSignals_T_27 ? 2'h2 : _ctrlSignals_T_132; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_134 = _ctrlSignals_T_25 ? 2'h2 : _ctrlSignals_T_133; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_135 = _ctrlSignals_T_23 ? 2'h2 : _ctrlSignals_T_134; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_136 = _ctrlSignals_T_21 ? 2'h2 : _ctrlSignals_T_135; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_137 = _ctrlSignals_T_19 ? 2'h0 : _ctrlSignals_T_136; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_138 = _ctrlSignals_T_17 ? 2'h0 : _ctrlSignals_T_137; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_139 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_138; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_140 = _ctrlSignals_T_13 ? 2'h0 : _ctrlSignals_T_139; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_141 = _ctrlSignals_T_11 ? 2'h0 : _ctrlSignals_T_140; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_142 = _ctrlSignals_T_9 ? 2'h0 : _ctrlSignals_T_141; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_143 = _ctrlSignals_T_7 ? 2'h1 : _ctrlSignals_T_142; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_144 = _ctrlSignals_T_5 ? 2'h1 : _ctrlSignals_T_143; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_145 = _ctrlSignals_T_3 ? 2'h0 : _ctrlSignals_T_144; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_156 = _ctrlSignals_T_77 ? 1'h0 : _ctrlSignals_T_79 | (_ctrlSignals_T_81 | _ctrlSignals_T_83); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_157 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_156; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_185 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_21 | (_ctrlSignals_T_23 | (_ctrlSignals_T_25 | (
    _ctrlSignals_T_27 | (_ctrlSignals_T_29 | (_ctrlSignals_T_31 | (_ctrlSignals_T_33 | (_ctrlSignals_T_35 | (
    _ctrlSignals_T_37 | (_ctrlSignals_T_39 | (_ctrlSignals_T_41 | (_ctrlSignals_T_43 | (_ctrlSignals_T_45 | (
    _ctrlSignals_T_47 | (_ctrlSignals_T_49 | (_ctrlSignals_T_51 | (_ctrlSignals_T_53 | (_ctrlSignals_T_55 | (
    _ctrlSignals_T_57 | (_ctrlSignals_T_59 | (_ctrlSignals_T_61 | (_ctrlSignals_T_63 | (_ctrlSignals_T_65 | (
    _ctrlSignals_T_67 | (_ctrlSignals_T_69 | (_ctrlSignals_T_71 | (_ctrlSignals_T_73 | _ctrlSignals_T_157)))))))))))))))
    ))))))))))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_186 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_185; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_187 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_186; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_188 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_187; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_189 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_188; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_190 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_189; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_192 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_7 | _ctrlSignals_T_190; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_193 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_192; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_216 = _ctrlSignals_T_53 ? 1'h0 : _ctrlSignals_T_55 | (_ctrlSignals_T_57 | (_ctrlSignals_T_59 | (
    _ctrlSignals_T_61 | (_ctrlSignals_T_63 | (_ctrlSignals_T_65 | (_ctrlSignals_T_67 | (_ctrlSignals_T_69 | (
    _ctrlSignals_T_71 | _ctrlSignals_T_73)))))))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_217 = _ctrlSignals_T_51 ? 1'h0 : _ctrlSignals_T_216; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_218 = _ctrlSignals_T_49 ? 1'h0 : _ctrlSignals_T_217; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_219 = _ctrlSignals_T_47 ? 1'h0 : _ctrlSignals_T_218; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_220 = _ctrlSignals_T_45 ? 1'h0 : _ctrlSignals_T_219; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_221 = _ctrlSignals_T_43 ? 1'h0 : _ctrlSignals_T_220; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_222 = _ctrlSignals_T_41 ? 1'h0 : _ctrlSignals_T_221; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_223 = _ctrlSignals_T_39 ? 1'h0 : _ctrlSignals_T_222; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_224 = _ctrlSignals_T_37 ? 1'h0 : _ctrlSignals_T_223; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_225 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_224; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_226 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_225; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_227 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_226; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_228 = _ctrlSignals_T_29 ? 1'h0 : _ctrlSignals_T_227; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_229 = _ctrlSignals_T_27 ? 1'h0 : _ctrlSignals_T_228; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_230 = _ctrlSignals_T_25 ? 1'h0 : _ctrlSignals_T_229; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_231 = _ctrlSignals_T_23 ? 1'h0 : _ctrlSignals_T_230; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_232 = _ctrlSignals_T_21 ? 1'h0 : _ctrlSignals_T_231; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_233 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_232; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_234 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_233; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_235 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_234; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_236 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_235; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_237 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_236; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_238 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_237; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_239 = _ctrlSignals_T_7 ? 1'h0 : _ctrlSignals_T_238; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_240 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_239; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_241 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_240; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_246 = _ctrlSignals_T_89 ? 3'h6 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_247 = _ctrlSignals_T_87 ? 3'h6 : _ctrlSignals_T_246; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_248 = _ctrlSignals_T_85 ? 3'h6 : _ctrlSignals_T_247; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_249 = _ctrlSignals_T_83 ? 3'h0 : _ctrlSignals_T_248; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_250 = _ctrlSignals_T_81 ? 3'h0 : _ctrlSignals_T_249; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_251 = _ctrlSignals_T_79 ? 3'h0 : _ctrlSignals_T_250; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_252 = _ctrlSignals_T_77 ? 3'h0 : _ctrlSignals_T_251; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_253 = _ctrlSignals_T_75 ? 3'h0 : _ctrlSignals_T_252; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_254 = _ctrlSignals_T_73 ? 3'h0 : _ctrlSignals_T_253; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_255 = _ctrlSignals_T_71 ? 3'h0 : _ctrlSignals_T_254; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_256 = _ctrlSignals_T_69 ? 3'h0 : _ctrlSignals_T_255; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_257 = _ctrlSignals_T_67 ? 3'h0 : _ctrlSignals_T_256; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_258 = _ctrlSignals_T_65 ? 3'h0 : _ctrlSignals_T_257; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_259 = _ctrlSignals_T_63 ? 3'h0 : _ctrlSignals_T_258; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_260 = _ctrlSignals_T_61 ? 3'h0 : _ctrlSignals_T_259; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_261 = _ctrlSignals_T_59 ? 3'h0 : _ctrlSignals_T_260; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_262 = _ctrlSignals_T_57 ? 3'h0 : _ctrlSignals_T_261; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_263 = _ctrlSignals_T_55 ? 3'h0 : _ctrlSignals_T_262; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_264 = _ctrlSignals_T_53 ? 3'h1 : _ctrlSignals_T_263; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_265 = _ctrlSignals_T_51 ? 3'h1 : _ctrlSignals_T_264; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_266 = _ctrlSignals_T_49 ? 3'h1 : _ctrlSignals_T_265; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_267 = _ctrlSignals_T_47 ? 3'h1 : _ctrlSignals_T_266; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_268 = _ctrlSignals_T_45 ? 3'h1 : _ctrlSignals_T_267; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_269 = _ctrlSignals_T_43 ? 3'h1 : _ctrlSignals_T_268; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_270 = _ctrlSignals_T_41 ? 3'h1 : _ctrlSignals_T_269; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_271 = _ctrlSignals_T_39 ? 3'h1 : _ctrlSignals_T_270; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_272 = _ctrlSignals_T_37 ? 3'h1 : _ctrlSignals_T_271; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_273 = _ctrlSignals_T_35 ? 3'h2 : _ctrlSignals_T_272; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_274 = _ctrlSignals_T_33 ? 3'h2 : _ctrlSignals_T_273; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_275 = _ctrlSignals_T_31 ? 3'h2 : _ctrlSignals_T_274; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_276 = _ctrlSignals_T_29 ? 3'h1 : _ctrlSignals_T_275; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_277 = _ctrlSignals_T_27 ? 3'h1 : _ctrlSignals_T_276; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_278 = _ctrlSignals_T_25 ? 3'h1 : _ctrlSignals_T_277; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_279 = _ctrlSignals_T_23 ? 3'h1 : _ctrlSignals_T_278; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_280 = _ctrlSignals_T_21 ? 3'h1 : _ctrlSignals_T_279; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_281 = _ctrlSignals_T_19 ? 3'h5 : _ctrlSignals_T_280; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_282 = _ctrlSignals_T_17 ? 3'h5 : _ctrlSignals_T_281; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_283 = _ctrlSignals_T_15 ? 3'h5 : _ctrlSignals_T_282; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_284 = _ctrlSignals_T_13 ? 3'h5 : _ctrlSignals_T_283; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_285 = _ctrlSignals_T_11 ? 3'h5 : _ctrlSignals_T_284; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_286 = _ctrlSignals_T_9 ? 3'h5 : _ctrlSignals_T_285; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_287 = _ctrlSignals_T_7 ? 3'h1 : _ctrlSignals_T_286; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_288 = _ctrlSignals_T_5 ? 3'h4 : _ctrlSignals_T_287; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_289 = _ctrlSignals_T_3 ? 3'h3 : _ctrlSignals_T_288; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_297 = _ctrlSignals_T_83 ? 4'ha : 4'hf; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_298 = _ctrlSignals_T_81 ? 4'ha : _ctrlSignals_T_297; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_299 = _ctrlSignals_T_79 ? 4'ha : _ctrlSignals_T_298; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_300 = _ctrlSignals_T_77 ? 4'hf : _ctrlSignals_T_299; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_301 = _ctrlSignals_T_75 ? 4'hf : _ctrlSignals_T_300; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_302 = _ctrlSignals_T_73 ? 4'h2 : _ctrlSignals_T_301; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_303 = _ctrlSignals_T_71 ? 4'h3 : _ctrlSignals_T_302; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_304 = _ctrlSignals_T_69 ? 4'h9 : _ctrlSignals_T_303; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_305 = _ctrlSignals_T_67 ? 4'h8 : _ctrlSignals_T_304; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_306 = _ctrlSignals_T_65 ? 4'h4 : _ctrlSignals_T_305; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_307 = _ctrlSignals_T_63 ? 4'h7 : _ctrlSignals_T_306; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_308 = _ctrlSignals_T_61 ? 4'h5 : _ctrlSignals_T_307; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_309 = _ctrlSignals_T_59 ? 4'h6 : _ctrlSignals_T_308; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_310 = _ctrlSignals_T_57 ? 4'h1 : _ctrlSignals_T_309; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_311 = _ctrlSignals_T_55 ? 4'h0 : _ctrlSignals_T_310; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_312 = _ctrlSignals_T_53 ? 4'h9 : _ctrlSignals_T_311; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_313 = _ctrlSignals_T_51 ? 4'h8 : _ctrlSignals_T_312; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_314 = _ctrlSignals_T_49 ? 4'h6 : _ctrlSignals_T_313; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_315 = _ctrlSignals_T_47 ? 4'h2 : _ctrlSignals_T_314; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_316 = _ctrlSignals_T_45 ? 4'h3 : _ctrlSignals_T_315; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_317 = _ctrlSignals_T_43 ? 4'h4 : _ctrlSignals_T_316; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_318 = _ctrlSignals_T_41 ? 4'h7 : _ctrlSignals_T_317; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_319 = _ctrlSignals_T_39 ? 4'h5 : _ctrlSignals_T_318; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_320 = _ctrlSignals_T_37 ? 4'h0 : _ctrlSignals_T_319; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_321 = _ctrlSignals_T_35 ? 4'h0 : _ctrlSignals_T_320; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_322 = _ctrlSignals_T_33 ? 4'h0 : _ctrlSignals_T_321; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_323 = _ctrlSignals_T_31 ? 4'h0 : _ctrlSignals_T_322; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_324 = _ctrlSignals_T_29 ? 4'h0 : _ctrlSignals_T_323; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_325 = _ctrlSignals_T_27 ? 4'h0 : _ctrlSignals_T_324; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_326 = _ctrlSignals_T_25 ? 4'h0 : _ctrlSignals_T_325; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_327 = _ctrlSignals_T_23 ? 4'h0 : _ctrlSignals_T_326; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_328 = _ctrlSignals_T_21 ? 4'h0 : _ctrlSignals_T_327; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_329 = _ctrlSignals_T_19 ? 4'h0 : _ctrlSignals_T_328; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_330 = _ctrlSignals_T_17 ? 4'h0 : _ctrlSignals_T_329; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_331 = _ctrlSignals_T_15 ? 4'h0 : _ctrlSignals_T_330; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_332 = _ctrlSignals_T_13 ? 4'h0 : _ctrlSignals_T_331; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_333 = _ctrlSignals_T_11 ? 4'h0 : _ctrlSignals_T_332; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_334 = _ctrlSignals_T_9 ? 4'h0 : _ctrlSignals_T_333; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_335 = _ctrlSignals_T_7 ? 4'h0 : _ctrlSignals_T_334; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_336 = _ctrlSignals_T_5 ? 4'h0 : _ctrlSignals_T_335; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_337 = _ctrlSignals_T_3 ? 4'h0 : _ctrlSignals_T_336; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_377 = _ctrlSignals_T_19 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_378 = _ctrlSignals_T_17 ? 3'h1 : _ctrlSignals_T_377; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_379 = _ctrlSignals_T_15 ? 3'h5 : _ctrlSignals_T_378; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_380 = _ctrlSignals_T_13 ? 3'h2 : _ctrlSignals_T_379; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_381 = _ctrlSignals_T_11 ? 3'h6 : _ctrlSignals_T_380; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_382 = _ctrlSignals_T_9 ? 3'h3 : _ctrlSignals_T_381; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_383 = _ctrlSignals_T_7 ? 3'h0 : _ctrlSignals_T_382; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_384 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_383; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_385 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_384; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_388 = _ctrlSignals_T_93 ? 1'h0 : _ctrlSignals_T_95; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_389 = _ctrlSignals_T_91 ? 1'h0 : _ctrlSignals_T_388; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_397 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_77 | (_ctrlSignals_T_79 | (_ctrlSignals_T_81 | (
    _ctrlSignals_T_83 | (_ctrlSignals_T_85 | (_ctrlSignals_T_87 | (_ctrlSignals_T_89 | _ctrlSignals_T_389)))))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_398 = _ctrlSignals_T_73 ? 1'h0 : _ctrlSignals_T_397; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_399 = _ctrlSignals_T_71 ? 1'h0 : _ctrlSignals_T_398; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_400 = _ctrlSignals_T_69 ? 1'h0 : _ctrlSignals_T_399; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_401 = _ctrlSignals_T_67 ? 1'h0 : _ctrlSignals_T_400; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_402 = _ctrlSignals_T_65 ? 1'h0 : _ctrlSignals_T_401; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_403 = _ctrlSignals_T_63 ? 1'h0 : _ctrlSignals_T_402; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_404 = _ctrlSignals_T_61 ? 1'h0 : _ctrlSignals_T_403; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_405 = _ctrlSignals_T_59 ? 1'h0 : _ctrlSignals_T_404; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_406 = _ctrlSignals_T_57 ? 1'h0 : _ctrlSignals_T_405; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_407 = _ctrlSignals_T_55 ? 1'h0 : _ctrlSignals_T_406; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_408 = _ctrlSignals_T_53 ? 1'h0 : _ctrlSignals_T_407; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_409 = _ctrlSignals_T_51 ? 1'h0 : _ctrlSignals_T_408; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_410 = _ctrlSignals_T_49 ? 1'h0 : _ctrlSignals_T_409; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_411 = _ctrlSignals_T_47 ? 1'h0 : _ctrlSignals_T_410; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_412 = _ctrlSignals_T_45 ? 1'h0 : _ctrlSignals_T_411; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_413 = _ctrlSignals_T_43 ? 1'h0 : _ctrlSignals_T_412; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_414 = _ctrlSignals_T_41 ? 1'h0 : _ctrlSignals_T_413; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_415 = _ctrlSignals_T_39 ? 1'h0 : _ctrlSignals_T_414; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_416 = _ctrlSignals_T_37 ? 1'h0 : _ctrlSignals_T_415; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_417 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_416; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_418 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_417; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_419 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_418; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_425 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_21 | (_ctrlSignals_T_23 | (_ctrlSignals_T_25 | (
    _ctrlSignals_T_27 | (_ctrlSignals_T_29 | _ctrlSignals_T_419)))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_426 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_425; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_427 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_426; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_428 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_427; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_429 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_428; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_430 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_429; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_433 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_5 | (_ctrlSignals_T_7 | _ctrlSignals_T_430); // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_465 = _ctrlSignals_T_35 ? 2'h1 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_466 = _ctrlSignals_T_33 ? 2'h2 : _ctrlSignals_T_465; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_467 = _ctrlSignals_T_31 ? 2'h3 : _ctrlSignals_T_466; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_468 = _ctrlSignals_T_29 ? 2'h0 : _ctrlSignals_T_467; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_469 = _ctrlSignals_T_27 ? 2'h0 : _ctrlSignals_T_468; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_470 = _ctrlSignals_T_25 ? 2'h0 : _ctrlSignals_T_469; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_471 = _ctrlSignals_T_23 ? 2'h0 : _ctrlSignals_T_470; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_472 = _ctrlSignals_T_21 ? 2'h0 : _ctrlSignals_T_471; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_473 = _ctrlSignals_T_19 ? 2'h0 : _ctrlSignals_T_472; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_474 = _ctrlSignals_T_17 ? 2'h0 : _ctrlSignals_T_473; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_475 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_474; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_476 = _ctrlSignals_T_13 ? 2'h0 : _ctrlSignals_T_475; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_477 = _ctrlSignals_T_11 ? 2'h0 : _ctrlSignals_T_476; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_478 = _ctrlSignals_T_9 ? 2'h0 : _ctrlSignals_T_477; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_479 = _ctrlSignals_T_7 ? 2'h0 : _ctrlSignals_T_478; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_480 = _ctrlSignals_T_5 ? 2'h0 : _ctrlSignals_T_479; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_481 = _ctrlSignals_T_3 ? 2'h0 : _ctrlSignals_T_480; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_516 = _ctrlSignals_T_29 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_517 = _ctrlSignals_T_27 ? 3'h5 : _ctrlSignals_T_516; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_518 = _ctrlSignals_T_25 ? 3'h1 : _ctrlSignals_T_517; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_519 = _ctrlSignals_T_23 ? 3'h2 : _ctrlSignals_T_518; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_520 = _ctrlSignals_T_21 ? 3'h3 : _ctrlSignals_T_519; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_521 = _ctrlSignals_T_19 ? 3'h0 : _ctrlSignals_T_520; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_522 = _ctrlSignals_T_17 ? 3'h0 : _ctrlSignals_T_521; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_523 = _ctrlSignals_T_15 ? 3'h0 : _ctrlSignals_T_522; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_524 = _ctrlSignals_T_13 ? 3'h0 : _ctrlSignals_T_523; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_525 = _ctrlSignals_T_11 ? 3'h0 : _ctrlSignals_T_524; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_526 = _ctrlSignals_T_9 ? 3'h0 : _ctrlSignals_T_525; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_527 = _ctrlSignals_T_7 ? 3'h0 : _ctrlSignals_T_526; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_528 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_527; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_529 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_528; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_532 = _ctrlSignals_T_93 ? 2'h3 : _ctrlSignals_T_99; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_533 = _ctrlSignals_T_91 ? 2'h3 : _ctrlSignals_T_532; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_534 = _ctrlSignals_T_89 ? 2'h3 : _ctrlSignals_T_533; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_535 = _ctrlSignals_T_87 ? 2'h3 : _ctrlSignals_T_534; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_536 = _ctrlSignals_T_85 ? 2'h3 : _ctrlSignals_T_535; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_537 = _ctrlSignals_T_83 ? 2'h3 : _ctrlSignals_T_536; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_538 = _ctrlSignals_T_81 ? 2'h3 : _ctrlSignals_T_537; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_539 = _ctrlSignals_T_79 ? 2'h3 : _ctrlSignals_T_538; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_540 = _ctrlSignals_T_77 ? 2'h0 : _ctrlSignals_T_539; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_541 = _ctrlSignals_T_75 ? 2'h0 : _ctrlSignals_T_540; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_542 = _ctrlSignals_T_73 ? 2'h0 : _ctrlSignals_T_541; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_543 = _ctrlSignals_T_71 ? 2'h0 : _ctrlSignals_T_542; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_544 = _ctrlSignals_T_69 ? 2'h0 : _ctrlSignals_T_543; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_545 = _ctrlSignals_T_67 ? 2'h0 : _ctrlSignals_T_544; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_546 = _ctrlSignals_T_65 ? 2'h0 : _ctrlSignals_T_545; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_547 = _ctrlSignals_T_63 ? 2'h0 : _ctrlSignals_T_546; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_548 = _ctrlSignals_T_61 ? 2'h0 : _ctrlSignals_T_547; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_549 = _ctrlSignals_T_59 ? 2'h0 : _ctrlSignals_T_548; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_550 = _ctrlSignals_T_57 ? 2'h0 : _ctrlSignals_T_549; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_551 = _ctrlSignals_T_55 ? 2'h0 : _ctrlSignals_T_550; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_552 = _ctrlSignals_T_53 ? 2'h0 : _ctrlSignals_T_551; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_553 = _ctrlSignals_T_51 ? 2'h0 : _ctrlSignals_T_552; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_554 = _ctrlSignals_T_49 ? 2'h0 : _ctrlSignals_T_553; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_555 = _ctrlSignals_T_47 ? 2'h0 : _ctrlSignals_T_554; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_556 = _ctrlSignals_T_45 ? 2'h0 : _ctrlSignals_T_555; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_557 = _ctrlSignals_T_43 ? 2'h0 : _ctrlSignals_T_556; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_558 = _ctrlSignals_T_41 ? 2'h0 : _ctrlSignals_T_557; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_559 = _ctrlSignals_T_39 ? 2'h0 : _ctrlSignals_T_558; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_560 = _ctrlSignals_T_37 ? 2'h0 : _ctrlSignals_T_559; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_561 = _ctrlSignals_T_35 ? 2'h0 : _ctrlSignals_T_560; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_562 = _ctrlSignals_T_33 ? 2'h0 : _ctrlSignals_T_561; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_563 = _ctrlSignals_T_31 ? 2'h0 : _ctrlSignals_T_562; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_564 = _ctrlSignals_T_29 ? 2'h1 : _ctrlSignals_T_563; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_565 = _ctrlSignals_T_27 ? 2'h1 : _ctrlSignals_T_564; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_566 = _ctrlSignals_T_25 ? 2'h1 : _ctrlSignals_T_565; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_567 = _ctrlSignals_T_23 ? 2'h1 : _ctrlSignals_T_566; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_568 = _ctrlSignals_T_21 ? 2'h1 : _ctrlSignals_T_567; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_569 = _ctrlSignals_T_19 ? 2'h0 : _ctrlSignals_T_568; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_570 = _ctrlSignals_T_17 ? 2'h0 : _ctrlSignals_T_569; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_571 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_570; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_572 = _ctrlSignals_T_13 ? 2'h0 : _ctrlSignals_T_571; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_573 = _ctrlSignals_T_11 ? 2'h0 : _ctrlSignals_T_572; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_574 = _ctrlSignals_T_9 ? 2'h0 : _ctrlSignals_T_573; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_575 = _ctrlSignals_T_7 ? 2'h2 : _ctrlSignals_T_574; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_576 = _ctrlSignals_T_5 ? 2'h2 : _ctrlSignals_T_575; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_577 = _ctrlSignals_T_3 ? 2'h0 : _ctrlSignals_T_576; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_588 = _ctrlSignals_T_77 ? 1'h0 : _ctrlSignals_T_79 | (_ctrlSignals_T_81 | (_ctrlSignals_T_83 | (
    _ctrlSignals_T_85 | (_ctrlSignals_T_87 | _ctrlSignals_T_89)))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_589 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_588; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_609 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_37 | (_ctrlSignals_T_39 | (_ctrlSignals_T_41 | (
    _ctrlSignals_T_43 | (_ctrlSignals_T_45 | (_ctrlSignals_T_47 | (_ctrlSignals_T_49 | (_ctrlSignals_T_51 | (
    _ctrlSignals_T_53 | (_ctrlSignals_T_55 | (_ctrlSignals_T_57 | (_ctrlSignals_T_59 | (_ctrlSignals_T_61 | (
    _ctrlSignals_T_63 | (_ctrlSignals_T_65 | (_ctrlSignals_T_67 | (_ctrlSignals_T_69 | (_ctrlSignals_T_71 | (
    _ctrlSignals_T_73 | _ctrlSignals_T_589)))))))))))))))))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_610 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_609; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_611 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_610; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_617 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_21 | (_ctrlSignals_T_23 | (_ctrlSignals_T_25 | (
    _ctrlSignals_T_27 | (_ctrlSignals_T_29 | _ctrlSignals_T_611)))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_618 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_617; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_619 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_618; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_620 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_619; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_621 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_620; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_622 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_621; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_627 = _ctrlSignals_T_95 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_628 = _ctrlSignals_T_93 ? 3'h4 : _ctrlSignals_T_627; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_629 = _ctrlSignals_T_91 ? 3'h4 : _ctrlSignals_T_628; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_630 = _ctrlSignals_T_89 ? 3'h3 : _ctrlSignals_T_629; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_631 = _ctrlSignals_T_87 ? 3'h2 : _ctrlSignals_T_630; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_632 = _ctrlSignals_T_85 ? 3'h1 : _ctrlSignals_T_631; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_633 = _ctrlSignals_T_83 ? 3'h3 : _ctrlSignals_T_632; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_634 = _ctrlSignals_T_81 ? 3'h2 : _ctrlSignals_T_633; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_635 = _ctrlSignals_T_79 ? 3'h1 : _ctrlSignals_T_634; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_636 = _ctrlSignals_T_77 ? 3'h0 : _ctrlSignals_T_635; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_637 = _ctrlSignals_T_75 ? 3'h0 : _ctrlSignals_T_636; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_638 = _ctrlSignals_T_73 ? 3'h0 : _ctrlSignals_T_637; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_639 = _ctrlSignals_T_71 ? 3'h0 : _ctrlSignals_T_638; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_640 = _ctrlSignals_T_69 ? 3'h0 : _ctrlSignals_T_639; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_641 = _ctrlSignals_T_67 ? 3'h0 : _ctrlSignals_T_640; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_642 = _ctrlSignals_T_65 ? 3'h0 : _ctrlSignals_T_641; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_643 = _ctrlSignals_T_63 ? 3'h0 : _ctrlSignals_T_642; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_644 = _ctrlSignals_T_61 ? 3'h0 : _ctrlSignals_T_643; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_645 = _ctrlSignals_T_59 ? 3'h0 : _ctrlSignals_T_644; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_646 = _ctrlSignals_T_57 ? 3'h0 : _ctrlSignals_T_645; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_647 = _ctrlSignals_T_55 ? 3'h0 : _ctrlSignals_T_646; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_648 = _ctrlSignals_T_53 ? 3'h0 : _ctrlSignals_T_647; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_649 = _ctrlSignals_T_51 ? 3'h0 : _ctrlSignals_T_648; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_650 = _ctrlSignals_T_49 ? 3'h0 : _ctrlSignals_T_649; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_651 = _ctrlSignals_T_47 ? 3'h0 : _ctrlSignals_T_650; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_652 = _ctrlSignals_T_45 ? 3'h0 : _ctrlSignals_T_651; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_653 = _ctrlSignals_T_43 ? 3'h0 : _ctrlSignals_T_652; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_654 = _ctrlSignals_T_41 ? 3'h0 : _ctrlSignals_T_653; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_655 = _ctrlSignals_T_39 ? 3'h0 : _ctrlSignals_T_654; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_656 = _ctrlSignals_T_37 ? 3'h0 : _ctrlSignals_T_655; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_657 = _ctrlSignals_T_35 ? 3'h0 : _ctrlSignals_T_656; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_658 = _ctrlSignals_T_33 ? 3'h0 : _ctrlSignals_T_657; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_659 = _ctrlSignals_T_31 ? 3'h0 : _ctrlSignals_T_658; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_660 = _ctrlSignals_T_29 ? 3'h0 : _ctrlSignals_T_659; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_661 = _ctrlSignals_T_27 ? 3'h0 : _ctrlSignals_T_660; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_662 = _ctrlSignals_T_25 ? 3'h0 : _ctrlSignals_T_661; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_663 = _ctrlSignals_T_23 ? 3'h0 : _ctrlSignals_T_662; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_664 = _ctrlSignals_T_21 ? 3'h0 : _ctrlSignals_T_663; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_665 = _ctrlSignals_T_19 ? 3'h0 : _ctrlSignals_T_664; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_666 = _ctrlSignals_T_17 ? 3'h0 : _ctrlSignals_T_665; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_667 = _ctrlSignals_T_15 ? 3'h0 : _ctrlSignals_T_666; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_668 = _ctrlSignals_T_13 ? 3'h0 : _ctrlSignals_T_667; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_669 = _ctrlSignals_T_11 ? 3'h0 : _ctrlSignals_T_668; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_670 = _ctrlSignals_T_9 ? 3'h0 : _ctrlSignals_T_669; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_671 = _ctrlSignals_T_7 ? 3'h0 : _ctrlSignals_T_670; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_672 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_671; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_673 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_672; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_674 = _ctrlSignals_T_97 ? 1'h0 : 1'h1; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_675 = _ctrlSignals_T_95 ? 1'h0 : _ctrlSignals_T_674; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_676 = _ctrlSignals_T_93 ? 1'h0 : _ctrlSignals_T_675; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_677 = _ctrlSignals_T_91 ? 1'h0 : _ctrlSignals_T_676; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_678 = _ctrlSignals_T_89 ? 1'h0 : _ctrlSignals_T_677; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_679 = _ctrlSignals_T_87 ? 1'h0 : _ctrlSignals_T_678; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_680 = _ctrlSignals_T_85 ? 1'h0 : _ctrlSignals_T_679; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_681 = _ctrlSignals_T_83 ? 1'h0 : _ctrlSignals_T_680; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_682 = _ctrlSignals_T_81 ? 1'h0 : _ctrlSignals_T_681; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_683 = _ctrlSignals_T_79 ? 1'h0 : _ctrlSignals_T_682; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_684 = _ctrlSignals_T_77 ? 1'h0 : _ctrlSignals_T_683; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_685 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_684; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_686 = _ctrlSignals_T_73 ? 1'h0 : _ctrlSignals_T_685; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_687 = _ctrlSignals_T_71 ? 1'h0 : _ctrlSignals_T_686; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_688 = _ctrlSignals_T_69 ? 1'h0 : _ctrlSignals_T_687; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_689 = _ctrlSignals_T_67 ? 1'h0 : _ctrlSignals_T_688; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_690 = _ctrlSignals_T_65 ? 1'h0 : _ctrlSignals_T_689; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_691 = _ctrlSignals_T_63 ? 1'h0 : _ctrlSignals_T_690; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_692 = _ctrlSignals_T_61 ? 1'h0 : _ctrlSignals_T_691; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_693 = _ctrlSignals_T_59 ? 1'h0 : _ctrlSignals_T_692; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_694 = _ctrlSignals_T_57 ? 1'h0 : _ctrlSignals_T_693; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_695 = _ctrlSignals_T_55 ? 1'h0 : _ctrlSignals_T_694; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_696 = _ctrlSignals_T_53 ? 1'h0 : _ctrlSignals_T_695; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_697 = _ctrlSignals_T_51 ? 1'h0 : _ctrlSignals_T_696; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_698 = _ctrlSignals_T_49 ? 1'h0 : _ctrlSignals_T_697; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_699 = _ctrlSignals_T_47 ? 1'h0 : _ctrlSignals_T_698; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_700 = _ctrlSignals_T_45 ? 1'h0 : _ctrlSignals_T_699; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_701 = _ctrlSignals_T_43 ? 1'h0 : _ctrlSignals_T_700; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_702 = _ctrlSignals_T_41 ? 1'h0 : _ctrlSignals_T_701; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_703 = _ctrlSignals_T_39 ? 1'h0 : _ctrlSignals_T_702; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_704 = _ctrlSignals_T_37 ? 1'h0 : _ctrlSignals_T_703; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_705 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_704; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_706 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_705; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_707 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_706; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_708 = _ctrlSignals_T_29 ? 1'h0 : _ctrlSignals_T_707; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_709 = _ctrlSignals_T_27 ? 1'h0 : _ctrlSignals_T_708; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_710 = _ctrlSignals_T_25 ? 1'h0 : _ctrlSignals_T_709; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_711 = _ctrlSignals_T_23 ? 1'h0 : _ctrlSignals_T_710; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_712 = _ctrlSignals_T_21 ? 1'h0 : _ctrlSignals_T_711; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_713 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_712; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_714 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_713; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_715 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_714; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_716 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_715; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_717 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_716; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_718 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_717; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_719 = _ctrlSignals_T_7 ? 1'h0 : _ctrlSignals_T_718; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_720 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_719; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_721 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_720; // @[Lookup.scala 34:39]
  assign io_pc_sel = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_145; // @[Lookup.scala 34:39]
  assign io_inst_kill = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_433; // @[Lookup.scala 34:39]
  assign io_A_sel = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_193; // @[Lookup.scala 34:39]
  assign io_B_sel = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_241; // @[Lookup.scala 34:39]
  assign io_imm_sel = _ctrlSignals_T_1 ? 3'h3 : _ctrlSignals_T_289; // @[Lookup.scala 34:39]
  assign io_alu_op = _ctrlSignals_T_1 ? 4'hb : _ctrlSignals_T_337; // @[Lookup.scala 34:39]
  assign io_br_type = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_385; // @[Lookup.scala 34:39]
  assign io_st_type = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_481; // @[Lookup.scala 34:39]
  assign io_ld_type = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_529; // @[Lookup.scala 34:39]
  assign io_wb_sel = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_577; // @[Lookup.scala 34:39]
  assign io_wb_en = _ctrlSignals_T_1 | (_ctrlSignals_T_3 | (_ctrlSignals_T_5 | (_ctrlSignals_T_7 | _ctrlSignals_T_622)))
    ; // @[Lookup.scala 34:39]
  assign io_csr_cmd = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_673; // @[Lookup.scala 34:39]
  assign io_illegal = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_721; // @[Lookup.scala 34:39]
endmodule
module Core(
  input         clock,
  input         reset,
  output        io_icache_req_valid,
  output [31:0] io_icache_req_bits_addr,
  input         io_icache_resp_valid,
  input  [31:0] io_icache_resp_bits_data,
  output        io_dcache_abort,
  output        io_dcache_req_valid,
  output [31:0] io_dcache_req_bits_addr,
  output [31:0] io_dcache_req_bits_data,
  output [3:0]  io_dcache_req_bits_mask,
  input         io_dcache_resp_valid,
  input  [31:0] io_dcache_resp_bits_data
);
  wire  dpath_clock; // @[Core.scala 27:21]
  wire  dpath_reset; // @[Core.scala 27:21]
  wire  dpath_io_icache_req_valid; // @[Core.scala 27:21]
  wire [31:0] dpath_io_icache_req_bits_addr; // @[Core.scala 27:21]
  wire  dpath_io_icache_resp_valid; // @[Core.scala 27:21]
  wire [31:0] dpath_io_icache_resp_bits_data; // @[Core.scala 27:21]
  wire  dpath_io_dcache_abort; // @[Core.scala 27:21]
  wire  dpath_io_dcache_req_valid; // @[Core.scala 27:21]
  wire [31:0] dpath_io_dcache_req_bits_addr; // @[Core.scala 27:21]
  wire [31:0] dpath_io_dcache_req_bits_data; // @[Core.scala 27:21]
  wire [3:0] dpath_io_dcache_req_bits_mask; // @[Core.scala 27:21]
  wire  dpath_io_dcache_resp_valid; // @[Core.scala 27:21]
  wire [31:0] dpath_io_dcache_resp_bits_data; // @[Core.scala 27:21]
  wire [31:0] dpath_io_ctrl_inst; // @[Core.scala 27:21]
  wire [1:0] dpath_io_ctrl_pc_sel; // @[Core.scala 27:21]
  wire  dpath_io_ctrl_inst_kill; // @[Core.scala 27:21]
  wire  dpath_io_ctrl_A_sel; // @[Core.scala 27:21]
  wire  dpath_io_ctrl_B_sel; // @[Core.scala 27:21]
  wire [2:0] dpath_io_ctrl_imm_sel; // @[Core.scala 27:21]
  wire [3:0] dpath_io_ctrl_alu_op; // @[Core.scala 27:21]
  wire [2:0] dpath_io_ctrl_br_type; // @[Core.scala 27:21]
  wire [1:0] dpath_io_ctrl_st_type; // @[Core.scala 27:21]
  wire [2:0] dpath_io_ctrl_ld_type; // @[Core.scala 27:21]
  wire [1:0] dpath_io_ctrl_wb_sel; // @[Core.scala 27:21]
  wire  dpath_io_ctrl_wb_en; // @[Core.scala 27:21]
  wire [2:0] dpath_io_ctrl_csr_cmd; // @[Core.scala 27:21]
  wire  dpath_io_ctrl_illegal; // @[Core.scala 27:21]
  wire [31:0] ctrl_io_inst; // @[Core.scala 28:20]
  wire [1:0] ctrl_io_pc_sel; // @[Core.scala 28:20]
  wire  ctrl_io_inst_kill; // @[Core.scala 28:20]
  wire  ctrl_io_A_sel; // @[Core.scala 28:20]
  wire  ctrl_io_B_sel; // @[Core.scala 28:20]
  wire [2:0] ctrl_io_imm_sel; // @[Core.scala 28:20]
  wire [3:0] ctrl_io_alu_op; // @[Core.scala 28:20]
  wire [2:0] ctrl_io_br_type; // @[Core.scala 28:20]
  wire [1:0] ctrl_io_st_type; // @[Core.scala 28:20]
  wire [2:0] ctrl_io_ld_type; // @[Core.scala 28:20]
  wire [1:0] ctrl_io_wb_sel; // @[Core.scala 28:20]
  wire  ctrl_io_wb_en; // @[Core.scala 28:20]
  wire [2:0] ctrl_io_csr_cmd; // @[Core.scala 28:20]
  wire  ctrl_io_illegal; // @[Core.scala 28:20]
  Datapath dpath ( // @[Core.scala 27:21]
    .clock(dpath_clock),
    .reset(dpath_reset),
    .io_icache_req_valid(dpath_io_icache_req_valid),
    .io_icache_req_bits_addr(dpath_io_icache_req_bits_addr),
    .io_icache_resp_valid(dpath_io_icache_resp_valid),
    .io_icache_resp_bits_data(dpath_io_icache_resp_bits_data),
    .io_dcache_abort(dpath_io_dcache_abort),
    .io_dcache_req_valid(dpath_io_dcache_req_valid),
    .io_dcache_req_bits_addr(dpath_io_dcache_req_bits_addr),
    .io_dcache_req_bits_data(dpath_io_dcache_req_bits_data),
    .io_dcache_req_bits_mask(dpath_io_dcache_req_bits_mask),
    .io_dcache_resp_valid(dpath_io_dcache_resp_valid),
    .io_dcache_resp_bits_data(dpath_io_dcache_resp_bits_data),
    .io_ctrl_inst(dpath_io_ctrl_inst),
    .io_ctrl_pc_sel(dpath_io_ctrl_pc_sel),
    .io_ctrl_inst_kill(dpath_io_ctrl_inst_kill),
    .io_ctrl_A_sel(dpath_io_ctrl_A_sel),
    .io_ctrl_B_sel(dpath_io_ctrl_B_sel),
    .io_ctrl_imm_sel(dpath_io_ctrl_imm_sel),
    .io_ctrl_alu_op(dpath_io_ctrl_alu_op),
    .io_ctrl_br_type(dpath_io_ctrl_br_type),
    .io_ctrl_st_type(dpath_io_ctrl_st_type),
    .io_ctrl_ld_type(dpath_io_ctrl_ld_type),
    .io_ctrl_wb_sel(dpath_io_ctrl_wb_sel),
    .io_ctrl_wb_en(dpath_io_ctrl_wb_en),
    .io_ctrl_csr_cmd(dpath_io_ctrl_csr_cmd),
    .io_ctrl_illegal(dpath_io_ctrl_illegal)
  );
  Control ctrl ( // @[Core.scala 28:20]
    .io_inst(ctrl_io_inst),
    .io_pc_sel(ctrl_io_pc_sel),
    .io_inst_kill(ctrl_io_inst_kill),
    .io_A_sel(ctrl_io_A_sel),
    .io_B_sel(ctrl_io_B_sel),
    .io_imm_sel(ctrl_io_imm_sel),
    .io_alu_op(ctrl_io_alu_op),
    .io_br_type(ctrl_io_br_type),
    .io_st_type(ctrl_io_st_type),
    .io_ld_type(ctrl_io_ld_type),
    .io_wb_sel(ctrl_io_wb_sel),
    .io_wb_en(ctrl_io_wb_en),
    .io_csr_cmd(ctrl_io_csr_cmd),
    .io_illegal(ctrl_io_illegal)
  );
  assign io_icache_req_valid = dpath_io_icache_req_valid; // @[Core.scala 31:19]
  assign io_icache_req_bits_addr = dpath_io_icache_req_bits_addr; // @[Core.scala 31:19]
  assign io_dcache_abort = dpath_io_dcache_abort; // @[Core.scala 32:19]
  assign io_dcache_req_valid = dpath_io_dcache_req_valid; // @[Core.scala 32:19]
  assign io_dcache_req_bits_addr = dpath_io_dcache_req_bits_addr; // @[Core.scala 32:19]
  assign io_dcache_req_bits_data = dpath_io_dcache_req_bits_data; // @[Core.scala 32:19]
  assign io_dcache_req_bits_mask = dpath_io_dcache_req_bits_mask; // @[Core.scala 32:19]
  assign dpath_clock = clock;
  assign dpath_reset = reset;
  assign dpath_io_icache_resp_valid = io_icache_resp_valid; // @[Core.scala 31:19]
  assign dpath_io_icache_resp_bits_data = io_icache_resp_bits_data; // @[Core.scala 31:19]
  assign dpath_io_dcache_resp_valid = io_dcache_resp_valid; // @[Core.scala 32:19]
  assign dpath_io_dcache_resp_bits_data = io_dcache_resp_bits_data; // @[Core.scala 32:19]
  assign dpath_io_ctrl_pc_sel = ctrl_io_pc_sel; // @[Core.scala 33:17]
  assign dpath_io_ctrl_inst_kill = ctrl_io_inst_kill; // @[Core.scala 33:17]
  assign dpath_io_ctrl_A_sel = ctrl_io_A_sel; // @[Core.scala 33:17]
  assign dpath_io_ctrl_B_sel = ctrl_io_B_sel; // @[Core.scala 33:17]
  assign dpath_io_ctrl_imm_sel = ctrl_io_imm_sel; // @[Core.scala 33:17]
  assign dpath_io_ctrl_alu_op = ctrl_io_alu_op; // @[Core.scala 33:17]
  assign dpath_io_ctrl_br_type = ctrl_io_br_type; // @[Core.scala 33:17]
  assign dpath_io_ctrl_st_type = ctrl_io_st_type; // @[Core.scala 33:17]
  assign dpath_io_ctrl_ld_type = ctrl_io_ld_type; // @[Core.scala 33:17]
  assign dpath_io_ctrl_wb_sel = ctrl_io_wb_sel; // @[Core.scala 33:17]
  assign dpath_io_ctrl_wb_en = ctrl_io_wb_en; // @[Core.scala 33:17]
  assign dpath_io_ctrl_csr_cmd = ctrl_io_csr_cmd; // @[Core.scala 33:17]
  assign dpath_io_ctrl_illegal = ctrl_io_illegal; // @[Core.scala 33:17]
  assign ctrl_io_inst = dpath_io_ctrl_inst; // @[Core.scala 33:17]
endmodule
module Cache(
  input         clock,
  input         reset,
  input         io_cpu_abort,
  input         io_cpu_req_valid,
  input  [31:0] io_cpu_req_bits_addr,
  input  [31:0] io_cpu_req_bits_data,
  input  [3:0]  io_cpu_req_bits_mask,
  output        io_cpu_resp_valid,
  output [31:0] io_cpu_resp_bits_data,
  input         io_nasti_aw_ready,
  output        io_nasti_aw_valid,
  output [31:0] io_nasti_aw_bits_addr,
  input         io_nasti_w_ready,
  output        io_nasti_w_valid,
  output [63:0] io_nasti_w_bits_data,
  output        io_nasti_w_bits_last,
  output        io_nasti_b_ready,
  input         io_nasti_b_valid,
  input         io_nasti_ar_ready,
  output        io_nasti_ar_valid,
  output [31:0] io_nasti_ar_bits_addr,
  output        io_nasti_r_ready,
  input         io_nasti_r_valid,
  input  [63:0] io_nasti_r_bits_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_24;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [255:0] _RAND_28;
  reg [255:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [63:0] _RAND_35;
  reg [63:0] _RAND_36;
`endif // RANDOMIZE_REG_INIT
  reg [20:0] metaMem_tag [0:255]; // @[Cache.scala 64:28]
  wire  metaMem_tag_rmeta_en; // @[Cache.scala 64:28]
  wire [7:0] metaMem_tag_rmeta_addr; // @[Cache.scala 64:28]
  wire [20:0] metaMem_tag_rmeta_data; // @[Cache.scala 64:28]
  wire [20:0] metaMem_tag_MPORT_data; // @[Cache.scala 64:28]
  wire [7:0] metaMem_tag_MPORT_addr; // @[Cache.scala 64:28]
  wire  metaMem_tag_MPORT_mask; // @[Cache.scala 64:28]
  wire  metaMem_tag_MPORT_en; // @[Cache.scala 64:28]
  reg  metaMem_tag_rmeta_en_pipe_0;
  reg [7:0] metaMem_tag_rmeta_addr_pipe_0;
  reg [7:0] dataMem_0_0 [0:255]; // @[Cache.scala 65:45]
  wire  dataMem_0_0_rdata_MPORT_en; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_0_rdata_MPORT_addr; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_0_rdata_MPORT_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_0_MPORT_1_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_0_MPORT_1_addr; // @[Cache.scala 65:45]
  wire  dataMem_0_0_MPORT_1_mask; // @[Cache.scala 65:45]
  wire  dataMem_0_0_MPORT_1_en; // @[Cache.scala 65:45]
  reg  dataMem_0_0_rdata_MPORT_en_pipe_0;
  reg [7:0] dataMem_0_0_rdata_MPORT_addr_pipe_0;
  reg [7:0] dataMem_0_1 [0:255]; // @[Cache.scala 65:45]
  wire  dataMem_0_1_rdata_MPORT_en; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_1_rdata_MPORT_addr; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_1_rdata_MPORT_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_1_MPORT_1_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_1_MPORT_1_addr; // @[Cache.scala 65:45]
  wire  dataMem_0_1_MPORT_1_mask; // @[Cache.scala 65:45]
  wire  dataMem_0_1_MPORT_1_en; // @[Cache.scala 65:45]
  reg  dataMem_0_1_rdata_MPORT_en_pipe_0;
  reg [7:0] dataMem_0_1_rdata_MPORT_addr_pipe_0;
  reg [7:0] dataMem_0_2 [0:255]; // @[Cache.scala 65:45]
  wire  dataMem_0_2_rdata_MPORT_en; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_2_rdata_MPORT_addr; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_2_rdata_MPORT_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_2_MPORT_1_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_2_MPORT_1_addr; // @[Cache.scala 65:45]
  wire  dataMem_0_2_MPORT_1_mask; // @[Cache.scala 65:45]
  wire  dataMem_0_2_MPORT_1_en; // @[Cache.scala 65:45]
  reg  dataMem_0_2_rdata_MPORT_en_pipe_0;
  reg [7:0] dataMem_0_2_rdata_MPORT_addr_pipe_0;
  reg [7:0] dataMem_0_3 [0:255]; // @[Cache.scala 65:45]
  wire  dataMem_0_3_rdata_MPORT_en; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_3_rdata_MPORT_addr; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_3_rdata_MPORT_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_3_MPORT_1_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_0_3_MPORT_1_addr; // @[Cache.scala 65:45]
  wire  dataMem_0_3_MPORT_1_mask; // @[Cache.scala 65:45]
  wire  dataMem_0_3_MPORT_1_en; // @[Cache.scala 65:45]
  reg  dataMem_0_3_rdata_MPORT_en_pipe_0;
  reg [7:0] dataMem_0_3_rdata_MPORT_addr_pipe_0;
  reg [7:0] dataMem_1_0 [0:255]; // @[Cache.scala 65:45]
  wire  dataMem_1_0_rdata_MPORT_1_en; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_0_rdata_MPORT_1_addr; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_0_rdata_MPORT_1_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_0_MPORT_2_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_0_MPORT_2_addr; // @[Cache.scala 65:45]
  wire  dataMem_1_0_MPORT_2_mask; // @[Cache.scala 65:45]
  wire  dataMem_1_0_MPORT_2_en; // @[Cache.scala 65:45]
  reg  dataMem_1_0_rdata_MPORT_1_en_pipe_0;
  reg [7:0] dataMem_1_0_rdata_MPORT_1_addr_pipe_0;
  reg [7:0] dataMem_1_1 [0:255]; // @[Cache.scala 65:45]
  wire  dataMem_1_1_rdata_MPORT_1_en; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_1_rdata_MPORT_1_addr; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_1_rdata_MPORT_1_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_1_MPORT_2_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_1_MPORT_2_addr; // @[Cache.scala 65:45]
  wire  dataMem_1_1_MPORT_2_mask; // @[Cache.scala 65:45]
  wire  dataMem_1_1_MPORT_2_en; // @[Cache.scala 65:45]
  reg  dataMem_1_1_rdata_MPORT_1_en_pipe_0;
  reg [7:0] dataMem_1_1_rdata_MPORT_1_addr_pipe_0;
  reg [7:0] dataMem_1_2 [0:255]; // @[Cache.scala 65:45]
  wire  dataMem_1_2_rdata_MPORT_1_en; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_2_rdata_MPORT_1_addr; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_2_rdata_MPORT_1_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_2_MPORT_2_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_2_MPORT_2_addr; // @[Cache.scala 65:45]
  wire  dataMem_1_2_MPORT_2_mask; // @[Cache.scala 65:45]
  wire  dataMem_1_2_MPORT_2_en; // @[Cache.scala 65:45]
  reg  dataMem_1_2_rdata_MPORT_1_en_pipe_0;
  reg [7:0] dataMem_1_2_rdata_MPORT_1_addr_pipe_0;
  reg [7:0] dataMem_1_3 [0:255]; // @[Cache.scala 65:45]
  wire  dataMem_1_3_rdata_MPORT_1_en; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_3_rdata_MPORT_1_addr; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_3_rdata_MPORT_1_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_3_MPORT_2_data; // @[Cache.scala 65:45]
  wire [7:0] dataMem_1_3_MPORT_2_addr; // @[Cache.scala 65:45]
  wire  dataMem_1_3_MPORT_2_mask; // @[Cache.scala 65:45]
  wire  dataMem_1_3_MPORT_2_en; // @[Cache.scala 65:45]
  reg  dataMem_1_3_rdata_MPORT_1_en_pipe_0;
  reg [7:0] dataMem_1_3_rdata_MPORT_1_addr_pipe_0;
  reg [2:0] state; // @[Cache.scala 60:22]
  reg [255:0] v; // @[Cache.scala 62:18]
  reg [255:0] d; // @[Cache.scala 63:18]
  reg [31:0] addr_reg; // @[Cache.scala 67:21]
  reg [31:0] cpu_data; // @[Cache.scala 68:21]
  reg [3:0] cpu_mask; // @[Cache.scala 69:21]
  wire  read_wrap_out = io_nasti_r_ready & io_nasti_r_valid; // @[Decoupled.scala 50:35]
  wire  write_wrap_out = io_nasti_w_ready & io_nasti_w_valid; // @[Decoupled.scala 50:35]
  wire  is_idle = state == 3'h0; // @[Cache.scala 76:23]
  wire  is_read = state == 3'h1; // @[Cache.scala 77:23]
  wire  is_write = state == 3'h2; // @[Cache.scala 78:24]
  wire  is_alloc = state == 3'h6 & read_wrap_out; // @[Cache.scala 79:36]
  reg  is_alloc_reg; // @[Cache.scala 80:29]
  wire [7:0] idx_reg = addr_reg[10:3]; // @[Cache.scala 90:25]
  wire [255:0] _hit_T = v >> idx_reg; // @[Cache.scala 99:11]
  wire [20:0] tag_reg = addr_reg[31:11]; // @[Cache.scala 89:25]
  wire  hit = _hit_T[0] & metaMem_tag_rmeta_data == tag_reg; // @[Cache.scala 99:21]
  wire  _wen_T = hit | is_alloc_reg; // @[Cache.scala 83:30]
  wire  _wen_T_3 = is_write & (hit | is_alloc_reg) & ~io_cpu_abort; // @[Cache.scala 83:47]
  wire  wen = is_write & (hit | is_alloc_reg) & ~io_cpu_abort | is_alloc; // @[Cache.scala 83:64]
  wire  _ren_T_2 = ~wen & (is_idle | is_read); // @[Cache.scala 84:18]
  reg  ren_reg; // @[Cache.scala 85:24]
  wire  off_reg = addr_reg[2]; // @[Cache.scala 91:25]
  wire [63:0] rdata = {dataMem_1_3_rdata_MPORT_1_data,dataMem_1_2_rdata_MPORT_1_data,dataMem_1_1_rdata_MPORT_1_data,
    dataMem_1_0_rdata_MPORT_1_data,dataMem_0_3_rdata_MPORT_data,dataMem_0_2_rdata_MPORT_data,
    dataMem_0_1_rdata_MPORT_data,dataMem_0_0_rdata_MPORT_data}; // @[Cat.scala 31:58]
  reg [63:0] rdata_buf; // @[Reg.scala 16:16]
  wire [63:0] _GEN_8 = ren_reg ? rdata : rdata_buf; // @[Reg.scala 16:16 17:{18,22}]
  reg [63:0] refill_buf_0; // @[Cache.scala 96:23]
  wire [63:0] read = is_alloc_reg ? refill_buf_0 : _GEN_8; // @[Cache.scala 97:17]
  wire  _io_cpu_resp_valid_T_2 = |cpu_mask; // @[Cache.scala 103:79]
  wire  _wmask_T = ~is_alloc; // @[Cache.scala 114:19]
  wire [2:0] _wmask_T_1 = {off_reg,2'h0}; // @[Cat.scala 31:58]
  wire [10:0] _GEN_0 = {{7'd0}, cpu_mask}; // @[Cache.scala 114:40]
  wire [10:0] _wmask_T_2 = _GEN_0 << _wmask_T_1; // @[Cache.scala 114:40]
  wire [11:0] _wmask_T_3 = {1'b0,$signed(_wmask_T_2)}; // @[Cache.scala 114:80]
  wire [11:0] wmask = ~is_alloc ? $signed(_wmask_T_3) : $signed(-12'sh1); // @[Cache.scala 114:18]
  wire [63:0] _wdata_T_1 = {cpu_data,cpu_data}; // @[Cat.scala 31:58]
  wire [63:0] wdata = _wmask_T ? _wdata_T_1 : io_nasti_r_bits_data; // @[Cache.scala 115:18]
  wire [255:0] _v_T = 256'h1 << idx_reg; // @[Cache.scala 122:18]
  wire [255:0] _v_T_1 = v | _v_T; // @[Cache.scala 122:18]
  wire [255:0] _d_T_2 = d | _v_T; // @[Cache.scala 123:18]
  wire [255:0] _d_T_3 = ~d; // @[Cache.scala 123:18]
  wire [255:0] _d_T_4 = _d_T_3 | _v_T; // @[Cache.scala 123:18]
  wire [255:0] _d_T_5 = ~_d_T_4; // @[Cache.scala 123:18]
  wire [28:0] _io_nasti_ar_bits_T = {tag_reg,idx_reg}; // @[Cat.scala 31:58]
  wire [28:0] _io_nasti_aw_bits_T = {metaMem_tag_rmeta_data,idx_reg}; // @[Cat.scala 31:58]
  wire [255:0] _is_dirty_T_2 = d >> idx_reg; // @[Cache.scala 167:33]
  wire  is_dirty = _hit_T[0] & _is_dirty_T_2[0]; // @[Cache.scala 167:29]
  wire [1:0] _state_T_1 = |io_cpu_req_bits_mask ? 2'h2 : 2'h1; // @[Cache.scala 171:21]
  wire [1:0] _GEN_63 = io_cpu_req_valid ? _state_T_1 : 2'h0; // @[Cache.scala 176:32 177:17 179:17]
  wire  _io_nasti_ar_valid_T = ~is_dirty; // @[Cache.scala 183:30]
  wire  _T_19 = io_nasti_aw_ready & io_nasti_aw_valid; // @[Decoupled.scala 50:35]
  wire  _T_20 = io_nasti_ar_ready & io_nasti_ar_valid; // @[Decoupled.scala 50:35]
  wire [2:0] _GEN_64 = _T_20 ? 3'h6 : state; // @[Cache.scala 186:38 187:17 60:22]
  wire [2:0] _GEN_65 = _T_19 ? 3'h3 : _GEN_64; // @[Cache.scala 184:32 185:17]
  wire  _GEN_67 = hit ? 1'h0 : is_dirty; // @[Cache.scala 175:17 155:21 182:27]
  wire  _GEN_68 = hit ? 1'h0 : ~is_dirty; // @[Cache.scala 175:17 141:21 183:27]
  wire [2:0] _GEN_71 = _wen_T | io_cpu_abort ? 3'h0 : _GEN_65; // @[Cache.scala 192:49 193:15]
  wire  _GEN_72 = _wen_T | io_cpu_abort ? 1'h0 : is_dirty; // @[Cache.scala 155:21 192:49 195:27]
  wire  _GEN_73 = _wen_T | io_cpu_abort ? 1'h0 : _io_nasti_ar_valid_T; // @[Cache.scala 141:21 192:49 196:27]
  wire [2:0] _GEN_74 = write_wrap_out ? 3'h4 : state; // @[Cache.scala 206:28 207:15 60:22]
  wire  _T_34 = io_nasti_b_ready & io_nasti_b_valid; // @[Decoupled.scala 50:35]
  wire [2:0] _GEN_75 = _T_34 ? 3'h5 : state; // @[Cache.scala 212:29 213:15 60:22]
  wire [1:0] _state_T_5 = _io_cpu_resp_valid_T_2 ? 2'h2 : 2'h0; // @[Cache.scala 224:21]
  wire [2:0] _GEN_77 = read_wrap_out ? {{1'd0}, _state_T_5} : state; // @[Cache.scala 223:27 224:15 60:22]
  wire [2:0] _GEN_78 = 3'h6 == state ? _GEN_77 : state; // @[Cache.scala 168:17 60:22]
  wire [2:0] _GEN_80 = 3'h5 == state ? _GEN_64 : _GEN_78; // @[Cache.scala 168:17]
  wire [2:0] _GEN_82 = 3'h4 == state ? _GEN_75 : _GEN_80; // @[Cache.scala 168:17]
  wire  _GEN_83 = 3'h4 == state ? 1'h0 : 3'h5 == state; // @[Cache.scala 168:17 141:21]
  wire [2:0] _GEN_85 = 3'h3 == state ? _GEN_74 : _GEN_82; // @[Cache.scala 168:17]
  wire  _GEN_86 = 3'h3 == state ? 1'h0 : 3'h4 == state; // @[Cache.scala 168:17 164:20]
  wire  _GEN_87 = 3'h3 == state ? 1'h0 : _GEN_83; // @[Cache.scala 168:17 141:21]
  wire  _GEN_89 = 3'h2 == state & _GEN_72; // @[Cache.scala 168:17 155:21]
  wire  _GEN_90 = 3'h2 == state ? _GEN_73 : _GEN_87; // @[Cache.scala 168:17]
  wire  _GEN_91 = 3'h2 == state ? 1'h0 : 3'h3 == state; // @[Cache.scala 168:17 162:20]
  wire  _GEN_92 = 3'h2 == state ? 1'h0 : _GEN_86; // @[Cache.scala 168:17 164:20]
  wire  _GEN_94 = 3'h1 == state ? _GEN_67 : _GEN_89; // @[Cache.scala 168:17]
  wire  _GEN_95 = 3'h1 == state ? _GEN_68 : _GEN_90; // @[Cache.scala 168:17]
  wire  _GEN_96 = 3'h1 == state ? 1'h0 : _GEN_91; // @[Cache.scala 168:17 162:20]
  wire  _GEN_97 = 3'h1 == state ? 1'h0 : _GEN_92; // @[Cache.scala 168:17 164:20]
  assign metaMem_tag_rmeta_en = metaMem_tag_rmeta_en_pipe_0;
  assign metaMem_tag_rmeta_addr = metaMem_tag_rmeta_addr_pipe_0;
  assign metaMem_tag_rmeta_data = metaMem_tag[metaMem_tag_rmeta_addr]; // @[Cache.scala 64:28]
  assign metaMem_tag_MPORT_data = addr_reg[31:11];
  assign metaMem_tag_MPORT_addr = addr_reg[10:3];
  assign metaMem_tag_MPORT_mask = 1'h1;
  assign metaMem_tag_MPORT_en = wen & is_alloc;
  assign dataMem_0_0_rdata_MPORT_en = dataMem_0_0_rdata_MPORT_en_pipe_0;
  assign dataMem_0_0_rdata_MPORT_addr = dataMem_0_0_rdata_MPORT_addr_pipe_0;
  assign dataMem_0_0_rdata_MPORT_data = dataMem_0_0[dataMem_0_0_rdata_MPORT_addr]; // @[Cache.scala 65:45]
  assign dataMem_0_0_MPORT_1_data = wdata[7:0];
  assign dataMem_0_0_MPORT_1_addr = addr_reg[10:3];
  assign dataMem_0_0_MPORT_1_mask = wmask[0];
  assign dataMem_0_0_MPORT_1_en = _wen_T_3 | is_alloc;
  assign dataMem_0_1_rdata_MPORT_en = dataMem_0_1_rdata_MPORT_en_pipe_0;
  assign dataMem_0_1_rdata_MPORT_addr = dataMem_0_1_rdata_MPORT_addr_pipe_0;
  assign dataMem_0_1_rdata_MPORT_data = dataMem_0_1[dataMem_0_1_rdata_MPORT_addr]; // @[Cache.scala 65:45]
  assign dataMem_0_1_MPORT_1_data = wdata[15:8];
  assign dataMem_0_1_MPORT_1_addr = addr_reg[10:3];
  assign dataMem_0_1_MPORT_1_mask = wmask[1];
  assign dataMem_0_1_MPORT_1_en = _wen_T_3 | is_alloc;
  assign dataMem_0_2_rdata_MPORT_en = dataMem_0_2_rdata_MPORT_en_pipe_0;
  assign dataMem_0_2_rdata_MPORT_addr = dataMem_0_2_rdata_MPORT_addr_pipe_0;
  assign dataMem_0_2_rdata_MPORT_data = dataMem_0_2[dataMem_0_2_rdata_MPORT_addr]; // @[Cache.scala 65:45]
  assign dataMem_0_2_MPORT_1_data = wdata[23:16];
  assign dataMem_0_2_MPORT_1_addr = addr_reg[10:3];
  assign dataMem_0_2_MPORT_1_mask = wmask[2];
  assign dataMem_0_2_MPORT_1_en = _wen_T_3 | is_alloc;
  assign dataMem_0_3_rdata_MPORT_en = dataMem_0_3_rdata_MPORT_en_pipe_0;
  assign dataMem_0_3_rdata_MPORT_addr = dataMem_0_3_rdata_MPORT_addr_pipe_0;
  assign dataMem_0_3_rdata_MPORT_data = dataMem_0_3[dataMem_0_3_rdata_MPORT_addr]; // @[Cache.scala 65:45]
  assign dataMem_0_3_MPORT_1_data = wdata[31:24];
  assign dataMem_0_3_MPORT_1_addr = addr_reg[10:3];
  assign dataMem_0_3_MPORT_1_mask = wmask[3];
  assign dataMem_0_3_MPORT_1_en = _wen_T_3 | is_alloc;
  assign dataMem_1_0_rdata_MPORT_1_en = dataMem_1_0_rdata_MPORT_1_en_pipe_0;
  assign dataMem_1_0_rdata_MPORT_1_addr = dataMem_1_0_rdata_MPORT_1_addr_pipe_0;
  assign dataMem_1_0_rdata_MPORT_1_data = dataMem_1_0[dataMem_1_0_rdata_MPORT_1_addr]; // @[Cache.scala 65:45]
  assign dataMem_1_0_MPORT_2_data = wdata[39:32];
  assign dataMem_1_0_MPORT_2_addr = addr_reg[10:3];
  assign dataMem_1_0_MPORT_2_mask = wmask[4];
  assign dataMem_1_0_MPORT_2_en = _wen_T_3 | is_alloc;
  assign dataMem_1_1_rdata_MPORT_1_en = dataMem_1_1_rdata_MPORT_1_en_pipe_0;
  assign dataMem_1_1_rdata_MPORT_1_addr = dataMem_1_1_rdata_MPORT_1_addr_pipe_0;
  assign dataMem_1_1_rdata_MPORT_1_data = dataMem_1_1[dataMem_1_1_rdata_MPORT_1_addr]; // @[Cache.scala 65:45]
  assign dataMem_1_1_MPORT_2_data = wdata[47:40];
  assign dataMem_1_1_MPORT_2_addr = addr_reg[10:3];
  assign dataMem_1_1_MPORT_2_mask = wmask[5];
  assign dataMem_1_1_MPORT_2_en = _wen_T_3 | is_alloc;
  assign dataMem_1_2_rdata_MPORT_1_en = dataMem_1_2_rdata_MPORT_1_en_pipe_0;
  assign dataMem_1_2_rdata_MPORT_1_addr = dataMem_1_2_rdata_MPORT_1_addr_pipe_0;
  assign dataMem_1_2_rdata_MPORT_1_data = dataMem_1_2[dataMem_1_2_rdata_MPORT_1_addr]; // @[Cache.scala 65:45]
  assign dataMem_1_2_MPORT_2_data = wdata[55:48];
  assign dataMem_1_2_MPORT_2_addr = addr_reg[10:3];
  assign dataMem_1_2_MPORT_2_mask = wmask[6];
  assign dataMem_1_2_MPORT_2_en = _wen_T_3 | is_alloc;
  assign dataMem_1_3_rdata_MPORT_1_en = dataMem_1_3_rdata_MPORT_1_en_pipe_0;
  assign dataMem_1_3_rdata_MPORT_1_addr = dataMem_1_3_rdata_MPORT_1_addr_pipe_0;
  assign dataMem_1_3_rdata_MPORT_1_data = dataMem_1_3[dataMem_1_3_rdata_MPORT_1_addr]; // @[Cache.scala 65:45]
  assign dataMem_1_3_MPORT_2_data = wdata[63:56];
  assign dataMem_1_3_MPORT_2_addr = addr_reg[10:3];
  assign dataMem_1_3_MPORT_2_mask = wmask[7];
  assign dataMem_1_3_MPORT_2_en = _wen_T_3 | is_alloc;
  assign io_cpu_resp_valid = is_idle | is_read & hit | is_alloc_reg & ~(|cpu_mask); // @[Cache.scala 103:50]
  assign io_cpu_resp_bits_data = off_reg ? read[63:32] : read[31:0]; // @[Cache.scala 102:{25,25}]
  assign io_nasti_aw_valid = 3'h0 == state ? 1'h0 : _GEN_94; // @[Cache.scala 168:17 155:21]
  assign io_nasti_aw_bits_addr = {_io_nasti_aw_bits_T, 3'h0}; // @[Cache.scala 151:30]
  assign io_nasti_w_valid = 3'h0 == state ? 1'h0 : _GEN_96; // @[Cache.scala 168:17 162:20]
  assign io_nasti_w_bits_data = is_alloc_reg ? refill_buf_0 : _GEN_8; // @[Cache.scala 97:17]
  assign io_nasti_w_bits_last = io_nasti_w_ready & io_nasti_w_valid; // @[Decoupled.scala 50:35]
  assign io_nasti_b_ready = 3'h0 == state ? 1'h0 : _GEN_97; // @[Cache.scala 168:17 164:20]
  assign io_nasti_ar_valid = 3'h0 == state ? 1'h0 : _GEN_95; // @[Cache.scala 168:17 141:21]
  assign io_nasti_ar_bits_addr = {_io_nasti_ar_bits_T, 3'h0}; // @[Cache.scala 137:28]
  assign io_nasti_r_ready = state == 3'h6; // @[Cache.scala 143:29]
  always @(posedge clock) begin
    if (metaMem_tag_MPORT_en & metaMem_tag_MPORT_mask) begin
      metaMem_tag[metaMem_tag_MPORT_addr] <= metaMem_tag_MPORT_data; // @[Cache.scala 64:28]
    end
    metaMem_tag_rmeta_en_pipe_0 <= _ren_T_2 & io_cpu_req_valid;
    if (_ren_T_2 & io_cpu_req_valid) begin
      metaMem_tag_rmeta_addr_pipe_0 <= io_cpu_req_bits_addr[10:3];
    end
    if (dataMem_0_0_MPORT_1_en & dataMem_0_0_MPORT_1_mask) begin
      dataMem_0_0[dataMem_0_0_MPORT_1_addr] <= dataMem_0_0_MPORT_1_data; // @[Cache.scala 65:45]
    end
    dataMem_0_0_rdata_MPORT_en_pipe_0 <= _ren_T_2 & io_cpu_req_valid;
    if (_ren_T_2 & io_cpu_req_valid) begin
      dataMem_0_0_rdata_MPORT_addr_pipe_0 <= io_cpu_req_bits_addr[10:3];
    end
    if (dataMem_0_1_MPORT_1_en & dataMem_0_1_MPORT_1_mask) begin
      dataMem_0_1[dataMem_0_1_MPORT_1_addr] <= dataMem_0_1_MPORT_1_data; // @[Cache.scala 65:45]
    end
    dataMem_0_1_rdata_MPORT_en_pipe_0 <= _ren_T_2 & io_cpu_req_valid;
    if (_ren_T_2 & io_cpu_req_valid) begin
      dataMem_0_1_rdata_MPORT_addr_pipe_0 <= io_cpu_req_bits_addr[10:3];
    end
    if (dataMem_0_2_MPORT_1_en & dataMem_0_2_MPORT_1_mask) begin
      dataMem_0_2[dataMem_0_2_MPORT_1_addr] <= dataMem_0_2_MPORT_1_data; // @[Cache.scala 65:45]
    end
    dataMem_0_2_rdata_MPORT_en_pipe_0 <= _ren_T_2 & io_cpu_req_valid;
    if (_ren_T_2 & io_cpu_req_valid) begin
      dataMem_0_2_rdata_MPORT_addr_pipe_0 <= io_cpu_req_bits_addr[10:3];
    end
    if (dataMem_0_3_MPORT_1_en & dataMem_0_3_MPORT_1_mask) begin
      dataMem_0_3[dataMem_0_3_MPORT_1_addr] <= dataMem_0_3_MPORT_1_data; // @[Cache.scala 65:45]
    end
    dataMem_0_3_rdata_MPORT_en_pipe_0 <= _ren_T_2 & io_cpu_req_valid;
    if (_ren_T_2 & io_cpu_req_valid) begin
      dataMem_0_3_rdata_MPORT_addr_pipe_0 <= io_cpu_req_bits_addr[10:3];
    end
    if (dataMem_1_0_MPORT_2_en & dataMem_1_0_MPORT_2_mask) begin
      dataMem_1_0[dataMem_1_0_MPORT_2_addr] <= dataMem_1_0_MPORT_2_data; // @[Cache.scala 65:45]
    end
    dataMem_1_0_rdata_MPORT_1_en_pipe_0 <= _ren_T_2 & io_cpu_req_valid;
    if (_ren_T_2 & io_cpu_req_valid) begin
      dataMem_1_0_rdata_MPORT_1_addr_pipe_0 <= io_cpu_req_bits_addr[10:3];
    end
    if (dataMem_1_1_MPORT_2_en & dataMem_1_1_MPORT_2_mask) begin
      dataMem_1_1[dataMem_1_1_MPORT_2_addr] <= dataMem_1_1_MPORT_2_data; // @[Cache.scala 65:45]
    end
    dataMem_1_1_rdata_MPORT_1_en_pipe_0 <= _ren_T_2 & io_cpu_req_valid;
    if (_ren_T_2 & io_cpu_req_valid) begin
      dataMem_1_1_rdata_MPORT_1_addr_pipe_0 <= io_cpu_req_bits_addr[10:3];
    end
    if (dataMem_1_2_MPORT_2_en & dataMem_1_2_MPORT_2_mask) begin
      dataMem_1_2[dataMem_1_2_MPORT_2_addr] <= dataMem_1_2_MPORT_2_data; // @[Cache.scala 65:45]
    end
    dataMem_1_2_rdata_MPORT_1_en_pipe_0 <= _ren_T_2 & io_cpu_req_valid;
    if (_ren_T_2 & io_cpu_req_valid) begin
      dataMem_1_2_rdata_MPORT_1_addr_pipe_0 <= io_cpu_req_bits_addr[10:3];
    end
    if (dataMem_1_3_MPORT_2_en & dataMem_1_3_MPORT_2_mask) begin
      dataMem_1_3[dataMem_1_3_MPORT_2_addr] <= dataMem_1_3_MPORT_2_data; // @[Cache.scala 65:45]
    end
    dataMem_1_3_rdata_MPORT_1_en_pipe_0 <= _ren_T_2 & io_cpu_req_valid;
    if (_ren_T_2 & io_cpu_req_valid) begin
      dataMem_1_3_rdata_MPORT_1_addr_pipe_0 <= io_cpu_req_bits_addr[10:3];
    end
    if (reset) begin // @[Cache.scala 60:22]
      state <= 3'h0; // @[Cache.scala 60:22]
    end else if (3'h0 == state) begin // @[Cache.scala 168:17]
      if (io_cpu_req_valid) begin // @[Cache.scala 170:30]
        state <= {{1'd0}, _state_T_1}; // @[Cache.scala 171:15]
      end
    end else if (3'h1 == state) begin // @[Cache.scala 168:17]
      if (hit) begin // @[Cache.scala 175:17]
        state <= {{1'd0}, _GEN_63};
      end else begin
        state <= _GEN_65;
      end
    end else if (3'h2 == state) begin // @[Cache.scala 168:17]
      state <= _GEN_71;
    end else begin
      state <= _GEN_85;
    end
    if (reset) begin // @[Cache.scala 62:18]
      v <= 256'h0; // @[Cache.scala 62:18]
    end else if (wen) begin // @[Cache.scala 121:13]
      v <= _v_T_1; // @[Cache.scala 122:7]
    end
    if (reset) begin // @[Cache.scala 63:18]
      d <= 256'h0; // @[Cache.scala 63:18]
    end else if (wen) begin // @[Cache.scala 121:13]
      if (_wmask_T) begin // @[Cache.scala 123:18]
        d <= _d_T_2;
      end else begin
        d <= _d_T_5;
      end
    end
    if (io_cpu_resp_valid) begin // @[Cache.scala 105:27]
      addr_reg <= io_cpu_req_bits_addr; // @[Cache.scala 106:14]
    end
    if (io_cpu_resp_valid) begin // @[Cache.scala 105:27]
      cpu_data <= io_cpu_req_bits_data; // @[Cache.scala 107:14]
    end
    if (io_cpu_resp_valid) begin // @[Cache.scala 105:27]
      cpu_mask <= io_cpu_req_bits_mask; // @[Cache.scala 108:14]
    end
    is_alloc_reg <= state == 3'h6 & read_wrap_out; // @[Cache.scala 79:36]
    ren_reg <= ~wen & (is_idle | is_read) & io_cpu_req_valid; // @[Cache.scala 84:42]
    if (ren_reg) begin // @[Reg.scala 17:18]
      rdata_buf <= rdata; // @[Reg.scala 17:22]
    end
    if (read_wrap_out) begin // @[Cache.scala 144:25]
      refill_buf_0 <= io_nasti_r_bits_data; // @[Cache.scala 145:28]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    metaMem_tag[initvar] = _RAND_0[20:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_0_0[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_0_1[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_0_2[initvar] = _RAND_9[7:0];
  _RAND_12 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_0_3[initvar] = _RAND_12[7:0];
  _RAND_15 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_1_0[initvar] = _RAND_15[7:0];
  _RAND_18 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_1_1[initvar] = _RAND_18[7:0];
  _RAND_21 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_1_2[initvar] = _RAND_21[7:0];
  _RAND_24 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_1_3[initvar] = _RAND_24[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  metaMem_tag_rmeta_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  metaMem_tag_rmeta_addr_pipe_0 = _RAND_2[7:0];
  _RAND_4 = {1{`RANDOM}};
  dataMem_0_0_rdata_MPORT_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  dataMem_0_0_rdata_MPORT_addr_pipe_0 = _RAND_5[7:0];
  _RAND_7 = {1{`RANDOM}};
  dataMem_0_1_rdata_MPORT_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  dataMem_0_1_rdata_MPORT_addr_pipe_0 = _RAND_8[7:0];
  _RAND_10 = {1{`RANDOM}};
  dataMem_0_2_rdata_MPORT_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  dataMem_0_2_rdata_MPORT_addr_pipe_0 = _RAND_11[7:0];
  _RAND_13 = {1{`RANDOM}};
  dataMem_0_3_rdata_MPORT_en_pipe_0 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  dataMem_0_3_rdata_MPORT_addr_pipe_0 = _RAND_14[7:0];
  _RAND_16 = {1{`RANDOM}};
  dataMem_1_0_rdata_MPORT_1_en_pipe_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  dataMem_1_0_rdata_MPORT_1_addr_pipe_0 = _RAND_17[7:0];
  _RAND_19 = {1{`RANDOM}};
  dataMem_1_1_rdata_MPORT_1_en_pipe_0 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  dataMem_1_1_rdata_MPORT_1_addr_pipe_0 = _RAND_20[7:0];
  _RAND_22 = {1{`RANDOM}};
  dataMem_1_2_rdata_MPORT_1_en_pipe_0 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  dataMem_1_2_rdata_MPORT_1_addr_pipe_0 = _RAND_23[7:0];
  _RAND_25 = {1{`RANDOM}};
  dataMem_1_3_rdata_MPORT_1_en_pipe_0 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  dataMem_1_3_rdata_MPORT_1_addr_pipe_0 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  state = _RAND_27[2:0];
  _RAND_28 = {8{`RANDOM}};
  v = _RAND_28[255:0];
  _RAND_29 = {8{`RANDOM}};
  d = _RAND_29[255:0];
  _RAND_30 = {1{`RANDOM}};
  addr_reg = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  cpu_data = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  cpu_mask = _RAND_32[3:0];
  _RAND_33 = {1{`RANDOM}};
  is_alloc_reg = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  ren_reg = _RAND_34[0:0];
  _RAND_35 = {2{`RANDOM}};
  rdata_buf = _RAND_35[63:0];
  _RAND_36 = {2{`RANDOM}};
  refill_buf_0 = _RAND_36[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemArbiter(
  input         clock,
  input         reset,
  output        io_icache_ar_ready,
  input         io_icache_ar_valid,
  input  [31:0] io_icache_ar_bits_addr,
  input         io_icache_r_ready,
  output        io_icache_r_valid,
  output [63:0] io_icache_r_bits_data,
  output        io_dcache_aw_ready,
  input         io_dcache_aw_valid,
  input  [31:0] io_dcache_aw_bits_addr,
  output        io_dcache_w_ready,
  input         io_dcache_w_valid,
  input  [63:0] io_dcache_w_bits_data,
  input         io_dcache_w_bits_last,
  input         io_dcache_b_ready,
  output        io_dcache_b_valid,
  output        io_dcache_ar_ready,
  input         io_dcache_ar_valid,
  input  [31:0] io_dcache_ar_bits_addr,
  input         io_dcache_r_ready,
  output        io_dcache_r_valid,
  output [63:0] io_dcache_r_bits_data,
  input         io_nasti_aw_ready,
  output        io_nasti_aw_valid,
  output [31:0] io_nasti_aw_bits_addr,
  input         io_nasti_w_ready,
  output        io_nasti_w_valid,
  output [63:0] io_nasti_w_bits_data,
  output        io_nasti_b_ready,
  input         io_nasti_b_valid,
  input         io_nasti_ar_ready,
  output        io_nasti_ar_valid,
  output [31:0] io_nasti_ar_bits_addr,
  output        io_nasti_r_ready,
  input         io_nasti_r_valid,
  input  [63:0] io_nasti_r_bits_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[Tile.scala 27:22]
  wire  _io_nasti_aw_valid_T = state == 3'h0; // @[Tile.scala 33:52]
  wire  _io_nasti_w_valid_T = state == 3'h3; // @[Tile.scala 39:50]
  wire  _io_dcache_b_valid_T = state == 3'h4; // @[Tile.scala 45:50]
  wire  _io_nasti_ar_valid_T_1 = ~io_nasti_aw_valid; // @[Tile.scala 59:5]
  wire  _io_nasti_ar_valid_T_2 = (io_icache_ar_valid | io_dcache_ar_valid) & _io_nasti_ar_valid_T_1; // @[Tile.scala 58:67]
  wire  _io_icache_r_valid_T = state == 3'h1; // @[Tile.scala 66:50]
  wire  _io_dcache_r_valid_T = state == 3'h2; // @[Tile.scala 67:50]
  wire  _io_nasti_r_ready_T_3 = io_dcache_r_ready & _io_dcache_r_valid_T; // @[Tile.scala 69:23]
  wire  _T_3 = io_dcache_aw_ready & io_dcache_aw_valid; // @[Decoupled.scala 50:35]
  wire  _T_4 = io_dcache_ar_ready & io_dcache_ar_valid; // @[Decoupled.scala 50:35]
  wire  _T_5 = io_icache_ar_ready & io_icache_ar_valid; // @[Decoupled.scala 50:35]
  wire [2:0] _GEN_0 = _T_5 ? 3'h1 : state; // @[Tile.scala 78:37 79:15 27:22]
  wire  _T_9 = io_nasti_r_ready & io_nasti_r_valid; // @[Decoupled.scala 50:35]
  wire [2:0] _GEN_3 = _T_9 ? 3'h0 : state; // @[Tile.scala 83:53 84:15 27:22]
  wire  _T_19 = io_dcache_w_ready & io_dcache_w_valid; // @[Decoupled.scala 50:35]
  wire [2:0] _GEN_5 = _T_19 & io_dcache_w_bits_last ? 3'h4 : state; // @[Tile.scala 93:55 94:15 27:22]
  wire  _T_24 = io_nasti_b_ready & io_nasti_b_valid; // @[Decoupled.scala 50:35]
  wire [2:0] _GEN_6 = _T_24 ? 3'h0 : state; // @[Tile.scala 98:29 99:15 27:22]
  wire [2:0] _GEN_7 = 3'h4 == state ? _GEN_6 : state; // @[Tile.scala 72:17 27:22]
  wire [2:0] _GEN_8 = 3'h3 == state ? _GEN_5 : _GEN_7; // @[Tile.scala 72:17]
  assign io_icache_ar_ready = io_dcache_ar_ready & ~io_dcache_ar_valid; // @[Tile.scala 61:44]
  assign io_icache_r_valid = io_nasti_r_valid & state == 3'h1; // @[Tile.scala 66:41]
  assign io_icache_r_bits_data = io_nasti_r_bits_data; // @[Tile.scala 64:20]
  assign io_dcache_aw_ready = io_nasti_aw_ready & _io_nasti_aw_valid_T; // @[Tile.scala 34:43]
  assign io_dcache_w_ready = io_nasti_w_ready & _io_nasti_w_valid_T; // @[Tile.scala 40:41]
  assign io_dcache_b_valid = io_nasti_b_valid & state == 3'h4; // @[Tile.scala 45:41]
  assign io_dcache_ar_ready = io_nasti_ar_ready & _io_nasti_ar_valid_T_1 & _io_nasti_aw_valid_T; // @[Tile.scala 60:65]
  assign io_dcache_r_valid = io_nasti_r_valid & state == 3'h2; // @[Tile.scala 67:41]
  assign io_dcache_r_bits_data = io_nasti_r_bits_data; // @[Tile.scala 65:20]
  assign io_nasti_aw_valid = io_dcache_aw_valid & state == 3'h0; // @[Tile.scala 33:43]
  assign io_nasti_aw_bits_addr = io_dcache_aw_bits_addr; // @[Tile.scala 32:20]
  assign io_nasti_w_valid = io_dcache_w_valid & state == 3'h3; // @[Tile.scala 39:41]
  assign io_nasti_w_bits_data = io_dcache_w_bits_data; // @[Tile.scala 38:19]
  assign io_nasti_b_ready = io_dcache_b_ready & _io_dcache_b_valid_T; // @[Tile.scala 46:41]
  assign io_nasti_ar_valid = _io_nasti_ar_valid_T_2 & _io_nasti_aw_valid_T; // @[Tile.scala 59:24]
  assign io_nasti_ar_bits_addr = io_dcache_ar_valid ? io_dcache_ar_bits_addr : io_icache_ar_bits_addr; // @[Tile.scala 54:8]
  assign io_nasti_r_ready = io_icache_r_ready & _io_icache_r_valid_T | _io_nasti_r_ready_T_3; // @[Tile.scala 68:66]
  always @(posedge clock) begin
    if (reset) begin // @[Tile.scala 27:22]
      state <= 3'h0; // @[Tile.scala 27:22]
    end else if (3'h0 == state) begin // @[Tile.scala 72:17]
      if (_T_3) begin // @[Tile.scala 74:31]
        state <= 3'h3; // @[Tile.scala 75:15]
      end else if (_T_4) begin // @[Tile.scala 76:37]
        state <= 3'h2; // @[Tile.scala 77:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (3'h1 == state) begin // @[Tile.scala 72:17]
      state <= _GEN_3;
    end else if (3'h2 == state) begin // @[Tile.scala 72:17]
      state <= _GEN_3;
    end else begin
      state <= _GEN_8;
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
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Selector(
  input         clock,
  input         reset,
  input         io_cpu_abort,
  input         io_cpu_req_valid,
  input  [31:0] io_cpu_req_bits_addr,
  input  [31:0] io_cpu_req_bits_data,
  input  [3:0]  io_cpu_req_bits_mask,
  output        io_cpu_resp_valid,
  output [31:0] io_cpu_resp_bits_data,
  output        io_dcache_abort,
  output        io_dcache_req_valid,
  output [31:0] io_dcache_req_bits_addr,
  output [31:0] io_dcache_req_bits_data,
  output [3:0]  io_dcache_req_bits_mask,
  input         io_dcache_resp_valid,
  input  [31:0] io_dcache_resp_bits_data,
  output        io_device_req_valid,
  output [31:0] io_device_req_bits_addr,
  output [31:0] io_device_req_bits_data,
  input         io_device_resp_valid,
  input  [31:0] io_device_resp_bits_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] addr; // @[Selector.scala 27:21]
  wire [31:0] _io_dcache_req_valid_T = io_cpu_req_bits_addr & 32'hf0000000; // @[Selector.scala 37:48]
  wire  _io_dcache_req_valid_T_1 = 32'h10000000 == _io_dcache_req_valid_T; // @[Selector.scala 37:48]
  wire [31:0] _io_cpu_resp_bits_data_T = addr & 32'hf0000000; // @[Selector.scala 46:37]
  wire  _io_cpu_resp_bits_data_T_1 = 32'h10000000 == _io_cpu_resp_bits_data_T; // @[Selector.scala 46:37]
  assign io_cpu_resp_valid = _io_cpu_resp_bits_data_T_1 ? io_device_resp_valid : io_dcache_resp_valid; // @[Selector.scala 48:27]
  assign io_cpu_resp_bits_data = 32'h10000000 == _io_cpu_resp_bits_data_T ? io_device_resp_bits_data :
    io_dcache_resp_bits_data; // @[Selector.scala 46:31]
  assign io_dcache_abort = io_cpu_abort; // @[Selector.scala 52:19]
  assign io_dcache_req_valid = ~(32'h10000000 == _io_dcache_req_valid_T) & io_cpu_req_valid; // @[Selector.scala 37:66]
  assign io_dcache_req_bits_addr = io_cpu_req_bits_addr; // @[Selector.scala 34:27]
  assign io_dcache_req_bits_data = io_cpu_req_bits_data; // @[Selector.scala 35:27]
  assign io_dcache_req_bits_mask = io_cpu_req_bits_mask; // @[Selector.scala 36:27]
  assign io_device_req_valid = _io_dcache_req_valid_T_1 & io_cpu_req_valid; // @[Selector.scala 43:66]
  assign io_device_req_bits_addr = io_cpu_req_bits_addr; // @[Selector.scala 40:27]
  assign io_device_req_bits_data = io_cpu_req_bits_data; // @[Selector.scala 41:27]
  always @(posedge clock) begin
    if (reset) begin // @[Selector.scala 27:21]
      addr <= 32'h0; // @[Selector.scala 27:21]
    end else if (io_cpu_req_valid) begin // @[Selector.scala 28:25]
      addr <= io_cpu_req_bits_addr; // @[Selector.scala 29:10]
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
  _RAND_0 = {1{`RANDOM}};
  addr = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Tx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  state; // @[Uart.scala 30:22]
  reg [8:0] baud_count; // @[Counter.scala 62:40]
  wire  wrap_wrap = baud_count == 9'h1b0; // @[Counter.scala 74:24]
  wire [8:0] _wrap_value_T_1 = baud_count + 9'h1; // @[Counter.scala 78:24]
  wire  baud_wrap_out = state & wrap_wrap; // @[Counter.scala 120:{16,23}]
  reg [3:0] bit_count; // @[Counter.scala 62:40]
  wire  wrap_wrap_1 = bit_count == 4'ha; // @[Counter.scala 74:24]
  wire [3:0] _wrap_value_T_3 = bit_count + 4'h1; // @[Counter.scala 78:24]
  wire  bit_wrap_out = baud_wrap_out & wrap_wrap_1; // @[Counter.scala 120:{16,23}]
  reg [10:0] buffer; // @[Uart.scala 35:23]
  wire  _io_channel_ready_T = ~state; // @[Uart.scala 36:29]
  wire  _T_1 = io_channel_ready & io_channel_valid; // @[Decoupled.scala 50:35]
  wire [10:0] _buffer_T_1 = {2'h3,io_channel_bits,1'h0}; // @[Cat.scala 31:58]
  wire [10:0] _GEN_6 = _T_1 ? _buffer_T_1 : buffer; // @[Uart.scala 40:25 41:12 35:23]
  wire [10:0] shift = {{1'd0}, buffer[10:1]}; // @[Uart.scala 45:26]
  wire [10:0] _buffer_T_3 = {1'h1,shift[9:0]}; // @[Cat.scala 31:58]
  wire  _GEN_9 = _T_1 | state; // @[Uart.scala 53:29 54:15 30:22]
  assign io_txd = buffer[0]; // @[Uart.scala 37:19]
  assign io_channel_ready = ~state; // @[Uart.scala 36:29]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 30:22]
      state <= 1'h0; // @[Uart.scala 30:22]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 51:17]
      state <= _GEN_9;
    end else if (state) begin // @[Uart.scala 51:17]
      if (bit_wrap_out) begin // @[Uart.scala 58:26]
        state <= 1'h0; // @[Uart.scala 59:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      baud_count <= 9'h0; // @[Counter.scala 62:40]
    end else if (state) begin // @[Counter.scala 120:16]
      if (wrap_wrap) begin // @[Counter.scala 88:20]
        baud_count <= 9'h0; // @[Counter.scala 88:28]
      end else begin
        baud_count <= _wrap_value_T_1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      bit_count <= 4'h0; // @[Counter.scala 62:40]
    end else if (baud_wrap_out) begin // @[Counter.scala 120:16]
      if (wrap_wrap_1) begin // @[Counter.scala 88:20]
        bit_count <= 4'h0; // @[Counter.scala 88:28]
      end else begin
        bit_count <= _wrap_value_T_3; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Uart.scala 35:23]
      buffer <= 11'h7ff; // @[Uart.scala 35:23]
    end else if (state) begin // @[Uart.scala 43:26]
      if (baud_wrap_out) begin // @[Uart.scala 44:25]
        buffer <= _buffer_T_3; // @[Uart.scala 46:14]
      end else begin
        buffer <= _GEN_6;
      end
    end else begin
      buffer <= _GEN_6;
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
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  baud_count = _RAND_1[8:0];
  _RAND_2 = {1{`RANDOM}};
  bit_count = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  buffer = _RAND_3[10:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Buffer(
  input        clock,
  input        reset,
  output       io_in_ready,
  input        io_in_valid,
  input  [7:0] io_in_bits,
  input        io_out_ready,
  output       io_out_valid,
  output [7:0] io_out_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  state; // @[Uart.scala 72:22]
  reg [7:0] data; // @[Uart.scala 73:21]
  wire  _io_in_ready_T = ~state; // @[Uart.scala 75:24]
  wire  _T_1 = io_in_ready & io_in_valid; // @[Decoupled.scala 50:35]
  wire  _GEN_1 = _T_1 | state; // @[Uart.scala 81:24 83:15 72:22]
  wire  _T_3 = io_out_ready & io_out_valid; // @[Decoupled.scala 50:35]
  assign io_in_ready = ~state; // @[Uart.scala 75:24]
  assign io_out_valid = state; // @[Uart.scala 76:25]
  assign io_out_bits = data; // @[Uart.scala 77:15]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 72:22]
      state <= 1'h0; // @[Uart.scala 72:22]
    end else if (_io_in_ready_T) begin // @[Uart.scala 79:17]
      state <= _GEN_1;
    end else if (state) begin // @[Uart.scala 79:17]
      if (_T_3) begin // @[Uart.scala 87:25]
        state <= 1'h0; // @[Uart.scala 88:15]
      end
    end
    if (reset) begin // @[Uart.scala 73:21]
      data <= 8'h0; // @[Uart.scala 73:21]
    end else if (_io_in_ready_T) begin // @[Uart.scala 79:17]
      if (_T_1) begin // @[Uart.scala 81:24]
        data <= io_in_bits; // @[Uart.scala 82:14]
      end
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
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  data = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BufferedTx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
  wire  tx_clock; // @[Uart.scala 100:18]
  wire  tx_reset; // @[Uart.scala 100:18]
  wire  tx_io_txd; // @[Uart.scala 100:18]
  wire  tx_io_channel_ready; // @[Uart.scala 100:18]
  wire  tx_io_channel_valid; // @[Uart.scala 100:18]
  wire [7:0] tx_io_channel_bits; // @[Uart.scala 100:18]
  wire  buf__clock; // @[Uart.scala 101:19]
  wire  buf__reset; // @[Uart.scala 101:19]
  wire  buf__io_in_ready; // @[Uart.scala 101:19]
  wire  buf__io_in_valid; // @[Uart.scala 101:19]
  wire [7:0] buf__io_in_bits; // @[Uart.scala 101:19]
  wire  buf__io_out_ready; // @[Uart.scala 101:19]
  wire  buf__io_out_valid; // @[Uart.scala 101:19]
  wire [7:0] buf__io_out_bits; // @[Uart.scala 101:19]
  Tx tx ( // @[Uart.scala 100:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  Buffer buf_ ( // @[Uart.scala 101:19]
    .clock(buf__clock),
    .reset(buf__reset),
    .io_in_ready(buf__io_in_ready),
    .io_in_valid(buf__io_in_valid),
    .io_in_bits(buf__io_in_bits),
    .io_out_ready(buf__io_out_ready),
    .io_out_valid(buf__io_out_valid),
    .io_out_bits(buf__io_out_bits)
  );
  assign io_txd = tx_io_txd; // @[Uart.scala 105:10]
  assign io_channel_ready = buf__io_in_ready; // @[Uart.scala 103:13]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = buf__io_out_valid; // @[Uart.scala 104:17]
  assign tx_io_channel_bits = buf__io_out_bits; // @[Uart.scala 104:17]
  assign buf__clock = clock;
  assign buf__reset = reset;
  assign buf__io_in_valid = io_channel_valid; // @[Uart.scala 103:13]
  assign buf__io_in_bits = io_channel_bits; // @[Uart.scala 103:13]
  assign buf__io_out_ready = tx_io_channel_ready; // @[Uart.scala 104:17]
endmodule
module Rx(
  input        clock,
  input        reset,
  input        io_rxd,
  output       io_channel_valid,
  output [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[Uart.scala 122:22]
  reg [7:0] buffer; // @[Uart.scala 124:23]
  wire  _T = state == 2'h1; // @[Uart.scala 127:53]
  reg [9:0] first_count; // @[Counter.scala 62:40]
  wire  wrap_wrap = first_count == 10'h289; // @[Counter.scala 74:24]
  wire [9:0] _wrap_value_T_1 = first_count + 10'h1; // @[Counter.scala 78:24]
  wire  first_wrap_out = _T & wrap_wrap; // @[Counter.scala 120:{16,23}]
  wire  _T_3 = state == 2'h2 | state == 2'h3; // @[Uart.scala 128:65]
  reg [8:0] baud_count; // @[Counter.scala 62:40]
  wire  wrap_wrap_1 = baud_count == 9'h1b0; // @[Counter.scala 74:24]
  wire [8:0] _wrap_value_T_3 = baud_count + 9'h1; // @[Counter.scala 78:24]
  wire  baud_wrap_out = _T_3 & wrap_wrap_1; // @[Counter.scala 120:{16,23}]
  wire  _T_4 = baud_wrap_out | first_wrap_out; // @[Uart.scala 129:58]
  wire  _T_6 = (baud_wrap_out | first_wrap_out) & state != 2'h3; // @[Uart.scala 129:77]
  reg [2:0] bit_count; // @[Counter.scala 62:40]
  wire  wrap_wrap_2 = bit_count == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _wrap_value_T_5 = bit_count + 3'h1; // @[Counter.scala 78:24]
  wire  bit_wrap_out = _T_6 & wrap_wrap_2; // @[Counter.scala 120:{16,23}]
  wire [7:0] _buffer_T_1 = {io_rxd,buffer[7:1]}; // @[Cat.scala 31:58]
  reg  io_channel_valid_REG; // @[Uart.scala 138:30]
  wire [1:0] _GEN_11 = bit_wrap_out ? 2'h3 : state; // @[Uart.scala 153:26 154:15 122:22]
  wire [1:0] _GEN_12 = baud_wrap_out ? 2'h0 : state; // @[Uart.scala 158:27 159:15 122:22]
  wire [1:0] _GEN_13 = 2'h3 == state ? _GEN_12 : state; // @[Uart.scala 141:17 122:22]
  assign io_channel_valid = io_channel_valid_REG; // @[Uart.scala 138:20]
  assign io_channel_bits = buffer; // @[Uart.scala 137:19]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 122:22]
      state <= 2'h0; // @[Uart.scala 122:22]
    end else if (2'h0 == state) begin // @[Uart.scala 141:17]
      if (~io_rxd) begin // @[Uart.scala 143:28]
        state <= 2'h1; // @[Uart.scala 144:15]
      end
    end else if (2'h1 == state) begin // @[Uart.scala 141:17]
      if (first_wrap_out) begin // @[Uart.scala 148:28]
        state <= 2'h2; // @[Uart.scala 149:15]
      end
    end else if (2'h2 == state) begin // @[Uart.scala 141:17]
      state <= _GEN_11;
    end else begin
      state <= _GEN_13;
    end
    if (reset) begin // @[Uart.scala 124:23]
      buffer <= 8'h0; // @[Uart.scala 124:23]
    end else if (_T_4) begin // @[Uart.scala 132:41]
      buffer <= _buffer_T_1; // @[Uart.scala 133:12]
    end
    if (reset) begin // @[Counter.scala 62:40]
      first_count <= 10'h0; // @[Counter.scala 62:40]
    end else if (_T) begin // @[Counter.scala 120:16]
      if (wrap_wrap) begin // @[Counter.scala 88:20]
        first_count <= 10'h0; // @[Counter.scala 88:28]
      end else begin
        first_count <= _wrap_value_T_1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      baud_count <= 9'h0; // @[Counter.scala 62:40]
    end else if (_T_3) begin // @[Counter.scala 120:16]
      if (wrap_wrap_1) begin // @[Counter.scala 88:20]
        baud_count <= 9'h0; // @[Counter.scala 88:28]
      end else begin
        baud_count <= _wrap_value_T_3; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      bit_count <= 3'h0; // @[Counter.scala 62:40]
    end else if (_T_6) begin // @[Counter.scala 120:16]
      bit_count <= _wrap_value_T_5; // @[Counter.scala 78:15]
    end
    io_channel_valid_REG <= _T_6 & wrap_wrap_2; // @[Counter.scala 120:{16,23}]
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
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  buffer = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  first_count = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  baud_count = _RAND_3[8:0];
  _RAND_4 = {1{`RANDOM}};
  bit_count = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  io_channel_valid_REG = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BufferedRx(
  input        clock,
  input        reset,
  input        io_rxd,
  input        io_channel_ready,
  output       io_channel_valid,
  output [7:0] io_channel_bits
);
  wire  rx_clock; // @[Uart.scala 171:18]
  wire  rx_reset; // @[Uart.scala 171:18]
  wire  rx_io_rxd; // @[Uart.scala 171:18]
  wire  rx_io_channel_valid; // @[Uart.scala 171:18]
  wire [7:0] rx_io_channel_bits; // @[Uart.scala 171:18]
  wire  buf__clock; // @[Uart.scala 172:19]
  wire  buf__reset; // @[Uart.scala 172:19]
  wire  buf__io_in_ready; // @[Uart.scala 172:19]
  wire  buf__io_in_valid; // @[Uart.scala 172:19]
  wire [7:0] buf__io_in_bits; // @[Uart.scala 172:19]
  wire  buf__io_out_ready; // @[Uart.scala 172:19]
  wire  buf__io_out_valid; // @[Uart.scala 172:19]
  wire [7:0] buf__io_out_bits; // @[Uart.scala 172:19]
  Rx rx ( // @[Uart.scala 171:18]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rxd(rx_io_rxd),
    .io_channel_valid(rx_io_channel_valid),
    .io_channel_bits(rx_io_channel_bits)
  );
  Buffer buf_ ( // @[Uart.scala 172:19]
    .clock(buf__clock),
    .reset(buf__reset),
    .io_in_ready(buf__io_in_ready),
    .io_in_valid(buf__io_in_valid),
    .io_in_bits(buf__io_in_bits),
    .io_out_ready(buf__io_out_ready),
    .io_out_valid(buf__io_out_valid),
    .io_out_bits(buf__io_out_bits)
  );
  assign io_channel_valid = buf__io_out_valid; // @[Uart.scala 176:14]
  assign io_channel_bits = buf__io_out_bits; // @[Uart.scala 176:14]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rxd = io_rxd; // @[Uart.scala 174:10]
  assign buf__clock = clock;
  assign buf__reset = reset;
  assign buf__io_in_valid = rx_io_channel_valid; // @[Uart.scala 175:13]
  assign buf__io_in_bits = rx_io_channel_bits; // @[Uart.scala 175:13]
  assign buf__io_out_ready = io_channel_ready; // @[Uart.scala 176:14]
endmodule
module Uart(
  input        clock,
  input        reset,
  input        io_rxd,
  output       io_txd,
  input        io_rxChannel_ready,
  output       io_rxChannel_valid,
  output [7:0] io_rxChannel_bits,
  output       io_txChannel_ready,
  input        io_txChannel_valid,
  input  [7:0] io_txChannel_bits
);
  wire  tx_clock; // @[Uart.scala 187:18]
  wire  tx_reset; // @[Uart.scala 187:18]
  wire  tx_io_txd; // @[Uart.scala 187:18]
  wire  tx_io_channel_ready; // @[Uart.scala 187:18]
  wire  tx_io_channel_valid; // @[Uart.scala 187:18]
  wire [7:0] tx_io_channel_bits; // @[Uart.scala 187:18]
  wire  rx_clock; // @[Uart.scala 188:18]
  wire  rx_reset; // @[Uart.scala 188:18]
  wire  rx_io_rxd; // @[Uart.scala 188:18]
  wire  rx_io_channel_ready; // @[Uart.scala 188:18]
  wire  rx_io_channel_valid; // @[Uart.scala 188:18]
  wire [7:0] rx_io_channel_bits; // @[Uart.scala 188:18]
  BufferedTx tx ( // @[Uart.scala 187:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  BufferedRx rx ( // @[Uart.scala 188:18]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rxd(rx_io_rxd),
    .io_channel_ready(rx_io_channel_ready),
    .io_channel_valid(rx_io_channel_valid),
    .io_channel_bits(rx_io_channel_bits)
  );
  assign io_txd = tx_io_txd; // @[Uart.scala 192:13]
  assign io_rxChannel_valid = rx_io_channel_valid; // @[Uart.scala 191:17]
  assign io_rxChannel_bits = rx_io_channel_bits; // @[Uart.scala 191:17]
  assign io_txChannel_ready = tx_io_channel_ready; // @[Uart.scala 190:17]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = io_txChannel_valid; // @[Uart.scala 190:17]
  assign tx_io_channel_bits = io_txChannel_bits; // @[Uart.scala 190:17]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rxd = io_rxd; // @[Uart.scala 193:13]
  assign rx_io_channel_ready = io_rxChannel_ready; // @[Uart.scala 191:17]
endmodule
module UartController(
  input         clock,
  input         reset,
  input         io_cpu_req_valid,
  input  [31:0] io_cpu_req_bits_addr,
  input  [31:0] io_cpu_req_bits_data,
  output        io_cpu_resp_valid,
  output [31:0] io_cpu_resp_bits_data,
  output        io_rxChannel_ready,
  input         io_rxChannel_valid,
  input  [7:0]  io_rxChannel_bits,
  input         io_txChannel_ready,
  output        io_txChannel_valid,
  output [7:0]  io_txChannel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[Uart.scala 204:22]
  wire  is_READ_READ_STATE = state == 3'h1; // @[Uart.scala 206:34]
  wire  is_READ_WRITE_STATE = state == 3'h2; // @[Uart.scala 207:35]
  wire  is_READ_DATA = state == 3'h3; // @[Uart.scala 208:28]
  wire  _rdata_T_1 = is_READ_READ_STATE | is_READ_WRITE_STATE | is_READ_DATA; // @[Uart.scala 211:90]
  reg [31:0] rdata; // @[Reg.scala 16:16]
  reg [31:0] wdata; // @[Uart.scala 212:22]
  wire [2:0] _state_T_1 = 32'h10000000 == io_cpu_req_bits_addr ? 3'h1 : 3'h0; // @[Mux.scala 81:58]
  wire [2:0] _state_T_3 = 32'h10000004 == io_cpu_req_bits_addr ? 3'h3 : _state_T_1; // @[Mux.scala 81:58]
  wire [2:0] _state_T_5 = 32'h10000008 == io_cpu_req_bits_addr ? 3'h2 : _state_T_3; // @[Mux.scala 81:58]
  wire  _T_4 = io_rxChannel_ready & io_rxChannel_valid; // @[Decoupled.scala 50:35]
  wire [31:0] _GEN_4 = _T_4 ? {{24'd0}, io_rxChannel_bits} : rdata; // @[Uart.scala 216:25 255:31 256:31]
  wire [2:0] _GEN_6 = _T_4 ? 3'h0 : state; // @[Uart.scala 255:31 258:15 204:22]
  wire  _T_6 = io_txChannel_ready & io_txChannel_valid; // @[Decoupled.scala 50:35]
  wire [2:0] _GEN_7 = _T_6 ? 3'h0 : state; // @[Uart.scala 266:31 267:15 204:22]
  wire [7:0] _GEN_8 = 3'h4 == state ? wdata[7:0] : 8'h0; // @[Uart.scala 227:17 217:21 264:25]
  wire [2:0] _GEN_10 = 3'h4 == state ? _GEN_7 : state; // @[Uart.scala 227:17 204:22]
  wire [31:0] _GEN_12 = 3'h3 == state ? _GEN_4 : rdata; // @[Uart.scala 227:17 216:25]
  wire  _GEN_13 = 3'h3 == state & _T_4; // @[Uart.scala 227:17 215:21]
  wire [2:0] _GEN_14 = 3'h3 == state ? _GEN_6 : _GEN_10; // @[Uart.scala 227:17]
  wire [7:0] _GEN_15 = 3'h3 == state ? 8'h0 : _GEN_8; // @[Uart.scala 227:17 217:21]
  wire  _GEN_16 = 3'h3 == state ? 1'h0 : 3'h4 == state; // @[Uart.scala 227:17 218:22]
  wire [31:0] _GEN_17 = 3'h2 == state ? {{31'd0}, io_txChannel_ready} : _GEN_12; // @[Uart.scala 227:17 249:29]
  wire  _GEN_18 = 3'h2 == state | _GEN_13; // @[Uart.scala 227:17 250:25]
  wire  _GEN_20 = 3'h2 == state ? 1'h0 : 3'h3 == state; // @[Uart.scala 227:17 214:22]
  wire [7:0] _GEN_21 = 3'h2 == state ? 8'h0 : _GEN_15; // @[Uart.scala 227:17 217:21]
  wire  _GEN_22 = 3'h2 == state ? 1'h0 : _GEN_16; // @[Uart.scala 227:17 218:22]
  wire [31:0] _GEN_23 = 3'h1 == state ? {{31'd0}, io_rxChannel_valid} : _GEN_17; // @[Uart.scala 227:17 243:29]
  wire  _GEN_24 = 3'h1 == state | _GEN_18; // @[Uart.scala 227:17 244:25]
  wire  _GEN_26 = 3'h1 == state ? 1'h0 : _GEN_20; // @[Uart.scala 227:17 214:22]
  wire [7:0] _GEN_27 = 3'h1 == state ? 8'h0 : _GEN_21; // @[Uart.scala 227:17 217:21]
  wire  _GEN_28 = 3'h1 == state ? 1'h0 : _GEN_22; // @[Uart.scala 227:17 218:22]
  assign io_cpu_resp_valid = 3'h0 == state | _GEN_24; // @[Uart.scala 227:17 229:25]
  assign io_cpu_resp_bits_data = 3'h0 == state ? rdata : _GEN_23; // @[Uart.scala 227:17 216:25]
  assign io_rxChannel_ready = 3'h0 == state ? 1'h0 : _GEN_26; // @[Uart.scala 227:17 214:22]
  assign io_txChannel_valid = 3'h0 == state ? 1'h0 : _GEN_28; // @[Uart.scala 227:17 218:22]
  assign io_txChannel_bits = 3'h0 == state ? 8'h0 : _GEN_27; // @[Uart.scala 227:17 217:21]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 204:22]
      state <= 3'h0; // @[Uart.scala 204:22]
    end else if (3'h0 == state) begin // @[Uart.scala 227:17]
      if (io_cpu_req_valid) begin // @[Uart.scala 230:29]
        if (32'h1000000c == io_cpu_req_bits_addr) begin // @[Mux.scala 81:58]
          state <= 3'h4;
        end else begin
          state <= _state_T_5;
        end
      end
    end else if (3'h1 == state) begin // @[Uart.scala 227:17]
      state <= 3'h0; // @[Uart.scala 245:13]
    end else if (3'h2 == state) begin // @[Uart.scala 227:17]
      state <= 3'h0; // @[Uart.scala 251:13]
    end else begin
      state <= _GEN_14;
    end
    if (_rdata_T_1) begin // @[Reg.scala 17:18]
      rdata <= io_cpu_resp_bits_data; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[Uart.scala 212:22]
      wdata <= 32'h0; // @[Uart.scala 212:22]
    end else if (3'h0 == state) begin // @[Uart.scala 227:17]
      if (io_cpu_req_valid) begin // @[Uart.scala 230:29]
        wdata <= io_cpu_req_bits_data; // @[Uart.scala 232:15]
      end
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
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  rdata = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  wdata = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BRAMController(
  input         clock,
  input         reset,
  output        io_nasti_aw_ready,
  input         io_nasti_aw_valid,
  input  [31:0] io_nasti_aw_bits_addr,
  output        io_nasti_w_ready,
  input         io_nasti_w_valid,
  input  [63:0] io_nasti_w_bits_data,
  input         io_nasti_b_ready,
  output        io_nasti_b_valid,
  output        io_nasti_ar_ready,
  input         io_nasti_ar_valid,
  input  [31:0] io_nasti_ar_bits_addr,
  input         io_nasti_r_ready,
  output        io_nasti_r_valid,
  output [63:0] io_nasti_r_bits_data,
  output        io_bport_clka,
  output        io_bport_ena,
  output        io_bport_wea,
  output [11:0] io_bport_addra,
  output [63:0] io_bport_dina,
  input  [63:0] io_bport_douta
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[BRAM.scala 71:22]
  reg  is_write; // @[BRAM.scala 72:25]
  reg  counter; // @[BRAM.scala 73:24]
  wire  _GEN_1 = io_nasti_aw_valid & io_nasti_aw_ready & io_nasti_w_valid & io_nasti_w_ready | is_write; // @[BRAM.scala 81:99 83:20 72:25]
  wire  _T_8 = io_nasti_r_ready & io_nasti_r_valid; // @[Decoupled.scala 50:35]
  wire [1:0] _GEN_6 = is_write ? 2'h3 : state; // @[BRAM.scala 71:22 95:{29,37}]
  wire [1:0] _GEN_7 = _T_8 ? 2'h0 : _GEN_6; // @[BRAM.scala 94:{29,37}]
  wire  _T_10 = io_nasti_b_ready & io_nasti_b_valid; // @[Decoupled.scala 50:35]
  wire [1:0] _GEN_8 = _T_10 ? 2'h0 : state; // @[BRAM.scala 71:22 98:{29,37}]
  wire [1:0] _GEN_9 = 2'h3 == state ? _GEN_8 : state; // @[BRAM.scala 75:17 71:22]
  reg [11:0] addr; // @[BRAM.scala 102:21]
  wire [31:0] _addr_T = {{3'd0}, io_nasti_ar_bits_addr[31:3]}; // @[BRAM.scala 113:49]
  wire [31:0] _addr_T_1 = {{3'd0}, io_nasti_aw_bits_addr[31:3]}; // @[BRAM.scala 114:49]
  wire [31:0] _addr_T_2 = io_nasti_aw_valid ? _addr_T_1 : {{20'd0}, addr}; // @[Mux.scala 101:16]
  wire [31:0] _addr_T_3 = io_nasti_ar_valid ? _addr_T : _addr_T_2; // @[Mux.scala 101:16]
  wire [7:0] wdata_0 = io_nasti_w_bits_data[7:0]; // @[BRAM.scala 129:73]
  wire [7:0] wdata_1 = io_nasti_w_bits_data[15:8]; // @[BRAM.scala 129:73]
  wire [7:0] wdata_2 = io_nasti_w_bits_data[23:16]; // @[BRAM.scala 129:73]
  wire [7:0] wdata_3 = io_nasti_w_bits_data[31:24]; // @[BRAM.scala 129:73]
  wire [7:0] wdata_4 = io_nasti_w_bits_data[39:32]; // @[BRAM.scala 129:73]
  wire [7:0] wdata_5 = io_nasti_w_bits_data[47:40]; // @[BRAM.scala 129:73]
  wire [7:0] wdata_6 = io_nasti_w_bits_data[55:48]; // @[BRAM.scala 129:73]
  wire [7:0] wdata_7 = io_nasti_w_bits_data[63:56]; // @[BRAM.scala 129:73]
  wire [31:0] io_bport_dina_lo = {wdata_3,wdata_2,wdata_1,wdata_0}; // @[Cat.scala 31:58]
  wire [31:0] io_bport_dina_hi = {wdata_7,wdata_6,wdata_5,wdata_4}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_18 = reset ? 32'h0 : _addr_T_3; // @[BRAM.scala 102:{21,21} 112:8]
  assign io_nasti_aw_ready = state == 2'h0; // @[BRAM.scala 109:30]
  assign io_nasti_w_ready = state == 2'h0; // @[BRAM.scala 110:29]
  assign io_nasti_b_valid = state == 2'h3; // @[BRAM.scala 132:29]
  assign io_nasti_ar_ready = state == 2'h0; // @[BRAM.scala 108:30]
  assign io_nasti_r_valid = state == 2'h2 & ~is_write; // @[BRAM.scala 119:39]
  assign io_nasti_r_bits_data = io_bport_douta; // @[BRAM.scala 120:24]
  assign io_bport_clka = clock; // @[BRAM.scala 106:17]
  assign io_bport_ena = state != 2'h0; // @[BRAM.scala 107:25]
  assign io_bport_wea = state == 2'h3; // @[BRAM.scala 126:25]
  assign io_bport_addra = addr; // @[BRAM.scala 116:18]
  assign io_bport_dina = {io_bport_dina_hi,io_bport_dina_lo}; // @[Cat.scala 31:58]
  always @(posedge clock) begin
    if (reset) begin // @[BRAM.scala 71:22]
      state <= 2'h0; // @[BRAM.scala 71:22]
    end else if (2'h0 == state) begin // @[BRAM.scala 75:17]
      if (io_nasti_ar_valid & io_nasti_ar_ready) begin // @[BRAM.scala 77:52]
        state <= 2'h1; // @[BRAM.scala 78:15]
      end else if (io_nasti_aw_valid & io_nasti_aw_ready & io_nasti_w_valid & io_nasti_w_ready) begin // @[BRAM.scala 81:99]
        state <= 2'h1; // @[BRAM.scala 82:17]
      end
    end else if (2'h1 == state) begin // @[BRAM.scala 75:17]
      if (counter) begin // @[BRAM.scala 88:29]
        state <= 2'h2; // @[BRAM.scala 90:15]
      end
    end else if (2'h2 == state) begin // @[BRAM.scala 75:17]
      state <= _GEN_7;
    end else begin
      state <= _GEN_9;
    end
    if (reset) begin // @[BRAM.scala 72:25]
      is_write <= 1'h0; // @[BRAM.scala 72:25]
    end else if (2'h0 == state) begin // @[BRAM.scala 75:17]
      if (io_nasti_ar_valid & io_nasti_ar_ready) begin // @[BRAM.scala 77:52]
        is_write <= 1'h0; // @[BRAM.scala 79:18]
      end else begin
        is_write <= _GEN_1;
      end
    end
    if (reset) begin // @[BRAM.scala 73:24]
      counter <= 1'h0; // @[BRAM.scala 73:24]
    end else if (!(2'h0 == state)) begin // @[BRAM.scala 75:17]
      if (2'h1 == state) begin // @[BRAM.scala 75:17]
        if (counter) begin // @[BRAM.scala 88:29]
          counter <= 1'h0; // @[BRAM.scala 89:17]
        end else begin
          counter <= counter + 1'h1; // @[BRAM.scala 87:15]
        end
      end
    end
    addr <= _GEN_18[11:0]; // @[BRAM.scala 102:{21,21} 112:8]
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
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  is_write = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  counter = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  addr = _RAND_3[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Tile(
  input   clock,
  input   reset,
  output  io_txd,
  input   io_rxd
);
  wire  core_clock; // @[Tile.scala 121:20]
  wire  core_reset; // @[Tile.scala 121:20]
  wire  core_io_icache_req_valid; // @[Tile.scala 121:20]
  wire [31:0] core_io_icache_req_bits_addr; // @[Tile.scala 121:20]
  wire  core_io_icache_resp_valid; // @[Tile.scala 121:20]
  wire [31:0] core_io_icache_resp_bits_data; // @[Tile.scala 121:20]
  wire  core_io_dcache_abort; // @[Tile.scala 121:20]
  wire  core_io_dcache_req_valid; // @[Tile.scala 121:20]
  wire [31:0] core_io_dcache_req_bits_addr; // @[Tile.scala 121:20]
  wire [31:0] core_io_dcache_req_bits_data; // @[Tile.scala 121:20]
  wire [3:0] core_io_dcache_req_bits_mask; // @[Tile.scala 121:20]
  wire  core_io_dcache_resp_valid; // @[Tile.scala 121:20]
  wire [31:0] core_io_dcache_resp_bits_data; // @[Tile.scala 121:20]
  wire  icache_clock; // @[Tile.scala 122:22]
  wire  icache_reset; // @[Tile.scala 122:22]
  wire  icache_io_cpu_abort; // @[Tile.scala 122:22]
  wire  icache_io_cpu_req_valid; // @[Tile.scala 122:22]
  wire [31:0] icache_io_cpu_req_bits_addr; // @[Tile.scala 122:22]
  wire [31:0] icache_io_cpu_req_bits_data; // @[Tile.scala 122:22]
  wire [3:0] icache_io_cpu_req_bits_mask; // @[Tile.scala 122:22]
  wire  icache_io_cpu_resp_valid; // @[Tile.scala 122:22]
  wire [31:0] icache_io_cpu_resp_bits_data; // @[Tile.scala 122:22]
  wire  icache_io_nasti_aw_ready; // @[Tile.scala 122:22]
  wire  icache_io_nasti_aw_valid; // @[Tile.scala 122:22]
  wire [31:0] icache_io_nasti_aw_bits_addr; // @[Tile.scala 122:22]
  wire  icache_io_nasti_w_ready; // @[Tile.scala 122:22]
  wire  icache_io_nasti_w_valid; // @[Tile.scala 122:22]
  wire [63:0] icache_io_nasti_w_bits_data; // @[Tile.scala 122:22]
  wire  icache_io_nasti_w_bits_last; // @[Tile.scala 122:22]
  wire  icache_io_nasti_b_ready; // @[Tile.scala 122:22]
  wire  icache_io_nasti_b_valid; // @[Tile.scala 122:22]
  wire  icache_io_nasti_ar_ready; // @[Tile.scala 122:22]
  wire  icache_io_nasti_ar_valid; // @[Tile.scala 122:22]
  wire [31:0] icache_io_nasti_ar_bits_addr; // @[Tile.scala 122:22]
  wire  icache_io_nasti_r_ready; // @[Tile.scala 122:22]
  wire  icache_io_nasti_r_valid; // @[Tile.scala 122:22]
  wire [63:0] icache_io_nasti_r_bits_data; // @[Tile.scala 122:22]
  wire  dcache_clock; // @[Tile.scala 123:22]
  wire  dcache_reset; // @[Tile.scala 123:22]
  wire  dcache_io_cpu_abort; // @[Tile.scala 123:22]
  wire  dcache_io_cpu_req_valid; // @[Tile.scala 123:22]
  wire [31:0] dcache_io_cpu_req_bits_addr; // @[Tile.scala 123:22]
  wire [31:0] dcache_io_cpu_req_bits_data; // @[Tile.scala 123:22]
  wire [3:0] dcache_io_cpu_req_bits_mask; // @[Tile.scala 123:22]
  wire  dcache_io_cpu_resp_valid; // @[Tile.scala 123:22]
  wire [31:0] dcache_io_cpu_resp_bits_data; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_aw_ready; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_aw_valid; // @[Tile.scala 123:22]
  wire [31:0] dcache_io_nasti_aw_bits_addr; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_w_ready; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_w_valid; // @[Tile.scala 123:22]
  wire [63:0] dcache_io_nasti_w_bits_data; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_w_bits_last; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_b_ready; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_b_valid; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_ar_ready; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_ar_valid; // @[Tile.scala 123:22]
  wire [31:0] dcache_io_nasti_ar_bits_addr; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_r_ready; // @[Tile.scala 123:22]
  wire  dcache_io_nasti_r_valid; // @[Tile.scala 123:22]
  wire [63:0] dcache_io_nasti_r_bits_data; // @[Tile.scala 123:22]
  wire  arb_clock; // @[Tile.scala 124:19]
  wire  arb_reset; // @[Tile.scala 124:19]
  wire  arb_io_icache_ar_ready; // @[Tile.scala 124:19]
  wire  arb_io_icache_ar_valid; // @[Tile.scala 124:19]
  wire [31:0] arb_io_icache_ar_bits_addr; // @[Tile.scala 124:19]
  wire  arb_io_icache_r_ready; // @[Tile.scala 124:19]
  wire  arb_io_icache_r_valid; // @[Tile.scala 124:19]
  wire [63:0] arb_io_icache_r_bits_data; // @[Tile.scala 124:19]
  wire  arb_io_dcache_aw_ready; // @[Tile.scala 124:19]
  wire  arb_io_dcache_aw_valid; // @[Tile.scala 124:19]
  wire [31:0] arb_io_dcache_aw_bits_addr; // @[Tile.scala 124:19]
  wire  arb_io_dcache_w_ready; // @[Tile.scala 124:19]
  wire  arb_io_dcache_w_valid; // @[Tile.scala 124:19]
  wire [63:0] arb_io_dcache_w_bits_data; // @[Tile.scala 124:19]
  wire  arb_io_dcache_w_bits_last; // @[Tile.scala 124:19]
  wire  arb_io_dcache_b_ready; // @[Tile.scala 124:19]
  wire  arb_io_dcache_b_valid; // @[Tile.scala 124:19]
  wire  arb_io_dcache_ar_ready; // @[Tile.scala 124:19]
  wire  arb_io_dcache_ar_valid; // @[Tile.scala 124:19]
  wire [31:0] arb_io_dcache_ar_bits_addr; // @[Tile.scala 124:19]
  wire  arb_io_dcache_r_ready; // @[Tile.scala 124:19]
  wire  arb_io_dcache_r_valid; // @[Tile.scala 124:19]
  wire [63:0] arb_io_dcache_r_bits_data; // @[Tile.scala 124:19]
  wire  arb_io_nasti_aw_ready; // @[Tile.scala 124:19]
  wire  arb_io_nasti_aw_valid; // @[Tile.scala 124:19]
  wire [31:0] arb_io_nasti_aw_bits_addr; // @[Tile.scala 124:19]
  wire  arb_io_nasti_w_ready; // @[Tile.scala 124:19]
  wire  arb_io_nasti_w_valid; // @[Tile.scala 124:19]
  wire [63:0] arb_io_nasti_w_bits_data; // @[Tile.scala 124:19]
  wire  arb_io_nasti_b_ready; // @[Tile.scala 124:19]
  wire  arb_io_nasti_b_valid; // @[Tile.scala 124:19]
  wire  arb_io_nasti_ar_ready; // @[Tile.scala 124:19]
  wire  arb_io_nasti_ar_valid; // @[Tile.scala 124:19]
  wire [31:0] arb_io_nasti_ar_bits_addr; // @[Tile.scala 124:19]
  wire  arb_io_nasti_r_ready; // @[Tile.scala 124:19]
  wire  arb_io_nasti_r_valid; // @[Tile.scala 124:19]
  wire [63:0] arb_io_nasti_r_bits_data; // @[Tile.scala 124:19]
  wire  selector_clock; // @[Tile.scala 125:24]
  wire  selector_reset; // @[Tile.scala 125:24]
  wire  selector_io_cpu_abort; // @[Tile.scala 125:24]
  wire  selector_io_cpu_req_valid; // @[Tile.scala 125:24]
  wire [31:0] selector_io_cpu_req_bits_addr; // @[Tile.scala 125:24]
  wire [31:0] selector_io_cpu_req_bits_data; // @[Tile.scala 125:24]
  wire [3:0] selector_io_cpu_req_bits_mask; // @[Tile.scala 125:24]
  wire  selector_io_cpu_resp_valid; // @[Tile.scala 125:24]
  wire [31:0] selector_io_cpu_resp_bits_data; // @[Tile.scala 125:24]
  wire  selector_io_dcache_abort; // @[Tile.scala 125:24]
  wire  selector_io_dcache_req_valid; // @[Tile.scala 125:24]
  wire [31:0] selector_io_dcache_req_bits_addr; // @[Tile.scala 125:24]
  wire [31:0] selector_io_dcache_req_bits_data; // @[Tile.scala 125:24]
  wire [3:0] selector_io_dcache_req_bits_mask; // @[Tile.scala 125:24]
  wire  selector_io_dcache_resp_valid; // @[Tile.scala 125:24]
  wire [31:0] selector_io_dcache_resp_bits_data; // @[Tile.scala 125:24]
  wire  selector_io_device_req_valid; // @[Tile.scala 125:24]
  wire [31:0] selector_io_device_req_bits_addr; // @[Tile.scala 125:24]
  wire [31:0] selector_io_device_req_bits_data; // @[Tile.scala 125:24]
  wire  selector_io_device_resp_valid; // @[Tile.scala 125:24]
  wire [31:0] selector_io_device_resp_bits_data; // @[Tile.scala 125:24]
  wire  uart_clock; // @[Tile.scala 126:20]
  wire  uart_reset; // @[Tile.scala 126:20]
  wire  uart_io_rxd; // @[Tile.scala 126:20]
  wire  uart_io_txd; // @[Tile.scala 126:20]
  wire  uart_io_rxChannel_ready; // @[Tile.scala 126:20]
  wire  uart_io_rxChannel_valid; // @[Tile.scala 126:20]
  wire [7:0] uart_io_rxChannel_bits; // @[Tile.scala 126:20]
  wire  uart_io_txChannel_ready; // @[Tile.scala 126:20]
  wire  uart_io_txChannel_valid; // @[Tile.scala 126:20]
  wire [7:0] uart_io_txChannel_bits; // @[Tile.scala 126:20]
  wire  uartCtrl_clock; // @[Tile.scala 127:24]
  wire  uartCtrl_reset; // @[Tile.scala 127:24]
  wire  uartCtrl_io_cpu_req_valid; // @[Tile.scala 127:24]
  wire [31:0] uartCtrl_io_cpu_req_bits_addr; // @[Tile.scala 127:24]
  wire [31:0] uartCtrl_io_cpu_req_bits_data; // @[Tile.scala 127:24]
  wire  uartCtrl_io_cpu_resp_valid; // @[Tile.scala 127:24]
  wire [31:0] uartCtrl_io_cpu_resp_bits_data; // @[Tile.scala 127:24]
  wire  uartCtrl_io_rxChannel_ready; // @[Tile.scala 127:24]
  wire  uartCtrl_io_rxChannel_valid; // @[Tile.scala 127:24]
  wire [7:0] uartCtrl_io_rxChannel_bits; // @[Tile.scala 127:24]
  wire  uartCtrl_io_txChannel_ready; // @[Tile.scala 127:24]
  wire  uartCtrl_io_txChannel_valid; // @[Tile.scala 127:24]
  wire [7:0] uartCtrl_io_txChannel_bits; // @[Tile.scala 127:24]
  wire  bram_clka; // @[Tile.scala 128:20]
  wire  bram_ena; // @[Tile.scala 128:20]
  wire  bram_wea; // @[Tile.scala 128:20]
  wire [11:0] bram_addra; // @[Tile.scala 128:20]
  wire [63:0] bram_dina; // @[Tile.scala 128:20]
  wire [63:0] bram_douta; // @[Tile.scala 128:20]
  wire  bramCtrl_clock; // @[Tile.scala 129:24]
  wire  bramCtrl_reset; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_aw_ready; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_aw_valid; // @[Tile.scala 129:24]
  wire [31:0] bramCtrl_io_nasti_aw_bits_addr; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_w_ready; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_w_valid; // @[Tile.scala 129:24]
  wire [63:0] bramCtrl_io_nasti_w_bits_data; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_b_ready; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_b_valid; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_ar_ready; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_ar_valid; // @[Tile.scala 129:24]
  wire [31:0] bramCtrl_io_nasti_ar_bits_addr; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_r_ready; // @[Tile.scala 129:24]
  wire  bramCtrl_io_nasti_r_valid; // @[Tile.scala 129:24]
  wire [63:0] bramCtrl_io_nasti_r_bits_data; // @[Tile.scala 129:24]
  wire  bramCtrl_io_bport_clka; // @[Tile.scala 129:24]
  wire  bramCtrl_io_bport_ena; // @[Tile.scala 129:24]
  wire  bramCtrl_io_bport_wea; // @[Tile.scala 129:24]
  wire [11:0] bramCtrl_io_bport_addra; // @[Tile.scala 129:24]
  wire [63:0] bramCtrl_io_bport_dina; // @[Tile.scala 129:24]
  wire [63:0] bramCtrl_io_bport_douta; // @[Tile.scala 129:24]
  wire  clk_wiz_clk_out1; // @[Tile.scala 130:23]
  wire  clk_wiz_reset; // @[Tile.scala 130:23]
  wire  clk_wiz_clk_in1; // @[Tile.scala 130:23]
  Core core ( // @[Tile.scala 121:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_icache_req_valid(core_io_icache_req_valid),
    .io_icache_req_bits_addr(core_io_icache_req_bits_addr),
    .io_icache_resp_valid(core_io_icache_resp_valid),
    .io_icache_resp_bits_data(core_io_icache_resp_bits_data),
    .io_dcache_abort(core_io_dcache_abort),
    .io_dcache_req_valid(core_io_dcache_req_valid),
    .io_dcache_req_bits_addr(core_io_dcache_req_bits_addr),
    .io_dcache_req_bits_data(core_io_dcache_req_bits_data),
    .io_dcache_req_bits_mask(core_io_dcache_req_bits_mask),
    .io_dcache_resp_valid(core_io_dcache_resp_valid),
    .io_dcache_resp_bits_data(core_io_dcache_resp_bits_data)
  );
  Cache icache ( // @[Tile.scala 122:22]
    .clock(icache_clock),
    .reset(icache_reset),
    .io_cpu_abort(icache_io_cpu_abort),
    .io_cpu_req_valid(icache_io_cpu_req_valid),
    .io_cpu_req_bits_addr(icache_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(icache_io_cpu_req_bits_data),
    .io_cpu_req_bits_mask(icache_io_cpu_req_bits_mask),
    .io_cpu_resp_valid(icache_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(icache_io_cpu_resp_bits_data),
    .io_nasti_aw_ready(icache_io_nasti_aw_ready),
    .io_nasti_aw_valid(icache_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(icache_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(icache_io_nasti_w_ready),
    .io_nasti_w_valid(icache_io_nasti_w_valid),
    .io_nasti_w_bits_data(icache_io_nasti_w_bits_data),
    .io_nasti_w_bits_last(icache_io_nasti_w_bits_last),
    .io_nasti_b_ready(icache_io_nasti_b_ready),
    .io_nasti_b_valid(icache_io_nasti_b_valid),
    .io_nasti_ar_ready(icache_io_nasti_ar_ready),
    .io_nasti_ar_valid(icache_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(icache_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(icache_io_nasti_r_ready),
    .io_nasti_r_valid(icache_io_nasti_r_valid),
    .io_nasti_r_bits_data(icache_io_nasti_r_bits_data)
  );
  Cache dcache ( // @[Tile.scala 123:22]
    .clock(dcache_clock),
    .reset(dcache_reset),
    .io_cpu_abort(dcache_io_cpu_abort),
    .io_cpu_req_valid(dcache_io_cpu_req_valid),
    .io_cpu_req_bits_addr(dcache_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(dcache_io_cpu_req_bits_data),
    .io_cpu_req_bits_mask(dcache_io_cpu_req_bits_mask),
    .io_cpu_resp_valid(dcache_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(dcache_io_cpu_resp_bits_data),
    .io_nasti_aw_ready(dcache_io_nasti_aw_ready),
    .io_nasti_aw_valid(dcache_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(dcache_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(dcache_io_nasti_w_ready),
    .io_nasti_w_valid(dcache_io_nasti_w_valid),
    .io_nasti_w_bits_data(dcache_io_nasti_w_bits_data),
    .io_nasti_w_bits_last(dcache_io_nasti_w_bits_last),
    .io_nasti_b_ready(dcache_io_nasti_b_ready),
    .io_nasti_b_valid(dcache_io_nasti_b_valid),
    .io_nasti_ar_ready(dcache_io_nasti_ar_ready),
    .io_nasti_ar_valid(dcache_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(dcache_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(dcache_io_nasti_r_ready),
    .io_nasti_r_valid(dcache_io_nasti_r_valid),
    .io_nasti_r_bits_data(dcache_io_nasti_r_bits_data)
  );
  MemArbiter arb ( // @[Tile.scala 124:19]
    .clock(arb_clock),
    .reset(arb_reset),
    .io_icache_ar_ready(arb_io_icache_ar_ready),
    .io_icache_ar_valid(arb_io_icache_ar_valid),
    .io_icache_ar_bits_addr(arb_io_icache_ar_bits_addr),
    .io_icache_r_ready(arb_io_icache_r_ready),
    .io_icache_r_valid(arb_io_icache_r_valid),
    .io_icache_r_bits_data(arb_io_icache_r_bits_data),
    .io_dcache_aw_ready(arb_io_dcache_aw_ready),
    .io_dcache_aw_valid(arb_io_dcache_aw_valid),
    .io_dcache_aw_bits_addr(arb_io_dcache_aw_bits_addr),
    .io_dcache_w_ready(arb_io_dcache_w_ready),
    .io_dcache_w_valid(arb_io_dcache_w_valid),
    .io_dcache_w_bits_data(arb_io_dcache_w_bits_data),
    .io_dcache_w_bits_last(arb_io_dcache_w_bits_last),
    .io_dcache_b_ready(arb_io_dcache_b_ready),
    .io_dcache_b_valid(arb_io_dcache_b_valid),
    .io_dcache_ar_ready(arb_io_dcache_ar_ready),
    .io_dcache_ar_valid(arb_io_dcache_ar_valid),
    .io_dcache_ar_bits_addr(arb_io_dcache_ar_bits_addr),
    .io_dcache_r_ready(arb_io_dcache_r_ready),
    .io_dcache_r_valid(arb_io_dcache_r_valid),
    .io_dcache_r_bits_data(arb_io_dcache_r_bits_data),
    .io_nasti_aw_ready(arb_io_nasti_aw_ready),
    .io_nasti_aw_valid(arb_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(arb_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(arb_io_nasti_w_ready),
    .io_nasti_w_valid(arb_io_nasti_w_valid),
    .io_nasti_w_bits_data(arb_io_nasti_w_bits_data),
    .io_nasti_b_ready(arb_io_nasti_b_ready),
    .io_nasti_b_valid(arb_io_nasti_b_valid),
    .io_nasti_ar_ready(arb_io_nasti_ar_ready),
    .io_nasti_ar_valid(arb_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(arb_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(arb_io_nasti_r_ready),
    .io_nasti_r_valid(arb_io_nasti_r_valid),
    .io_nasti_r_bits_data(arb_io_nasti_r_bits_data)
  );
  Selector selector ( // @[Tile.scala 125:24]
    .clock(selector_clock),
    .reset(selector_reset),
    .io_cpu_abort(selector_io_cpu_abort),
    .io_cpu_req_valid(selector_io_cpu_req_valid),
    .io_cpu_req_bits_addr(selector_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(selector_io_cpu_req_bits_data),
    .io_cpu_req_bits_mask(selector_io_cpu_req_bits_mask),
    .io_cpu_resp_valid(selector_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(selector_io_cpu_resp_bits_data),
    .io_dcache_abort(selector_io_dcache_abort),
    .io_dcache_req_valid(selector_io_dcache_req_valid),
    .io_dcache_req_bits_addr(selector_io_dcache_req_bits_addr),
    .io_dcache_req_bits_data(selector_io_dcache_req_bits_data),
    .io_dcache_req_bits_mask(selector_io_dcache_req_bits_mask),
    .io_dcache_resp_valid(selector_io_dcache_resp_valid),
    .io_dcache_resp_bits_data(selector_io_dcache_resp_bits_data),
    .io_device_req_valid(selector_io_device_req_valid),
    .io_device_req_bits_addr(selector_io_device_req_bits_addr),
    .io_device_req_bits_data(selector_io_device_req_bits_data),
    .io_device_resp_valid(selector_io_device_resp_valid),
    .io_device_resp_bits_data(selector_io_device_resp_bits_data)
  );
  Uart uart ( // @[Tile.scala 126:20]
    .clock(uart_clock),
    .reset(uart_reset),
    .io_rxd(uart_io_rxd),
    .io_txd(uart_io_txd),
    .io_rxChannel_ready(uart_io_rxChannel_ready),
    .io_rxChannel_valid(uart_io_rxChannel_valid),
    .io_rxChannel_bits(uart_io_rxChannel_bits),
    .io_txChannel_ready(uart_io_txChannel_ready),
    .io_txChannel_valid(uart_io_txChannel_valid),
    .io_txChannel_bits(uart_io_txChannel_bits)
  );
  UartController uartCtrl ( // @[Tile.scala 127:24]
    .clock(uartCtrl_clock),
    .reset(uartCtrl_reset),
    .io_cpu_req_valid(uartCtrl_io_cpu_req_valid),
    .io_cpu_req_bits_addr(uartCtrl_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(uartCtrl_io_cpu_req_bits_data),
    .io_cpu_resp_valid(uartCtrl_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(uartCtrl_io_cpu_resp_bits_data),
    .io_rxChannel_ready(uartCtrl_io_rxChannel_ready),
    .io_rxChannel_valid(uartCtrl_io_rxChannel_valid),
    .io_rxChannel_bits(uartCtrl_io_rxChannel_bits),
    .io_txChannel_ready(uartCtrl_io_txChannel_ready),
    .io_txChannel_valid(uartCtrl_io_txChannel_valid),
    .io_txChannel_bits(uartCtrl_io_txChannel_bits)
  );
  BRAM bram ( // @[Tile.scala 128:20]
    .clka(bram_clka),
    .ena(bram_ena),
    .wea(bram_wea),
    .addra(bram_addra),
    .dina(bram_dina),
    .douta(bram_douta)
  );
  BRAMController bramCtrl ( // @[Tile.scala 129:24]
    .clock(bramCtrl_clock),
    .reset(bramCtrl_reset),
    .io_nasti_aw_ready(bramCtrl_io_nasti_aw_ready),
    .io_nasti_aw_valid(bramCtrl_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(bramCtrl_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(bramCtrl_io_nasti_w_ready),
    .io_nasti_w_valid(bramCtrl_io_nasti_w_valid),
    .io_nasti_w_bits_data(bramCtrl_io_nasti_w_bits_data),
    .io_nasti_b_ready(bramCtrl_io_nasti_b_ready),
    .io_nasti_b_valid(bramCtrl_io_nasti_b_valid),
    .io_nasti_ar_ready(bramCtrl_io_nasti_ar_ready),
    .io_nasti_ar_valid(bramCtrl_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(bramCtrl_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(bramCtrl_io_nasti_r_ready),
    .io_nasti_r_valid(bramCtrl_io_nasti_r_valid),
    .io_nasti_r_bits_data(bramCtrl_io_nasti_r_bits_data),
    .io_bport_clka(bramCtrl_io_bport_clka),
    .io_bport_ena(bramCtrl_io_bport_ena),
    .io_bport_wea(bramCtrl_io_bport_wea),
    .io_bport_addra(bramCtrl_io_bport_addra),
    .io_bport_dina(bramCtrl_io_bport_dina),
    .io_bport_douta(bramCtrl_io_bport_douta)
  );
  CLKWIZ clk_wiz ( // @[Tile.scala 130:23]
    .clk_out1(clk_wiz_clk_out1),
    .reset(clk_wiz_reset),
    .clk_in1(clk_wiz_clk_in1)
  );
  assign io_txd = uart_io_txd; // @[Tile.scala 159:15]
  assign core_clock = clk_wiz_clk_out1; // @[Tile.scala 136:14]
  assign core_reset = reset;
  assign core_io_icache_resp_valid = icache_io_cpu_resp_valid; // @[Tile.scala 148:18]
  assign core_io_icache_resp_bits_data = icache_io_cpu_resp_bits_data; // @[Tile.scala 148:18]
  assign core_io_dcache_resp_valid = selector_io_cpu_resp_valid; // @[Tile.scala 151:18]
  assign core_io_dcache_resp_bits_data = selector_io_cpu_resp_bits_data; // @[Tile.scala 151:18]
  assign icache_clock = clk_wiz_clk_out1; // @[Tile.scala 137:16]
  assign icache_reset = reset;
  assign icache_io_cpu_abort = 1'h0; // @[Tile.scala 148:18]
  assign icache_io_cpu_req_valid = core_io_icache_req_valid; // @[Tile.scala 148:18]
  assign icache_io_cpu_req_bits_addr = core_io_icache_req_bits_addr; // @[Tile.scala 148:18]
  assign icache_io_cpu_req_bits_data = 32'h0; // @[Tile.scala 148:18]
  assign icache_io_cpu_req_bits_mask = 4'h0; // @[Tile.scala 148:18]
  assign icache_io_nasti_aw_ready = 1'h0; // @[Tile.scala 162:17]
  assign icache_io_nasti_w_ready = 1'h0; // @[Tile.scala 162:17]
  assign icache_io_nasti_b_valid = 1'h0; // @[Tile.scala 162:17]
  assign icache_io_nasti_ar_ready = arb_io_icache_ar_ready; // @[Tile.scala 162:17]
  assign icache_io_nasti_r_valid = arb_io_icache_r_valid; // @[Tile.scala 162:17]
  assign icache_io_nasti_r_bits_data = arb_io_icache_r_bits_data; // @[Tile.scala 162:17]
  assign dcache_clock = clk_wiz_clk_out1; // @[Tile.scala 138:16]
  assign dcache_reset = reset;
  assign dcache_io_cpu_abort = selector_io_dcache_abort; // @[Tile.scala 153:22]
  assign dcache_io_cpu_req_valid = selector_io_dcache_req_valid; // @[Tile.scala 153:22]
  assign dcache_io_cpu_req_bits_addr = selector_io_dcache_req_bits_addr; // @[Tile.scala 153:22]
  assign dcache_io_cpu_req_bits_data = selector_io_dcache_req_bits_data; // @[Tile.scala 153:22]
  assign dcache_io_cpu_req_bits_mask = selector_io_dcache_req_bits_mask; // @[Tile.scala 153:22]
  assign dcache_io_nasti_aw_ready = arb_io_dcache_aw_ready; // @[Tile.scala 163:17]
  assign dcache_io_nasti_w_ready = arb_io_dcache_w_ready; // @[Tile.scala 163:17]
  assign dcache_io_nasti_b_valid = arb_io_dcache_b_valid; // @[Tile.scala 163:17]
  assign dcache_io_nasti_ar_ready = arb_io_dcache_ar_ready; // @[Tile.scala 163:17]
  assign dcache_io_nasti_r_valid = arb_io_dcache_r_valid; // @[Tile.scala 163:17]
  assign dcache_io_nasti_r_bits_data = arb_io_dcache_r_bits_data; // @[Tile.scala 163:17]
  assign arb_clock = clk_wiz_clk_out1; // @[Tile.scala 139:13]
  assign arb_reset = reset;
  assign arb_io_icache_ar_valid = icache_io_nasti_ar_valid; // @[Tile.scala 162:17]
  assign arb_io_icache_ar_bits_addr = icache_io_nasti_ar_bits_addr; // @[Tile.scala 162:17]
  assign arb_io_icache_r_ready = icache_io_nasti_r_ready; // @[Tile.scala 162:17]
  assign arb_io_dcache_aw_valid = dcache_io_nasti_aw_valid; // @[Tile.scala 163:17]
  assign arb_io_dcache_aw_bits_addr = dcache_io_nasti_aw_bits_addr; // @[Tile.scala 163:17]
  assign arb_io_dcache_w_valid = dcache_io_nasti_w_valid; // @[Tile.scala 163:17]
  assign arb_io_dcache_w_bits_data = dcache_io_nasti_w_bits_data; // @[Tile.scala 163:17]
  assign arb_io_dcache_w_bits_last = dcache_io_nasti_w_bits_last; // @[Tile.scala 163:17]
  assign arb_io_dcache_b_ready = dcache_io_nasti_b_ready; // @[Tile.scala 163:17]
  assign arb_io_dcache_ar_valid = dcache_io_nasti_ar_valid; // @[Tile.scala 163:17]
  assign arb_io_dcache_ar_bits_addr = dcache_io_nasti_ar_bits_addr; // @[Tile.scala 163:17]
  assign arb_io_dcache_r_ready = dcache_io_nasti_r_ready; // @[Tile.scala 163:17]
  assign arb_io_nasti_aw_ready = bramCtrl_io_nasti_aw_ready; // @[Tile.scala 166:21]
  assign arb_io_nasti_w_ready = bramCtrl_io_nasti_w_ready; // @[Tile.scala 166:21]
  assign arb_io_nasti_b_valid = bramCtrl_io_nasti_b_valid; // @[Tile.scala 166:21]
  assign arb_io_nasti_ar_ready = bramCtrl_io_nasti_ar_ready; // @[Tile.scala 166:21]
  assign arb_io_nasti_r_valid = bramCtrl_io_nasti_r_valid; // @[Tile.scala 166:21]
  assign arb_io_nasti_r_bits_data = bramCtrl_io_nasti_r_bits_data; // @[Tile.scala 166:21]
  assign selector_clock = clk_wiz_clk_out1; // @[Tile.scala 140:18]
  assign selector_reset = reset;
  assign selector_io_cpu_abort = core_io_dcache_abort; // @[Tile.scala 151:18]
  assign selector_io_cpu_req_valid = core_io_dcache_req_valid; // @[Tile.scala 151:18]
  assign selector_io_cpu_req_bits_addr = core_io_dcache_req_bits_addr; // @[Tile.scala 151:18]
  assign selector_io_cpu_req_bits_data = core_io_dcache_req_bits_data; // @[Tile.scala 151:18]
  assign selector_io_cpu_req_bits_mask = core_io_dcache_req_bits_mask; // @[Tile.scala 151:18]
  assign selector_io_dcache_resp_valid = dcache_io_cpu_resp_valid; // @[Tile.scala 153:22]
  assign selector_io_dcache_resp_bits_data = dcache_io_cpu_resp_bits_data; // @[Tile.scala 153:22]
  assign selector_io_device_resp_valid = uartCtrl_io_cpu_resp_valid; // @[Tile.scala 152:22]
  assign selector_io_device_resp_bits_data = uartCtrl_io_cpu_resp_bits_data; // @[Tile.scala 152:22]
  assign uart_clock = clk_wiz_clk_out1; // @[Tile.scala 141:14]
  assign uart_reset = reset;
  assign uart_io_rxd = io_rxd; // @[Tile.scala 158:15]
  assign uart_io_rxChannel_ready = uartCtrl_io_rxChannel_ready; // @[Tile.scala 156:25]
  assign uart_io_txChannel_valid = uartCtrl_io_txChannel_valid; // @[Tile.scala 157:25]
  assign uart_io_txChannel_bits = uartCtrl_io_txChannel_bits; // @[Tile.scala 157:25]
  assign uartCtrl_clock = clk_wiz_clk_out1; // @[Tile.scala 142:18]
  assign uartCtrl_reset = reset;
  assign uartCtrl_io_cpu_req_valid = selector_io_device_req_valid; // @[Tile.scala 152:22]
  assign uartCtrl_io_cpu_req_bits_addr = selector_io_device_req_bits_addr; // @[Tile.scala 152:22]
  assign uartCtrl_io_cpu_req_bits_data = selector_io_device_req_bits_data; // @[Tile.scala 152:22]
  assign uartCtrl_io_rxChannel_valid = uart_io_rxChannel_valid; // @[Tile.scala 156:25]
  assign uartCtrl_io_rxChannel_bits = uart_io_rxChannel_bits; // @[Tile.scala 156:25]
  assign uartCtrl_io_txChannel_ready = uart_io_txChannel_ready; // @[Tile.scala 157:25]
  assign bram_clka = bramCtrl_io_bport_clka; // @[Tile.scala 167:11]
  assign bram_ena = bramCtrl_io_bport_ena; // @[Tile.scala 167:11]
  assign bram_wea = bramCtrl_io_bport_wea; // @[Tile.scala 167:11]
  assign bram_addra = bramCtrl_io_bport_addra; // @[Tile.scala 167:11]
  assign bram_dina = bramCtrl_io_bport_dina; // @[Tile.scala 167:11]
  assign bramCtrl_clock = clk_wiz_clk_out1; // @[Tile.scala 143:18]
  assign bramCtrl_reset = reset;
  assign bramCtrl_io_nasti_aw_valid = arb_io_nasti_aw_valid; // @[Tile.scala 166:21]
  assign bramCtrl_io_nasti_aw_bits_addr = arb_io_nasti_aw_bits_addr; // @[Tile.scala 166:21]
  assign bramCtrl_io_nasti_w_valid = arb_io_nasti_w_valid; // @[Tile.scala 166:21]
  assign bramCtrl_io_nasti_w_bits_data = arb_io_nasti_w_bits_data; // @[Tile.scala 166:21]
  assign bramCtrl_io_nasti_b_ready = arb_io_nasti_b_ready; // @[Tile.scala 166:21]
  assign bramCtrl_io_nasti_ar_valid = arb_io_nasti_ar_valid; // @[Tile.scala 166:21]
  assign bramCtrl_io_nasti_ar_bits_addr = arb_io_nasti_ar_bits_addr; // @[Tile.scala 166:21]
  assign bramCtrl_io_nasti_r_ready = arb_io_nasti_r_ready; // @[Tile.scala 166:21]
  assign bramCtrl_io_bport_douta = bram_douta; // @[Tile.scala 167:11]
  assign clk_wiz_reset = reset; // @[Tile.scala 134:20]
  assign clk_wiz_clk_in1 = clock; // @[Tile.scala 133:22]
endmodule
