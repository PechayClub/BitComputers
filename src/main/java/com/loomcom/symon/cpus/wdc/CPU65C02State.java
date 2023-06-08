package com.loomcom.symon.cpus.wdc;

import com.loomcom.symon.CPUState;
import com.loomcom.symon.util.Utils;

public class CPU65C02State extends CPUState {
    /**
     * Accumulator
     */
    public int a;

    /**
     * X index regsiter
     */
    public int x;

    /**
     * Y index register
     */
    public int y;

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
        String opcode = CPU65C02.disassembleOp(ir, args);
        return getInstructionByteStatus() + "  " + String.format("%-14s", opcode) + "A:" + Utils.byteToHex(a) + " " + "X:" + Utils.byteToHex(x) + " " + "Y:" + Utils.byteToHex(y) +  " " + "F:" + Utils.byteToHex(getStatusFlag()) + " " + "S:1" + Utils.byteToHex(sp) + " " + getProcessorStatusString();
    }

    /**
     * @return The value of the Process Status Register, as a byte.
     */
    public int getStatusFlag() {
        int status = 0x00;
        if (carryFlag) {
            status |= CPU65C02.P_CARRY;
        }
        if (zeroFlag) {
            status |= CPU65C02.P_ZERO;
        }
        if (irqDisableFlag) {
            status |= CPU65C02.P_IRQ_DISABLE;
        }
        if (decimalModeFlag) {
            status |= CPU65C02.P_DECIMAL;
        }
        if (breakFlag) {
            status |= CPU65C02.P_BREAK;
        }
        if (overflowFlag) {
            status |= CPU65C02.P_OVERFLOW;
        }
        if (negativeFlag) {
            status |= CPU65C02.P_NEGATIVE;
        }
        return status;
    }

    public String getInstructionByteStatus() {
        switch (InstructionTable65C02.instructionModes[ir].getLength()) {
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
        return "[" + (negativeFlag ? 'N' : '.') + (overflowFlag ? 'V' : '.') + "-" + (breakFlag ? 'B' : '.') + (decimalModeFlag ? 'D' : '.') + (irqDisableFlag ? 'I' : '.') + (zeroFlag ? 'Z' : '.') + (carryFlag ? 'C' : '.') + "]";
    }
}
