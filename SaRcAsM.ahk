#Requires AutoHotkey v2.0
#SingleInstance

SwapChance := 69        ;Change this number to change the percent chance of toggling caps lock

ShiftCount := 0
SarcActive := 0
counter := 0

RShift::OnRShift()

OnRShift() {    
    KeyWait "RShift"
    global ShiftCount += 1
    SetTimer(ResetShiftCount, 500)

    ResetShiftCount() {
    ShiftCount := 0
    }
    
    If (ShiftCount >= 2) {
        global SarcActive := !SarcActive
        SetCapsLockState !GetKeyState("CapsLock", "T")
        ResetShiftCount()
    }
    
    While (SarcActive != 0) {       
        KeyWaitAny("V")
        KeyWaitAny(Options:="")
        {
            ih := InputHook(Options)
            if !InStr(Options, "V")
                ih.VisibleNonText := false
            ih.KeyOpt("{All}", "E")  ; End
            ih.Start()
            ih.Wait()
            if ih.EndKey = "RShift"{
                SarcActive := 0
                ShiftCount := 0
                SetCapsLockState false
                return
            }
        }

        randomNumber := Random(1, 100)
        If (randomNumber <= SwapChance)
            SetCapsLockState !GetKeyState("CapsLock", "T")
    }
}
