package net.berrycompany.bitcomputers.architectures.wdc;

import com.loomcom.symon.cpus.wdc.CPU65C02;
import com.loomcom.symon.cpus.wdc.CPU65C02S;
import li.cil.oc.api.machine.Context;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import net.minecraftforge.fml.common.gameevent.TickEvent;

public class BitComputersVM65C02S {
	// The simulated machine
	public BitComputersMachine65C02S machine;

	// Allocated cycles per tick
	public int cyclesPerTick;

	public BitComputersVM65C02S(Context context) {
		super();
		MinecraftForge.EVENT_BUS.register(this);
		try {
			machine = new BitComputersMachine65C02S(context);
			if (context.node().network() == null) {
				// Loading from NBT
				return;
			}
			machine.getCpu().reset();
		} catch (Exception e) {
			throw new RuntimeException("Failed to setup BitComputers", e);
		}
	}

	void run() throws Exception {
		machine.getComponentSelector().checkDelay();
		CPU65C02S mCPU = machine.getCpu();
		while (mCPU.getCycles() > 0) {
			mCPU.step();
		}
		machine.getGioDev().flush();
	}

	@SubscribeEvent
	public void onServerTick(TickEvent.ServerTickEvent event) {
		Context context = machine.getContext();
		if (!context.isRunning() && !context.isPaused()) {
			MinecraftForge.EVENT_BUS.unregister(this);
			return;
		}
		if (event.phase != TickEvent.Phase.START) {
			return;
		}
		CPU65C02S mCPU = machine.getCpu();
		if (mCPU.getCycles() < cyclesPerTick) {
			mCPU.addCycles(cyclesPerTick);
		}
		machine.getRTC().onServerTick();
	}
}
