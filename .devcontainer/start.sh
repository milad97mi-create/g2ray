#!/bin/bash

# 1. generate fresh UUID
UUID=$(node -e "console.log(crypto.randomUUID())")

# 2. inject UUID into config BEFORE Xray starts
jq --arg uuid "$UUID" '
  .inbounds[0].settings.clients[0].id = $uuid
' /etc/xray/g2ray.json > /tmp/xray.json && mv /tmp/xray.json /etc/xray/g2ray.json

# 3. restart tmux session
tmux kill-session -t g2ray 2>/dev/null || true
tmux new-session -d -s g2ray

# 4. start xray inside tmux
tmux send-keys -t g2ray "sudo /usr/local/bin/xray run -c /etc/xray/g2ray.json &>/tmp/xray.log" Enter

sleep 2
show-link.sh
