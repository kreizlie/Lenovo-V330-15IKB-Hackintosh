// SSDT PWRB
DefinitionBlock("", "SSDT", 2, "ACDT", "PWRB", 0)
{
    Scope (_SB)
    {
        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }
    }
}
