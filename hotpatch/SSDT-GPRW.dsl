// SSDT GPRW
DefinitionBlock ("", "SSDT", 2, "ACDT", "_GPRW", 0)
{
    External (XPRW, MethodObj)
    
    Scope (\)
    {
        Method (GPRW, 2, NotSerialized)
        {
            If ((0x6D == Arg0))
            {
                Return (Package ()
                {
                    0x6D, 
                    Zero
                })
            }

            If ((0x0D == Arg0))
            {
                Return (Package ()
                {
                    0x0D, 
                    Zero
                })
            }

            Return (XPRW (Arg0, Arg1))
        }
    }
}
