#IfWinActive ahk_exe EXCEL.EXE
;Shift＋Enter→Alt＋Enterに割り当て
+sc01C::
    Send, !{sc01C}
Return
#IfWinActive
