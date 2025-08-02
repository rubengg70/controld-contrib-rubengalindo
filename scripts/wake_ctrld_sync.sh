#!/bin/bash

# === CONFIGURATION ===
LOG_FILE="/var/log/ctrld_sync_check.log"
CHECK_DOMAIN="google.com"
CTRLD_INTERFACE="127.0.0.1"
CTRLD_PORT="53"

# === LOG FUNCTION ===
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# === BEGIN CHECK ===
log "🚀 Triggering activity for ctrld + checking dashboard sync..."

if ! pgrep -x ctrld > /dev/null; then
  log "❌ ctrld is not running. Aborting."
  exit 1
fi

log "✅ ctrld is running (PID: $(pgrep -x ctrld))"

for i in {1..5}; do
  dig @$CTRLD_INTERFACE -p $CTRLD_PORT $CHECK_DOMAIN +short > /dev/null
  sleep 0.5
done

log "📡 Sent 5 DNS queries to $CHECK_DOMAIN"

LAST_LOG=$(journalctl -u ctrld --no-pager -n 10 --since "5 minutes ago" | grep 'sending query to')
if [ -n
