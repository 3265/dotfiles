#.bashrcの読み込み(for mac)
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# 初回シェル時のみ screen実行
if [ $SHLVL = 1 ]; then
  # 先にデタッチ済みのセッションは全て消す
  screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill
  screen
fi

