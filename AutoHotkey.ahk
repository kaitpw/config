; ==============================================================================
; AutoHotkey v2 Script - Mac-like Remapping & Hyper Key (Revised for Ctrl+Tab)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force ; Ensure only one instance runs and replace the old one automatically
SendMode "Input" ; Use Input mode for potentially better reliability



; ----- Core Remaps -----
LCtrl::LWin        ; Physical Left Ctrl now acts as Left Win
LAlt::LCtrl        ; Physical Left Alt now acts as Left Ctrl (Mac Command position)
LWin::LAlt         ; Physical Left Win now acts as Left Alt (Mac Option position)
RCtrl::RAlt        ; Physical Right Ctrl now acts as Right Alt (Mac Option position)



; ----- Right-Hand Navigation Cluster -----
*RAlt::Return
; * and {Blank} allow passthrough of other modifiers being held
#HotIf GetKeyState("RAlt", "P")
    *k::Send "{Blind}{Left}"
    *l::Send "{Blind}{Down}"
    *o::Send "{Blind}{Up}"
    *`;::Send "{Blind}{Right}"
    *,::Send "{Blind}{Home}"                            
    */::Send "{Blind}{End}"
    *Enter::Send "{Blind}{Backspace}"
#HotIf



; ----- Left-Hand Context Cluster Remaps -----
SetCapsLockState('AlwaysOff')
Capslock::Return
F3::CapsLock

; --- Window Switching --- ; AltTab reassignment ONLY WORKS LIKE THIS
Capslock & a::ShiftAltTab
Capslock & d::AltTab
Capslock & s::Send "#{Tab}" ; doesn't matter if in loop or not

#Hotif GetKeyState("Capslock", "P")
    ; --- Back/Forward History
    q::Send "!{Left}"
    e::Send "!{Right}"
    ;  --- MRU/Buffer Switching --- ;
    Tab::{
        Send "{RCtrl Down}{Tab}"
        KeyWait "Capslock"
        Send "{RCtrl up}"
    }
    +Tab::{
        Send "{Shift}{RCtrl Down}{Tab}"
        KeyWait "Capslock"
        Send "{RCtrl up}"
    }
#Hotif



; ----- Shifty Spacebar -----
;  * allows modifier passthrough, $ prevents triggering itself via Send commands inside it
*$Space::{
    local DELAY_MS := 100
    local space_released_or_timedout := KeyWait("Space", "T" . DELAY_MS / 1000)

    if space_released_or_timedout {
        SendText " "
    } else {
        Send "{Shift Down}" ; --- Space being HELD ---
        KeyWait "Space"
        Send "{Shift Up}" ; --- Space was RELEASED ---
    }
    Return
}
