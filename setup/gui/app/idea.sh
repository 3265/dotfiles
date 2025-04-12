#!/bin/bash

# インストール先の設定
INSTALL_DIR="$HOME/Applications"
IDEA_VERSION="2024.1"
IDEA_BUILD="241.14494.240"
DOWNLOAD_URL="https://download.jetbrains.com/idea/ideaIC-${IDEA_VERSION}.tar.gz"

# 必要なパッケージのインストール（解凍ツールなど）
sudo apt update
sudo apt install -y tar wget

# インストール先ディレクトリを作成
mkdir -p "$INSTALL_DIR"

# IDEA をダウンロード
echo "Downloading IntelliJ IDEA Community Edition..."
wget -O /tmp/ideaIC.tar.gz "$DOWNLOAD_URL"

# 解凍
echo "Extracting IntelliJ IDEA..."
tar -xzf /tmp/ideaIC.tar.gz -C "$INSTALL_DIR"

# 最新のディレクトリ名取得（バージョンに依存）
EXTRACTED_DIR=$(tar -tf /tmp/ideaIC.tar.gz | head -1 | cut -f1 -d"/")
IDEA_PATH="$INSTALL_DIR/$EXTRACTED_DIR"

# シンボリックリンクを設定（必要に応じて）
ln -sf "$IDEA_PATH/bin/idea.sh" "$HOME/bin/idea"

# .desktopファイルの作成（ランチャー用）
echo "Creating desktop entry..."
cat > ~/.local/share/applications/jetbrains-idea-ce.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Community Edition
Icon=$IDEA_PATH/bin/idea.png
Exec="$IDEA_PATH/bin/idea.sh" %f
Comment=JetBrains IDE for Java and more
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea
EOF

chmod +x ~/.local/share/applications/jetbrains-idea-ce.desktop

echo "インストール完了！"
echo "ランチャーやターミナルから 'idea' コマンドで起動できます。"

