# Contributing to ASARS

ASARS is an open specification. Contributions that extend the standard for specific deployment contexts are welcome.

---

## What ASARS Is

ASARS defines a receipt format. It does not specify implementation. Any system that produces receipts conforming to the schema is ASARS-compatible regardless of how those receipts are generated.

---

## How to Contribute

### Reporting Issues

Use GitHub Issues to report ambiguities, errors, or gaps in the specification.

### Proposing domain extensions (profiles)

Most domain specialization should ship as an **ASARS profile** — a JSON Schema under `profiles/` that documents `event` payload conventions while inheriting the core attestation envelope via `$ref` to [schema.json](schema.json). See [profiles/README.md](profiles/README.md).

To propose a profile:

1. Open a GitHub Issue describing the use case and deployment context
2. Explain what `event` fields (or documented optional top-level fields) the profile adds and why they are necessary
3. Provide at least one example receipt that conforms to the core schema and illustrates the profile payload
4. Reference any existing standards or specifications the profile aligns with

Profiles must not redefine or contradict the core attestation fields (`chain`, `attestation`, `payload_hash`, simulation disclosure, and so on).

### Proposing core (envelope) changes

Changes that alter the universal attestation envelope — for example new required top-level fields — are **core specification** changes and follow semantic versioning (future v0.2+), not the profile path.

To propose a core change:

1. Open a GitHub Issue with the motivating production or regulatory requirement
2. Explain why a profile cannot satisfy the need
3. Provide migration and verification considerations

Extensions must not conflict with existing core semantics. The `additionalProperties: true` setting in the JSON schema intentionally allows experimental payload fields while profiles document the intended shapes.

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
