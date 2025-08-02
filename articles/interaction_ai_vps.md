# Interaction with ControlD AI – VPS Sync Issue (IONOS)

## Context
After deploying `ctrld` on an Ubuntu VPS hosted by IONOS, Ruben observed that while the service was running and resolving DNS locally, the node remained inactive in the ControlD dashboard until a DNS query was made. This raised concerns about synchronization behavior in headless or low-traffic environments.

---

## Key Exchange Summary

### Ruben:
> `ctrld` fails to show as active in the dashboard until a DNS query is issued. Is there any way to force registration/sync without traffic?

### ControlD AI:
> At this time, `ctrld` does not have a built-in “ping” or keepalive function to proactively register itself in the ControlD dashboard without handling at least one DNS query. The dashboard shows nodes as active only after a DNS request is processed.

> Your cron-script approach is currently the best workaround. There’s no supported flag or config parameter to trigger a dashboard handshake at startup.

### Ruben:
> Is there a way to make both `ctrld` and `systemd-resolved` coexist so I don’t have to disable the stub resolver?

### ControlD AI:
> True coexistence is tricky because both services try to bind to the same ports on localhost. You can configure `ctrld` to listen on a different port (e.g., 127.0.0.1:5354) and point `/etc/resolv.conf` to that, but `systemd-resolved` won’t forward to non-standard ports. Disabling `systemd-resolved` remains the cleanest path.

### Ruben:
> Understood. Can you help draft a GitHub feature request so this can be improved in the future?

### ControlD AI:
> Of course! Here’s a template you can use:

```markdown
Feature Request: Provide Dashboard Handshake (Keepalive) Trigger on Startup

Background:
In headless/VPS environments (e.g., Ubuntu on IONOS), ctrld does not appear as active in the Control D dashboard until it handles its first DNS query. This complicates automation and monitoring, especially on new deployments where DNS queries may not occur immediately.

Request:
Add an option to force ctrld to register as “active” in the Control D dashboard at startup, even if no DNS queries have been received yet. Example implementations:

- A --ping-dashboard startup flag that sends a handshake/keepalive
- Built-in registration with the dashboard on service start

Use Case:
Automated provisioning and health monitoring of ctrld endpoints on servers where production DNS traffic may be delayed or infrequent.

Workaround:
Currently using a cron job to periodically send dummy queries to trigger dashboard sync, but a native solution would be preferable.
