package net.berrycompany.bitcomputers;

import li.cil.oc.api.machine.Architecture;
import li.cil.oc.api.machine.Value;

public abstract class BitComputersArchitecture implements Architecture {
    public abstract Object[] invoke(String address, String method, Object[] args) throws Exception;

    public abstract Object[] invoke(Value value, String method, Object[] args) throws Exception;
}
