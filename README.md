# Contributions to ControlD – Ruben Galindo

## 🧠 Purpose
Documenting technical contributions, field-tested solutions, and improvement proposals for the ControlD resolver (`ctrld`), with the intent of being recognized as a community collaborator or technical contributor.

---

## 🛠️ Real-world Implementations

### 1. Raspberry Pi (DietPi) – Resilient DNS Architecture
- DNS-over-HTTPS with ControlD as primary, AdGuard as fallback
- Failover tested with real upstream outages
- systemd service overrides, TLS bootstrap validation, DNS leak protection
- Full LAN integration with MikroTik firewall
- [Read article](./articles/resilient_dns_rpi.md)

### 2. VPS (IONOS Ubuntu) – Sync Failure Case Study
- `ctrld` service active, but dashboard remained inactive until traffic
- Diagnosed and resolved lack of sync by disabling `systemd-resolved`
- Created auto-sync script via cron: `wake_ctrld_sync.sh`
- [Read article](./articles/ctrld_sync_issue_vps.md)

---

## ⚙️ Scripts and Tools

- [`wake_ctrld_sync.sh`](./scripts/wake_ctrld_sync.sh): Forces DNS queries every 5 minutes to keep VPS nodes visible in dashboard
- [`check_ctrld_sync.sh`](./scripts/check_ctrld_sync.sh): Verifies service activity and dashboard sync status

---

## 📌 Feature Requests

- [`--ping-dashboard` on startup](./features/feature_ctrld_ping_startup.md): Allow `ctrld` to register in dashboard without requiring DNS traffic

---

## 🗣️ Conversations & Technical Exchanges

- [VPS sync issue and workaround](./articles/interaction_ai_vps.md): Logged conversation with ControlD AI explaining root cause and proposed improvements

---

## 🔍 Philosophy
> "Resilient infrastructure is not built by accident. It’s engineered, tested, and documented."

My contributions aim to support the growth of ControlD by identifying edge-case behaviors, building tooling around production use, and providing valuable insight to improve the user experience.

