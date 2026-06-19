# ASARS Roadmap

This document describes planned evolution of the core specification. **ASARS v0.1 is unchanged** — it remains the rigorous, audit-grade receipt format.

---

## v0.1 (Current) — Full Receipt Standard

v0.1 defines a **complete compliant receipt**: attestation envelope, simulation disclosure, event payload, and **chain provenance** (`prev_receipt_id`, `prev_receipt_hash`, `chain_hash`). This is required for chain-continuity verification, legal hold, and controls such as NIST SP 800-53 AU-9.

Implementations may expose a **summary view** over HTTP (attestation and event fields only) for spot verification. That view is not a v0.1-compliant receipt; it is an intentional, documented subset. See implementation documentation for Tier 3 summary view behavior.

---

## v0.2 (Planned) — Tiered Receipt Profiles

v0.2 will formalize the tiered access model as first-class **receipt profiles** — not a weakening of v0.1, but explicit naming of two conformance levels:

### ASARS Summary Profile

- **Purpose:** Lightweight verification and Ring-3 AI governance tooling integration.
- **Contents:** Attestation fields (`simulation`, `method`, `signature`, optional `pcr_sealed`) and `event` payload sufficient for spot verification of a single receipt.
- **Omits:** Chain block (`prev_receipt_hash`, `chain_hash`) — a verifier cannot independently prove chain continuity from a Summary Profile receipt alone.
- **Use when:** Public HTTP APIs, dashboards, and integrations that verify individual receipt signatures without full ledger access.

### ASARS Full Profile

- **Purpose:** Audit-grade chain continuity and regulatory evidence.
- **Contents:** Everything in v0.1 today — Summary Profile fields plus required chain provenance.
- **Use when:** Tier 2 ledger access, legal hold, FedRAMP assessors, CMMC auditors, and any workflow requiring tamper-evident sequence proof.

### Why v0.2, not v0.1?

v0.1 establishes the rigorous internal and audit standard. v0.2 adds a documented lightweight entry point so external adopters can implement ASARS incrementally without treating chain fields as optional in the core spec. Standards propagate when there is a clear on-ramp; audit buyers still require the Full Profile.

---

## Out of Scope for v0.2

- Removing or demoting chain provenance from audit-grade receipts (that would be a downgrade).
- Changing simulation disclosure requirements.
- Replacing domain profiles under `profiles/` — those remain orthogonal to Summary vs Full receipt profiles.

---

## Feedback

Open a GitHub Issue on [asars-standard/spec](https://github.com/asars-standard/spec) to comment on v0.2 direction before draft publication.
