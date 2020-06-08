// SSDT TIM0
DefinitionBlock ("", "SSDT", 2, "ACDT", "_TIM0", 0)
{
    External (_SB.PCI0.LPCB.TIMR, DeviceObj)
    External (_SB.PCI0.LPCB, DeviceObj)

    // Disable TIMR
    Scope (_SB.PCI0.LPCB.TIMR)
    {
        Method (_STA, 0, NotSerialized)
        {
            Return (Zero)
        }
    }
    
    // Fake TIM0
    Scope (_SB.PCI0.LPCB)
    {
        Device (TIM0)
        {
            Name (_HID, EisaId ("PNP0100"))
            Name (_CRS, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0040,
                    0x0040,
                    0x01,
                    0x04,
                    )
                IO (Decode16,
                    0x0050,
                    0x0050,
                    0x10,
                    0x04,
                    )
            })
            
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }
    }
}
