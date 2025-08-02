# Resilient DNS Architecture on Raspberry Pi (DietPi)

## Context
A highly available and secure DNS infrastructure was implemented on a Raspberry Pi running DietPi using ControlD as the main resolver and AdGuard as fallback. The system includes:

- DNS-over-HTTPS via `ctrld` using ControlD primary + AdGuard secondary
- Failover configuration with `leak_on_upstream_failure = false`
- Dynamic bootstrap IP validation via `ExecStartPre`
- Full firewall integration with MikroTik to control DoH and fallback behavior
- DNS cache enabled, `/etc/resolv.conf` in read-only mode

## Key Events
- Recovery from upstream ControlD failures without DNS leaks
- Detection and removal of shadow fallbacks (e.g., 76.76.2.22 references)
- Successful reintegration of preferred upstream IPs after verification
- Bitácora registered all live tests and logs

## Outcome
The Pi-based resolver became the single point of resolution for all LAN devices, with MikroTik only serving as conditional fallback. The architecture has been validated in production with multiple real failovers and is now considered resilient and clean.

## Related Files
- `ctrld.toml` configuration (not public)
- `check_ctrld_status.sh` (archived)
- `controld_tls_probe.sh` (archived)

> This case represents a live, field-tested deployment of ControlD under real-world network conditions.
