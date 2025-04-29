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
RAlt::Return
#HotIf GetKeyState("RAlt", "P")
    k::Send "{Left}"
    l::Send "{Down}"
    o::Send "{Up}"                          
    `;::Send "{Right}"
    ,::Send "{Home}"                            
    /::Send "{End}"
    Enter::Send "{Backspace}"
#HotIf ; Turn off context sensitivity                   



; ----- Left-Hand Context Cluster Remaps -----
SetCapsLockState('AlwaysOff')
F3::CapsLock
Capslock::Return

; --- Window Switching --- ; this does not work inside of hotif
Capslock & a::ShiftAltTab
Capslock & d::AltTab
Capslock & s::Send "#{Tab}"

; --- Back/Forward History ---Dda
Capslock & q::Send "!{Left}"
Capslock & e::Send "!{Right}"


CtrlUp() {
    if (!GetKeyState("Capslock")) 
        Send("{RCtrl up}")
}

; ;  --- MRU/Buffer Switching --- ; tab cycling only works correctly if done like this and no other capslock mods exist
#Hotif GetKeyState("Capslock", "P")
    Tab::{
        SetTimer(CtrlUp, -750)
        Send "{RCtrl Down}{Tab}"
    }
    +Tab::{
        SetTimer(CtrlUp, -750)
        Send "{Shift}{RCtrl Down}{Tab}"
    }
#Hotif



; ----- State Variable -----
global _isSpaceActingAsShift := false
; ----- Spacebar Hotkey -----
; Using the * prefix allows it to work even if other modifiers (like Ctrl, Alt, Win) are held
; Using $ prefix prevents the hotkey from triggering itself via Send commands inside it
*$Space::{
    global _isSpaceActingAsShift
    local DELAY := 100 / 1000
    local space_released_or_timedout := false ; Variable to store KeyWait result
    space_released_or_timedout := KeyWait("Space", "T" . DELAY)

    if not space_released_or_timedout {
        Send "{Shift Down}" ; --- Space being HELD ---
        _isSpaceActingAsShift := true
        KeyWait "Space" ; --- Wait forever until space released ---
        Send "{Shift Up}" ; --- Space was RELEASED ---
        _isSpaceActingAsShift := false
    } else {
        if !GetKeyState("Shift", "P") and !_isSpaceActingAsShift{
            SendText " " ; SendText is often reliable for single characters
        }
    }
    Return
}
