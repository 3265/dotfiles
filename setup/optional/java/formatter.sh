#!/bin/bash

sudo mkdir -p /usr/local/lib
sudo curl -L -o /usr/local/lib/google-java-format.jar \
  https://repo1.maven.org/maven2/com/google/googlejavaformat/google-java-format/1.28.0/google-java-format-1.28.0-all-deps.jar

sudo tee /usr/local/bin/google-java-format <<'EOF'
#!/usr/bin/env bash
# google‑java‑format ランチャー
exec java -jar /usr/local/lib/google-java-format.jar "$@"
EOF

sudo chmod +x /usr/local/bin/google-java-format
