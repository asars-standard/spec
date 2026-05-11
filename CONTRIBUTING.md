# Contributing to ASARS

ASARS is an open specification. Contributions that extend the standard for specific deployment contexts are welcome.

---

## What ASARS Is

ASARS defines a receipt format. It does not specify implementation. Any system that produces receipts conforming to the schema is ASARS-compatible regardless of how those receipts are generated.

---

## How to Contribute

### Reporting Issues

Use GitHub Issues to report ambiguities, errors, or gaps in the specification.

### Proposing Extensions

ASARS v0.1 defines the core receipt format. Extensions for specific deployment contexts — 5G SLA verification, multi-agent session framing, enterprise enforcement events, GRC platform ingestion formats — will be considered for v0.2.

To propose an extension:

1. Open a GitHub Issue describing the use case
2. Explain what fields the extension adds and why they are necessary
3. Provide at least one example receipt using the proposed extension fields
4. Reference any existing standards or specifications the extension aligns with

Extensions must not conflict with core v0.1 fields. The `additionalProperties: true` setting in the JSON schema intentionally allows extensions.

### Compatible Implementations

If you have built or are building a system that produces ASARS-compatible receipts, open an issue to be listed as a compatible implementation. Compatible implementations strengthen the standard.

---

## Design Principles

Any proposed change to ASARS must be consistent with the following principles:

**1. Independent verification.** Any party must be able to verify any receipt using standard open-source tools without vendor access.

**2. Honest disclosure.** The simulation field is not optional. Any change that weakens the simulation disclosure requirement will not be accepted.

**3. Minimal specification.** ASARS specifies outputs, not implementations. Changes that constrain implementation choices without improving verifiability will not be accepted.

**4. Regulatory alignment.** ASARS is designed to satisfy the evidentiary requirements of EU AI Act Article 12, NIST 800-53 AU controls, and CMMC 2.0 AU controls. Changes that compromise this alignment will not be accepted.

---

## Code of Conduct

This project follows standard open source community norms. Be direct. Be honest. Focus on the technical merit of proposals.
