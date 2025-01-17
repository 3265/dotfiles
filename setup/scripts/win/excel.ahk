#IfWinActive ahk_exe EXCEL.EXE
^Enter:: ; This represents Ctrl + Enter
    Send, !{Enter} ; This sends Alt + Enter
Return
#IfWinActive
