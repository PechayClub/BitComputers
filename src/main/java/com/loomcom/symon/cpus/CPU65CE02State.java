/*
 * Copyright (c) 2016 Seth J. Morabito <web@loomcom.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.loomcom.symon.cpus;

import com.loomcom.symon.CPUState;
import com.loomcom.symon.util.Utils;

/**
 * A compact, struct-like representation of CPU state.
 */
public class CPU65CE02State extends CPUState {
	/**
	 * Accumulator
	 */
	public int a;

	/**
	 * Base Page
	 */
	public int b;

	/**
	 * X index regsiter
	 */
	public int x;

	/**
	 * Y index register
	 */
	public int y;

	/**
	 * Z index register
	 */
	public int z;

	/**
	 * Stack Pointer
	 */
	public int sp;

	/**
	 * Program Counter
	 */
	public int pc;

	/**
	 * Last Loaded Instruction Register
	 */
	public int ir;

	/**
	 * Last Loaded Instruction Arguments
	 */
	public int[] args = new int[2];

	public int instSize;
	public boolean irqAsserted;
	public boolean nmiAsserted;
	public int lastPc;

	/* Status Flag Register bits */
	public boolean carryFlag;
	public boolean zeroFlag;
	public boolean irqDisableFlag;
	public boolean decimalModeFlag;
	public boolean breakFlag;
	public boolean extendFlag;
	public boolean overflowFlag;
	public boolean negativeFlag;

	// Processor lockup
	public boolean dead = false;

	// Processor sleep
	public boolean sleep = false;

	/**
	 * Returns a string formatted for the trace log.
	 *
	 * @return a string formatted for the trace log.
	 */
	public String toTraceEvent() {
		String opcode = CPU65CE02.disassembleOp(ir, args);
		return getInstructionByteStatus() + "  " + String.format("%-14s", opcode) + "A:" + Utils.byteToHex(a) + " " + "B:" + Utils.byteToHex(b) + " "  + "X:" + Utils.byteToHex(x) + " " + "Y:" + Utils.byteToHex(y) + "Z:" + " " + Utils.byteToHex(z) + " " + "F:" + Utils.byteToHex(getStatusFlag()) + " " + "S:1" + Utils.byteToHex(sp) + " " + getProcessorStatusString();
	}

	/**
	 * @return The value of the Process Status Register, as a byte.
	 */
	public int getStatusFlag() {
		int status = 0x00;
		if (carryFlag) {
			status |= CPU65CE02.P_CARRY;
		}
		if (zeroFlag) {
			status |= CPU65CE02.P_ZERO;
		}
		if (irqDisableFlag) {
			status |= CPU65CE02.P_IRQ_DISABLE;
		}
		if (decimalModeFlag) {
			status |= CPU65CE02.P_DECIMAL;
		}
		if (breakFlag) {
			status |= CPU65CE02.P_BREAK;
		}
		if (extendFlag) {
			status |= CPU65CE02.P_EXTEND;
		}
		if (overflowFlag) {
			status |= CPU65CE02.P_OVERFLOW;
		}
		if (negativeFlag) {
			status |= CPU65CE02.P_NEGATIVE;
		}
		return status;
	}

	public String getInstructionByteStatus() {
		switch (InstructionTable65CE02.instructionModes[ir].getLength()) {
		case 0:
		case 1:
			return Utils.wordToHex(lastPc) + "  " + Utils.byteToHex(ir) + "      ";
		case 2:
			return Utils.wordToHex(lastPc) + "  " + Utils.byteToHex(ir) + " " + Utils.byteToHex(args[0]) + "   ";
		case 3:
			return Utils.wordToHex(lastPc) + "  " + Utils.byteToHex(ir) + " " + Utils.byteToHex(args[0]) + " " + Utils.byteToHex(args[1]);
		default:
			return null;
		}
	}

	/**
	 * @return A string representing the current status register state.
	 */
	public String getProcessorStatusString() {
		return "[" + (negativeFlag ? 'N' : '.') + (overflowFlag ? 'V' : '.') + "-" + (extendFlag ? 'E' : '.') + "-" + (breakFlag ? 'B' : '.') + (decimalModeFlag ? 'D' : '.') + (irqDisableFlag ? 'I' : '.') + (zeroFlag ? 'Z' : '.') + (carryFlag ? 'C' : '.') + "]";
	}
}
