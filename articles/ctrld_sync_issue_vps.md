# ControlD Sync Delay on VPS (IONOS Ubuntu)

## Problem
On a VPS (Ubuntu 22.04, IONOS), `ctrld` service ran correctly, but the node remained inactive in the ControlD dashboard until at least one DNS query was processed.

## Diagnosis
- `ctrld` was active and bound to 127.0.0.1:53
- Dashboard only recognized the node after traffic was generated (e.g., `dig`)
- Root cause: `ctrld` does not ping or register with ControlD at startup

## Solution
- Disabled `systemd-resolved` to avoid stub resolver conflicts
- Replaced `/etc/resolv.conf` with manual entry: `nameserver 127.0.0.1`
- Created script `wake_ctrld_sync.sh` to send periodic queries via cron

## Impact
- Node now syncs correctly with the dashboard within 1–2 minutes of boot
- cron-based DNS activity ensures visibility even in low-traffic environments

## Proposed Feature (pending GitHub)
Add a `--ping-dashboard` or startup registration flag to allow dashboard sync without requiring initial DNS traffic

> Case validated in production on IONOS VPS, now in monitoring phase.
