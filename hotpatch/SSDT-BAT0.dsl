// SSDT BAT0
DefinitionBlock("", "SSDT", 2, "ACDT", "_BAT0", 0)
{
    External (_SB.PCI0.LPCB.EC, DeviceObj)
    External (_SB.PCI0.LPCB.EC.BAT0, DeviceObj)
    External (_SB.PCI0.LPCB.EC.BAT1, DeviceObj)
    External (_SB.PCI0.LPCB.EC.BNEN, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.ACST, IntObj)
    External (_SB.PCI0.LPCB.EC.SYSO, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.MUTE, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.BATM, MutexObj)
    External (_SB.PCI0.LPCB.EC.TINI, MethodObj)
    External (BCEN, IntObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {
        OperationRegion (XCMB, SystemMemory, 0xFE802000, 0x0200)
        Field (XCMB, ByteAcc, Lock, Preserve)
        {
            Offset (0x08), 
            /* NB0S */,   8, 
            /* NB1S */,   8, 
            Offset (0x80), 
            /* B0RC */,   16, 
            /* B0FC */,   16, 
            /* B0RS */,   16, 
            /* B0AC */,   16, 
            /* B0VO */,   16, 
            Offset (0x8C), 
            /* B0CU */,   16, 
            /* B0TE */,   16, 
            /* B0DC */,   16, 
            /* B0DV */,   16, 
            Offset (0x9E), 
            /* B0CC */,   16, 
            Offset (0xAA), 
            /* B0MD */,   16, 
            Offset (0xB2), 
            /* B0AE */,   16, 
            /* B0AF */,   16, 
            /* B0FU */,   16, 
            Offset (0xC0), 
            /* B0MN */,   64, 
            /* B0M1 */,   32, 
            Offset (0xD0), 
            /* B0DN */,   64, 
            Offset (0xF0), 
            /* B0DY */,   64, 
            /* B0Y1 */,   16, 
            Offset (0x110), 
            /* BAI0 */,   8, 
            /* BAI1 */,   8, 
            /* BAI2 */,   8, 
            /* BAI3 */,   8, 
            /* BAI4 */,   8, 
            /* BAI5 */,   8, 
            /* BAI6 */,   8, 
            /* BAI7 */,   8, 
            Offset (0x122), 
            /* B0B0 */,   64, 
            /* B0B1 */,   64, 
            /* B0B2 */,   32, 
            /* B0B3 */,   16, 
            /* B0B4 */,   8
        }
        
        Method (GBIF, 3, NotSerialized)
        {
            Acquire (BATM, 0xFFFF)
            If (Arg2)
            {
                Store (0xFFFFFFFF, Index (Arg1, One))
                Store (0xFFFFFFFF, Index (Arg1, 0x02))
                Store (0xFFFFFFFF, Index (Arg1, 0x04))
                Store (Zero, Index (Arg1, 0x05))
                Store (Zero, Index (Arg1, 0x06))
            }
            Else
            {
                OperationRegion (ECMR, SystemMemory, Arg0, 0x80)
                Field (ECMR, ByteAcc, Lock, Preserve)
                {
                    BSRC,   16, 
                    BSFC,   16, 
                    BSPE,   16, 
                    BSAC,   16, 
                    BSVO,   16, 
                        ,   15, 
                    BSCM,   1, 
                    BSCU,   16, 
                    BSTV,   16, 
                    BSDC,   16, 
                    BSDV,   16, 
                    BSSN,   16, 
                    Offset (0x40), 
                    BSMN,   128, 
                    BSDN,   256, 
                    BSCH,   128
                }

                Store (BSCM, Local0)
                XOr (Local0, One, Index (Arg1, Zero))
                If (Local0)
                {
                    Multiply (BSDC, 0x0A, Local1)
                }
                Else
                {
                    Store (BSDC, Local1)
                }

                Store (Local1, Index (Arg1, One))
                If (Local0)
                {
                    Multiply (BSFC, 0x0A, Local2)
                }
                Else
                {
                    Store (BSFC, Local2)
                }

                Store (Local2, Index (Arg1, 0x02))
                Store (BSDV, Index (Arg1, 0x04))
                Divide (Local2, 0x64, Local7, Local6)
                Multiply (Local6, 0x07, Local3)
                Store (Local3, Index (Arg1, 0x05))
                Store (0x06, Local4)
                Add (Local4, One, Local4)
                Multiply (Local6, Local4, Local4)
                Divide (Local4, 0x02, Local7, Local4)
                Store (Local4, Index (Arg1, 0x06))
                Store (BSSN, Local7)
                Name (SERN, Buffer (0x06)
                {
                    "     "
                })
                Store (0x04, Local6)
                While (Local7)
                {
                    Divide (Local7, 0x0A, Local5, Local7)
                    Add (Local5, 0x30, Index (SERN, Local6))
                    Decrement (Local6)
                }

                Store (SERN, Index (Arg1, 0x0A))
                Store (BSDN, Index (Arg1, 0x09))
                Store (BSCH, Index (Arg1, 0x0B))
                Store (BSMN, Index (Arg1, 0x0C))
            }

            Release (BATM)
            Return (Arg1)
        }

        Method (GBST, 4, NotSerialized)
        {
            Acquire (BATM, 0xFFFF)
            OperationRegion (ECMR, SystemMemory, Arg0, 0x10)
            Field (ECMR, ByteAcc, Lock, Preserve)
            {
                BSRC,   16, 
                BSFC,   16, 
                BSPE,   16, 
                BSAC,   16, 
                BSVO,   16, 
                    ,   15, 
                BSCM,   1, 
                BSCU,   16, 
                BSTV,   16
            }

            If (And (Arg1, 0x02))
            {
                Store (0x02, Local0)
                If (And (Arg1, 0x20))
                {
                    Store (Zero, Local0)
                }
            }
            ElseIf (And (Arg1, 0x04))
            {
                Store (One, Local0)
            }
            Else
            {
                Store (Zero, Local0)
            }

            If (And (Arg1, 0x10))
            {
                Or (Local0, 0x04, Local0)
            }

            If (And (Arg1, One))
            {
                Store (BSAC, Local1)
                Store (BSRC, Local2)
                If (ACST)
                {
                    If (And (Arg1, 0x20))
                    {
                        Store (BSFC, Local2)
                    }
                }

                If (Arg2)
                {
                    Multiply (Local2, 0x0A, Local2)
                }

                Store (BSVO, Local3)
                If (LGreaterEqual (Local1, 0x8000))
                {
                    If (And (Local0, One))
                    {
                        Subtract (0x00010000, Local1, Local1)
                    }
                    Else
                    {
                        Store (Zero, Local1)
                    }
                }
                ElseIf (LEqual (And (Local0, 0x02), Zero))
                {
                    Store (Zero, Local1)
                }

                If (Arg2)
                {
                    Multiply (Local3, Local1, Local1)
                    Divide (Local1, 0x03E8, Local7, Local1)
                }
            }
            Else
            {
                Store (Zero, Local0)
                Store (0xFFFFFFFF, Local1)
                Store (0xFFFFFFFF, Local2)
                Store (0xFFFFFFFF, Local3)
            }

            Store (Local0, Index (Arg3, Zero))
            Store (Local1, Index (Arg3, One))
            Store (Local2, Index (Arg3, 0x02))
            Store (Local3, Index (Arg3, 0x03))
            Release (BATM)
            Return (Arg3)
        }
        
        Method (ECWK, 1, NotSerialized)
        {
            Store (Arg0, SYSO)
            Store (Zero, MUTE)
            TINI ()
            Notify (BAT0, 0x81)
            Notify (BAT1, 0x81)
            If (LOr (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
            {
                Store (BCEN, BNEN)
                Store (BCVE, BNVE)
            }

            If (LEqual (Arg0, 0x03)){}
            If (LEqual (Arg0, 0x04)){}
            If (LOr (LEqual (Arg0, 0x04), LEqual (Arg0, 0x05))){}
        }
    }
}
