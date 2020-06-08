// SSDT KBD0
DefinitionBlock("", "SSDT", 2, "ACDT", "_KBD0", 0)
{
    External (_SB.PCI0.LPCB.EC, DeviceObj)
    External (_SB.PCI0.LPCB.KBD0, DeviceObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q1C, 0, NotSerialized) // (F15) Brightness Up
        {
            Notify (KBD0, 0x0406)
        }
        
        Method (_Q1D, 0, NotSerialized) // (F14) Brightness Down
        {
            Notify (KBD0, 0x0405)
        }
    }
}
