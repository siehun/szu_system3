package com.yue

import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3._

class DecoderTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Decoder"
  it should "correctly decode instructions" in {
    test(new Decoder).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      // Test instructions
      val addInstruction = "b000000_00010_00011_00001_00000_100000".U
      val subInstruction = "b000000_00101_00110_00000_00000_100010".U
      val lwInstruction = "b100011_00010_00101_0000000001100100".U
      val swInstruction = "b101011_00010_00101_0000000001101000".U
      val jalInstruction = "b000011_00000_00000000000000000000".U
      // Set the input instruction and evaluate the decoder
      c.io.Instr_word.poke(addInstruction)
      c.clock.step()
      c.io.add_op.expect(true)
      c.io.sub_op.expect(false)
      c.io.lw_op.expect(false)
      c.io.sw_op.expect(false)
      c.io.nop_op.expect(false)

      c.io.Instr_word.poke(subInstruction)
      c.clock.step()
      c.io.add_op.expect(false)
      c.io.sub_op.expect(true)
      c.io.lw_op.expect(false)
      c.io.sw_op.expect(false)
      c.io.nop_op.expect(false)

      c.io.Instr_word.poke(lwInstruction)
      c.clock.step()
      c.io.add_op.expect(false)
      c.io.sub_op.expect(false)
      c.io.lw_op.expect(true)
      c.io.sw_op.expect(false)
      c.io.nop_op.expect(false)

      c.io.Instr_word.poke(swInstruction)
      c.clock.step()
      c.io.add_op.expect(false)
      c.io.sub_op.expect(false)
      c.io.lw_op.expect(false)
      c.io.sw_op.expect(true)
      c.io.nop_op.expect(false)

      c.io.Instr_word.poke(jalInstruction)
      c.clock.step()
      c.io.add_op.expect(false)
      c.io.sub_op.expect(false)
      c.io.lw_op.expect(false)
      c.io.sw_op.expect(false)
      c.io.nop_op.expect(true)
    }
  }
}

