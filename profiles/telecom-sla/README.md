# Telecom-SLA Profile (v0.1-draft)

**Status:** Draft — not for production. Co-developed with **Attesta Edgeflow** for experiment-driven receipts (e.g. Curiosity Lab). Fields must be validated against live RAN/core telemetry before publication.

## Domain

5G network SLA verification, C-V2X, URLLC-oriented edge measurement — attributing failures between **AI/control-plane decisions** and **network delivery** against a **contractual or GSMA-referenced SLA**.

## Liability question

When the autonomous or edge system failed, was the failure caused by the AI’s decision or by the network failing to deliver within its committed SLA?

## Demarcation point

The observable instant at or beyond the user plane path (conceptually: packet/session treatment at the **UPF / N3–N6 boundary** or equivalent measurement point defined by the deployment) where latency, loss, or jitter is measured against the SLA.

## What auditors need

- Session / tunnel correlation (**TEID** or deployment-equivalent identifier).
- Measured KPIs vs thresholds (latency, loss, jitter).
- NEST / slice / service class (e.g. eMBB, URLLC, V2X) aligned to GSMA NG.116 vocabulary where applicable.
- Linkage to a correlated AI or control receipt when both exist (`correlated_receipt_id`).
- Core `event.outcome` **allowed** / **blocked** plus **sla_result** (`sla_met` / `sla_breach`) for domain semantics (see schema).

## Governing frameworks (illustrative)

GSMA BCE 2.0, GSMA NG.116, 3GPP TS 28.552 and related 5G management / KPI specifications — exact clause mapping is implementation responsibility.

## Review gate

Minimum: working session with **Attesta Edgeflow** confirming TEID (or equivalent), NEST type, NG.116 attribute identifiers, and measurement semantics match production experiment wiring.

Schema: [v0.1-draft.json](v0.1-draft.json).
