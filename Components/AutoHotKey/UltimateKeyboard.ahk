/*
Ultimate AutoHotKey Keyboard.
https://www.autohotkey.com/docs/v2/KeyList.htm

*/

#Requires AutoHotkey v2.0
#SingleInstance Force

SetWorkingDir A_InitialWorkingDir
SetTitleMatchMode 2
A_HotkeyModifierTimeout := 100

/* Reload Script */
<^>!R::Reload

/* SYSTEM WIDE */
/* Windows */
<^>!W::Send "#{Up}"
<^>!+W::Send "^#!{Up}"
<^>!S::Send "#{Down}"
<^>!+S::Send "^#!{Down}"
<^>!A::Send "#{Left}"
<^>!+A::Send "^#!{Left}"
<^>!D::Send "#{Right}"
<^>!+D::Send "^#!{Right}"
<^>!+[::Send "#+{Left}"
<^>!+]::Send "#+{Right}"
<^>!Q::Send "!{F4}"

/* Apps */
<^>!C::Run "Chrome.exe"
<^>!P::Send "^+{Space}"