; 上部メニューがアクティブになるのを抑制
*~LAlt::Send {Blind}{vk07}
*~RAlt::Send {Blind}{vk07}

; 左 Alt 空打ちで 変換キー
LAlt up::
    Send, {vk1Csc079}
return

; 右 Alt 空打ちで 無変換キー
RAlt up::
    Send, {vk1Dsc07B}
return

