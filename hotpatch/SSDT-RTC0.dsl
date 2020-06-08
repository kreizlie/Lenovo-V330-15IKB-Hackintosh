// SSDT RTC0
DefinitionBlock ("", "SSDT", 2, "ACDT", "_RTC0", 0)
{
    External (_SB.PCI0.LPCB.RTC, DeviceObj)
    External (_SB.PCI0.LPCB, DeviceObj)

    // Disable RTC
    Scope (_SB.PCI0.LPCB.RTC)
    {
        Method (_STA, 0, NotSerialized)
        {
            Return (Zero)
        }
    }
    
    // Fake RTC0
    Scope (_SB.PCI0.LPCB)
    {
        Device (RTC0)
        {
            Name (_HID, EisaId ("PNP0B00")) 
            Name (_CRS, ResourceTemplate () 
            {
                IO (Decode16,
                    0x0070, 
                    0x0070,
                    0x01,
                    0x02, //0x08,
                    )
            })
            
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }
    }
}
