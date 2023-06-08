package net.berrycompany.bitcomputers;

import java.io.IOException;
import java.io.InputStream;

import net.berrycompany.bitcomputers.architectures.wdc.BitComputersArchitecture65C02;
import net.berrycompany.bitcomputers.architectures.csg.BitComputersArchitecture65CE02;
import net.berrycompany.bitcomputers.architectures.wdc.BitComputersArchitecture65C02S;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLInitializationEvent;
import net.minecraftforge.fml.common.event.FMLPreInitializationEvent;
import org.apache.commons.io.IOUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import net.berrycompany.bitcomputers.util.LogMessage;
import li.cil.oc.Settings;
import li.cil.oc.api.Items;
import li.cil.oc.api.Machine;
import net.minecraftforge.common.config.Configuration;

@Mod(modid = BitComputers.MODID, name = BitComputers.NAME, version = BitComputers.VERSION, dependencies = "required-after:opencomputers@[1.7.5,)")
public class BitComputers {
	public static final String MODID = "bitcomputers";
	public static final String NAME = "BitComputers";
	public static final String VERSION = "1.2.0";

	public static Logger log;

	@SuppressWarnings("FieldCanBeLocal")
	private Configuration config;

	@Mod.EventHandler
	public void preInit(FMLPreInitializationEvent event) {
		log = LogManager.getLogger(MODID, new LogMessage("BitComputers"));
		config = new Configuration(event.getSuggestedConfigurationFile());

		BitComputersConfig.loadConfig(config);
		Machine.add(BitComputersArchitecture65C02.class);
		Machine.add(BitComputersArchitecture65C02S.class);
		Machine.add(BitComputersArchitecture65CE02.class);
	}

	@Mod.EventHandler
	public void init(FMLInitializationEvent event) {
		boolean configurationIssue = false;
		if (Settings.get().eepromSize() != 4096) {
			configurationIssue = true;
			log.error("EEPROM size is no longer 4096 bytes, Thistle will not work properly.");
		}
		if (Settings.get().eepromDataSize() != 256) {
			configurationIssue = true;
			log.error("EEPROM data size is no longer 256 bytes, Thistle will not work properly.");
		}
		if (configurationIssue)
			log.error("Please reconfigure OpenComputers or you will run into issues.");

		// Register EEPROM
		registerEEPROM("boot65c02.rom", "boot65c02.rom");
		registerEEPROM("boot65c02s.rom", "boot65c02s.rom");
		registerEEPROM("boot65ce02.rom", "boot65ce02.rom");
	}

	private static void registerEEPROM(String eepromName, String fileName) {
		InputStream bootRom = BitComputers.class.getResourceAsStream("/assets/" + MODID + "/roms/" + fileName);
		if (bootRom != null) {
			try {
				byte[] code = IOUtils.toByteArray(bootRom);
				Items.registerEEPROM("EEPROM (" + eepromName + ")", code, null, true);
			} catch (IOException e) {
				log.warn("Failed reading " + fileName + ", no custom EEPROMs available", e);
			} finally {
				IOUtils.closeQuietly(bootRom);
			}
		} else {
			log.warn(fileName + " could not be located, no custom EEPROMs available");
		}
	}
}
