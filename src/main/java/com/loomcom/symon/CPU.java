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

package com.loomcom.symon;

@SuppressWarnings("unused")
public abstract class CPU {
    /* The Bus */
    protected Bus bus;

    /* CPU Cycles available */
    protected int cycles = 0;

    /**
     * Set the bus reference for this CPU.
     */
    public void setBus(Bus bus) {
        this.bus = bus;
    }

    /**
     * Return the Bus that this CPU is associated with.
     */
    public Bus getBus() {
        return bus;
    }

    public int getCycles() {
        return cycles;
    }

    public void addCycles(int count) {
        cycles += count;
    }

    /**
     * Reset the CPU to known initial values.
     */
    public abstract void reset();

    public abstract void step(int num);

    /**
     * Performs an individual instruction cycle.
     */
    public abstract void step();

    /**
     * Return the current Cpu State.
     *
     * @return the current Cpu State.
     */
    public abstract CPUState getCpuState();

    /**
     * Simulate transition from logic-high to logic-low on the INT line.
     */
    public abstract void assertIrq();

    /**
     * Simulate transition from logic-low to logic-high of the INT line.
     */
    public abstract void clearIrq();

    /**
     * Simulate transition from logic-high to logic-low on the NMI line.
     */
    public abstract void assertNmi();

    /**
     * Simulate transition from logic-low to logic-high of the NMI line.
     */
    public abstract void clearNmi();

    /**
     * @param address Address to disassemble
     * @return String containing the disassembled instruction and operands.
     */
    public abstract String disassembleOpAtAddress(int address);
}
