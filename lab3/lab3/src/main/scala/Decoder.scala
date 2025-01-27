import chisel3._

class Decoder extends Module {
  val io = IO(new Bundle {
    val Instr_word = Input(UInt(32.W))
    val add_op = Output(Bool())
    val sub_op = Output(Bool())
    val lw_op = Output(Bool())
    val sw_op = Output(Bool())
    val nop_op = Output(Bool())
  })
  // 定义操作码
  val OPCODE_ADD = "b000000".U
  val OPCODE_SUB = "b000000".U
  val OPCODE_LW = "b100011".U
  val OPCODE_SW = "b101011".U
  //定义功能码
  val FUNCT_ADD = "b100000".U
  val FUNCT_SUB = "b100010".U
  // 提取MIPS指令的操作码
  val opcode = io.Instr_word(31, 26)
  //提取MIPS指令的功能码
  val funct = io.Instr_word(5, 0)
  // 译码
  io.add_op := opcode === OPCODE_ADD && funct === FUNCT_ADD
  io.sub_op := opcode === OPCODE_SUB && funct === FUNCT_SUB
  io.lw_op := opcode === OPCODE_LW
  io.sw_op := opcode === OPCODE_SW
  io.nop_op := !(io.add_op || io.sub_op || io.lw_op || io.sw_op)
}

object Decoder extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Decoder())
}