package com.yue

import chisel3._
import chisel3.util._

class RegisterFile extends Module {
  val io = IO(new Bundle {
    val RS1 = Input(UInt(5.W)) // RS1输入信号，用于选择要读取的寄存器
    val RS2 = Input(UInt(5.W)) // RS2输入信号，用于选择要读取的寄存器
    val WB_data = Input(UInt(32.W)) // 写入数据信号，用于写入寄存器
    val Reg_WB = Input(UInt(5.W)) // 选择写入数据的寄存器
    val RS1_out = Output(UInt(32.W)) // RS1输出数据
    val RS2_out = Output(UInt(32.W)) // RS2输出数据
  })

  val registers = RegInit(VecInit((0 until 32).map(_.U(32.W)))) // 32个32位寄存器，初始值等于寄存器编号
  registers(io.Reg_WB) := io.WB_data // 写入数据到寄存器
  io.RS1_out := Mux(io.RS1 === 0.U, 0.U, registers(io.RS1)) // RS1输出数据，0号寄存器固定读出位0
  io.RS2_out := Mux(io.RS2 === 0.U, 0.U, registers(io.RS2)) // RS2输出数据，0号寄存器固定读出位0
}

object RegisterFile extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new RegisterFile())
}
