# Enterprise Cloud Profile (v0.1)

**Status:** Published (payload aligns with core ASARS v0.1).

## Domain

Cloud-deployed AI agents, CI/CD automation, API egress monitoring, and enterprise enforcement of data-access boundaries.

## Liability question

Did the agent access, transmit, or modify data or network resources it was not authorized to touch?

## Demarcation point

The **network syscall** (or equivalent kernel-visible attempt) — the moment the agent tries to establish a connection or open a path to a destination.

## What auditors need

- Which process/chain produced the attempt (`agent_identity`, ancestry).
- Destination (`destination_ip`, `destination_port`, `destination_hostname` when available).
- Policy result (`outcome`: allowed / blocked).
- Timing and observation layer (`timestamp_utc`, `latency_ns`, `observation_layer`).

Machine schema: [v0.1.json](v0.1.json) (references core [schema.json](../../schema.json)).

## Governing frameworks (illustrative)

EU AI Act Article 12 (tamper-evident logging), NIST SP 800-53 AU family, CMMC 2.0 AU controls, SOC 2 Type II audit evidence for access monitoring.

## Review before envelope changes

None required for v0.1 payload — this profile tracks the existing published core event shape. Non-draft **profile** revisions only; core semver follows the main specification.
