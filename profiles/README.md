# ASARS Profiles

ASARS defines a **universal attestation envelope** (never reinterpreted by profiles) and **domain payloads** (everything an auditor needs for a vertical).

## Core principle

Every profile shares the same structure:

**Universal envelope (unchanged, core ASARS v0.1)**  
`receipt_id`, `timestamp_utc`, `sequence_id`, `observation_layer`, `agent_identity`, `chain.*`, `attestation.*` (including `simulation`, `method`, `signature`, optional `pcr_sealed`), `payload_hash`.

**Domain payload (profile-specific)**  
The `event` object, optional **top-level context objects** (for example `telecom_context`, `industrial_context`, `kinetic_context`) where implementers group related fields, and domain-specific vocabulary that answers the liability question for that moment.

## What belongs in a profile?

Use three filters:

1. **Liability question** — When something goes wrong, who might be blamed, and what evidence resolves it?
2. **Regulatory / standards mapping** — What does the governing framework require to be demonstrable?
3. **Demarcation point** — What is the exact instant the autonomous decision meets the physical or contractual world (syscall, ROS publish, UPF boundary, actuator command fork)?

Fields should survive that filter; everything else belongs in implementation-private logs.

## Core `event.outcome` and domain vocabulary

ASARS v0.1 requires `event.outcome` to be **`allowed`** or **`blocked`** only. Profiles add parallel fields (for example `sla_result`, `command_disposition`) for domain semantics. See each profile README for the recommended mapping to `allowed` / `blocked` for verification tooling.

## Index

| Profile | Domain | Status |
|--------|--------|--------|
| [Enterprise Cloud](enterprise-cloud/README.md) | Cloud AI agents, CI/CD, API monitoring | Published |
| [Telecom-SLA](telecom-sla/README.md) | 5G SLA, C-V2X, URLLC edge | Draft |
| [Industrial-ROS](industrial-ros/README.md) | Factory robotics, ROS | Draft |
| [Kinetic-UAS](kinetic-uas/README.md) | Unmanned / autonomous kinetic platforms | Draft |

The Telecom-SLA profile is being developed with input from 5G SLA verification practitioners working in C-V2X and URLLC environments.

## Contributing

Open a GitHub Issue for new domains, then propose schema under `profiles/`. The **attestation envelope is not modifiable** in a profile; payload and documented context objects are. See [CONTRIBUTING.md](../CONTRIBUTING.md).
