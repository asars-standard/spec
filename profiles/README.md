# ASARS Profiles

ASARS defines a universal hardware attestation envelope. The attestation layer — TPM signing, PCR sealing, chain linking, simulation disclosure, independent verification — is identical across all profiles.

Profiles define domain-specific payload conventions for the `event` object (and optional additional top-level fields where the core schema allows).

## How Profiles Work

Every ASARS receipt contains two layers:

**The Attestation Envelope (universal, defined in core ASARS)**

- `receipt_id`, `timestamp_utc`, `sequence_id`
- `chain.prev_receipt_id`, `chain.prev_receipt_hash`, `chain.chain_hash`
- `attestation.simulation`, `attestation.method`, `attestation.signature`
- `payload_hash`

**The Event Payload (domain-specific, defined by profiles)**

- The `event` object content varies by profile
- All other fields remain identical to the core standard unless a profile explicitly documents an allowed extension

## Published Profiles

| Profile | Domain | Status |
|---------|--------|--------|
| [enterprise-cloud v0.1](enterprise-cloud/v0.1.json) | Cloud AI agents, CI/CD, API monitoring | Published |

## Profiles in Development

| Profile | Domain | Status |
|---------|--------|--------|
| [kinetic-uas v0.1-draft](kinetic-uas/v0.1-draft.json) | Unmanned aerial systems, autonomous kinetic platforms | Draft |
| [industrial-ros v0.1-draft](industrial-ros/v0.1-draft.json) | Factory robotics, ROS-based systems | Draft |
| [telecom-sla v0.1-draft](telecom-sla/v0.1-draft.json) | 5G SLA verification, C-V2X, URLLC | Draft |

## Contributing a Profile

If you are building in a domain not covered above, open a GitHub Issue describing your use case. Profile contributions follow the process in [CONTRIBUTING.md](../CONTRIBUTING.md).

**The attestation envelope is not modifiable.** The event payload schema (and documented extensions) is the contribution surface.
