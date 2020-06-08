// SSDT HPE0
DefinitionBlock ("", "SSDT", 2, "ACDT", "_HPE0", 0)
{
    External (_SB.PCI0.LPCB, DeviceObj)
    External (HPTE, FieldUnitObj)
    
    Scope (\)
    {
        // Disable HPET
        HPTE = Zero
        
        // Device (HPET)
        // {
        //     Method (_STA, 0, NotSerialized)  // _STA: Status
        //     {
        //         If (HPTE)
        //         {
        //             Return (0x0F)
        //         }
        //         Return (Zero) -- we expect this
        //     }
        // }
    }
    
    // Fake HPE0
    Scope (_SB.PCI0.LPCB)
    {
        Device (HPE0)
        {
            Name (_HID, EisaId ("PNP0103"))
            Name (_UID, Zero)
            Name (BUF0, ResourceTemplate ()
            {
                IRQNoFlags() { 0, 8 }
                Memory32Fixed (ReadWrite,
                    0xFED00000,
                    0x00000400,
                    )
            })
            
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
            
            Method (_CRS, 0, Serialized)
            {
                Return (BUF0)
            }
        }
    }
}
