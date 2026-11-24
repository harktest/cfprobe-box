#!/bin/sh
# CF-Server-Monitor probe container. Needs env SECRET; optional NAME, SERVER_ID, PORT.
PORT="${PORT:-8080}"
D="${DATA_DIR:-/tmp/cfprobe}"
mkdir -p /tmp/www "$D" && echo ok > /tmp/www/index.html
for p in "$PORT" 8000 8080; do busybox-extras httpd -f -p "$p" -h /tmp/www 2>/dev/null & done
cat > $D/config.conf <<CONF
SERVER_ID="${SERVER_ID:-}"
SECRET="${SECRET}"
WORKER_URL="${WORKER_URL:-https://cf-server-monitor.boy2026.workers.dev/update}"
NAME="${NAME:-$(hostname)}"
COLLECT_INTERVAL="2"
REPORT_INTERVAL="60"
CT_NODE="gd-ct-dualstack.ip.zstaticcdn.com"
CU_NODE="gd-cu-dualstack.ip.zstaticcdn.com"
CM_NODE="gd-cm-dualstack.ip.zstaticcdn.com"
BD_NODE=""
NODE_1=""
NODE_2=""
NODE_3=""
NODE_4=""
INTERFACE=""
RESET_DAY="1"
CONNECTION_MODE="auto"
PING_MODE="tcp"
UA="cfsm"
AUTO_UPDATE="0"
UPDATE_PROXY=""
CONF
chmod 600 $D/config.conf
( sleep 90; echo "probe SERVER_ID now: $(grep ^SERVER_ID $D/config.conf)" ) &
cd "$D"
while true; do
  cf-probe run -config $D/config.conf
  echo "cf-probe exited $?, restart in 30s"; sleep 30
done
