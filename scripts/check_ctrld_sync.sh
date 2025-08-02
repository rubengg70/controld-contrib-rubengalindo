#!/bin/bash

# === CONFIGURATION ===
LOG_FILE="/var/log/ctrld_sync_check.log"
CHECK_DOMAIN="google.com"
CTRLD_INTERFACE="127.0.0.1"
CTRLD_PORT="53"
DASHBOARD_URL="https://dash.controld.com/account"

# === LOG FUNCTION ===
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# === BEGIN CHECK ===
log "🔍 Checking ctrld status and dashboard sync..."

if ! pgrep -x ctrld > /dev/null; then
  log "❌ ctrld is not running."
  exit 1
else
  log "✅ ctrld is running (PID: $(pgrep -x ctrld))"
fi

log "🌐 Sending DNS query to $CHECK_DOMAIN via $CTRLD_INTERFACE:$CTRLD_PORT..."
dig @$CTRLD_INTERFACE -p $CTRLD_PORT $CHECK_DOMAIN +short > /dev/null

if [ $? -eq 0 ]; then
  log "✅ DNS query successful."
else
  log "❌ DNS query failed."
  exit 1
fi

LAST_LOG=$(journalctl -u ctrld --no-pager -n 10 --since "5 minutes ago" | grep 'sending query to')
if [ -n "$LAST_LOG" ]; then
  log "🧭 Last ctrld activity in logs:"
  echo "$LAST_LOG" | tee -a "$LOG_FILE"
else
  log "⚠️ No recent activity in ctrld logs."
fi

log "📡 Check your dashboard at: $DASHBOARD_URL"
