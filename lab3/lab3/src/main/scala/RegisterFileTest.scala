package com.yue
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.util._

class RegisterFileTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "RegisterFile"
  it should "correctly update and read registers" in {
    test(new RegisterFile).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      // 设置输入信号
      c.io.RS1.poke(5.U)
      c.io.RS2.poke(8.U)
      c.io.WB_data.poke(0x1234.U)
      c.io.Reg_WB.poke(1.U)

      c.clock.step()
      c.io.RS1_out.expect(5.U)
      c.io.RS2_out.expect(8.U)
    }
  }
}

