// SSDT I2C0
DefinitionBlock("", "SSDT", 2, "ACDT", "_I2C0", 0)
{
    External (SDS0, FieldUnitObj)
    External (OSYS, FieldUnitObj)
    External (GPDI, FieldUnitObj)
    External (SDM0, FieldUnitObj)
    External (TPDH, FieldUnitObj)
    External (TPDB, FieldUnitObj)
    External (TPDS, FieldUnitObj)
    External (_SB.SRXO, MethodObj)
    External (_SB.GNUM, MethodObj)
    External (_SB.INUM, MethodObj)
    External (_SB.SHPO, MethodObj)
    External (_SB.PCI0.HIDG, IntObj)
    External (_SB.PCI0.TP7G, IntObj)
    External (_SB.PCI0.HIDD, MethodObj)
    External (_SB.PCI0.TP7D, MethodObj)
    External (_SB.PCI0.I2C0, DeviceObj)

    Scope (_SB.PCI0.I2C0)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            // Disable TPD0
            SDS0 = Zero
        }

        Device (TPXX)
        {
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0020, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C0",
                    0x00, ResourceConsumer, _Y1E, Exclusive,
                    )
            })
            
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0000
                    }
            })
            
            CreateWordField (SBFB, \_SB.PCI0.I2C0.TPXX._Y1E._ADR, BADR)  // _ADR: Address
            CreateDWordField (SBFB, \_SB.PCI0.I2C0.TPXX._Y1E._SPE, SPED)  // _SPE: Speed
            CreateWordField (SBFG, 0x17, INT1)
            
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                If (LLess (OSYS, 0x07DC))
                {
                    SRXO (GPDI, One)
                }

                Store (GNUM (GPDI), INT1)
                //Store (INUM (GPDI), INT2)
                If (LEqual (SDM0, Zero))
                {
                    SHPO (GPDI, One)
                }
                
                Store (TPDH, HID2)
                Store (TPDB, BADR)
                If (LEqual (TPDS, Zero))
                {
                    Store (0x000186A0, SPED)
                }

                If (LEqual (TPDS, One))
                {
                    Store (0x00061A80, SPED)
                }

                If (LEqual (TPDS, 0x02))
                {
                    Store (0x000F4240, SPED)
                }
                
                Return (Zero)
            }
            
            Name (_HID, "ELAN0618")  // _HID: Hardware ID
            Name (_CID, "PNP0C50")  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If (LEqual (Arg0, HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If (LEqual (Arg0, TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                           
                })
            }
            
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }
            
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }
        }
    }
}
