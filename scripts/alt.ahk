;------------------
; Excel
;------------------

#IfWinActive ahk_exe EXCEL.EXE
;Shift＋Enter→Alt＋Enterに割り当て
+sc01C::
    Send, !{sc01C}
Return
#IfWinActive

;------------------
; IME
;------------------

; 上部メニューがアクティブになるのを抑制
*~LAlt:: Send {Blind}{vk07}
*~RAlt:: Send {Blind}{vk07}

; 左Altで無変換キー
LAlt up::
    Send, {vk1Dsc07B}
return

; 右Altで変換キー
RAlt up::
    Send, {vk1Csc079}
return

