// SSDT GPIO
DefinitionBlock("", "SSDT", 2, "ACDT", "_GPIO", 0)
{
    External (SBRG, FieldUnitObj)
    External (GPEN, FieldUnitObj)
    
    Scope (\)
    {
        SBRG = One
        GPEN = One
    }
    
    // Device (GPI0)
    // {
    //     Method (_STA, 0, NotSerialized)  // _STA: Status
    //     {
    //         If (LEqual (SBRG, Zero))
    //         {
    //             Return (Zero)
    //         }
    //
    //         If (LEqual (GPEN, Zero))
    //         {
    //             Return (Zero)
    //         }
    //
    //         Return (0x0F) -- we expect this
    //     }
    // }
}
