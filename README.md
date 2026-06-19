# ASARS — Autonomous Systems Audit Receipt Standard

**Version:** 0.2.0  
**Status:** Draft — Public Comment Welcome  
**License:** Apache 2.0  

---

## The Problem

AI systems are executing autonomous actions in production environments today. When something goes wrong — a data exfiltration, a compliance failure, an unauthorized action — one question defines the legal and regulatory outcome:

**Can you prove what the AI did, in a form that cannot be altered after the fact?**

Software logs cannot answer this question. A log file is software. Software can be modified by any process with sufficient privilege. An AI agent with root access, a compromised administrator, or a sophisticated attacker can alter or delete a software log. The modification may be undetectable.

What enterprises, regulators, and cyber insurers require is not a better log. They require a **receipt** — a record whose integrity is mathematically provable without trusting the system that produced it.

ASARS defines that receipt format.

---

## What ASARS Defines

ASARS is an open specification for cryptographically chained behavioral receipts for autonomous AI agents. It defines:

1. **The receipt structure** — what a compliant receipt must contain
2. **The chain linking mechanism** — how receipts reference each other to form a tamper-evident sequence
3. **The simulation disclosure requirement** — every receipt must explicitly declare whether it is hardware-attested or software-signed
4. **The independent verification method** — any third party can verify any receipt using standard OpenSSL with no vendor tools or vendor access

ASARS does not specify how receipts are generated. It specifies what compliant receipts must contain and how they must chain.

---

## The Core Principle

> Observability is not evidence. A record is only tamper-evident if its integrity can be verified by a party who does not trust the system that produced it.

ASARS receipts are designed to be verified by auditors, regulators, insurers, and courts using standard cryptographic tools. Verification requires trust only in mathematics.

---

## The Simulation Disclosure Requirement

Every ASARS receipt must include a `simulation` field that explicitly declares whether the receipt was signed by hardware or software.

- `"simulation": false` — the receipt was signed by hardware. The signing key is bound to a physical device and cannot be extracted by software.
- `"simulation": true` — the receipt was signed by software. The signing key exists in software-accessible memory and does not carry hardware attestation guarantees.

**No implementation may omit this field or represent a software-signed receipt as hardware-attested.**

This requirement exists because the distinction between software and hardware attestation is legally and regulatorily material. ASARS mandates honest disclosure.

---

## Independent Verification

Any ASARS v0.1 receipt signed with ECDSA P-256 can be verified using standard OpenSSL:

```bash
openssl dgst -sha256 \
  -verify public_key.pem \
  -signature receipt.sig \
  receipt.json
```

Expected output: `Verified OK`

No proprietary software. No vendor infrastructure. No vendor trust required.

---

## Reference Implementation

A reference implementation of ASARS v0.1 is in production.

- **Hardware:** Lenovo bare metal with Infineon SLB9670 discrete TPM 2.0
- **Second node:** Rocky Linux 9 (RHEL/FIPS 140-3), full enforcement mode, independently self-certified June 2026 — 25/25 checks PASS
- **Signing algorithm:** ECDSA P-256, PCR-sealed
- **Live since:** April 13, 2026
- **Receipts generated:** 5,000,000+ receipts in continuous operation (>99.999% hardware-attested; 58 software-signed receipts from early development, explicitly disclosed per `simulation` field requirement)

Any party can verify the hardware root of trust using one OpenSSL command against public files. No connection to any vendor infrastructure is required.

---

## Known Implementation Variances

Note on Reference Implementations: Early production deployments (using schema_version: "legacy-implementation-1.0") emit the method string "HMAC-SHA256-SIM". This is a legacy synonym for "HMAC-SHA256-SOFTWARE". Furthermore, these early implementations may omit the chain_hash field. This is a known variance; the core hardware/software attestation disclosures (simulation: true/false) remain strictly enforced.

**Public API summary views:** Some implementations expose a Tier 3 HTTP API that returns an attestation-focused summary — sufficient for spot verification, not a v0.1-compliant full receipt. Full receipts with chain provenance are available via Tier 2 ledger access. ASARS v0.2.0 formalizes this as distinct Summary and Full receipt profiles. See [ROADMAP.md](ROADMAP.md).

---

## Regulatory Alignment

ASARS v0.1 is designed to satisfy the tamper-evident audit trail requirements of:

- EU AI Act Article 12 — tamper-evident logging for high-risk AI systems
- NIST SP 800-53 AU-2  — event logging
- NIST SP 800-53 AU-9  — protection of audit information
- NIST SP 800-53 AU-10 — non-repudiation
- NIST SP 800-53 AU-12 — audit record generation
- CMMC 2.0 AU.L2-3.3.1 — create and retain system audit logs
- ISO 27001:2022 A.8.15 — logging

---

## Receipt Content Fields

ASARS defines the chain envelope. Implementations MAY include additional fields inside `receipt_json`. The following field is RECOMMENDED in v0.2.0:

**category** (string, RECOMMENDED)  
Classifies the event that generated the receipt. Enables audience-specific filtering without breaking chain integrity. The hash covers the full `receipt_json` including this field — chain integrity is unaffected.

Defined values:
- `agent_behavior`     — action taken by a governed autonomous agent
- `compliance_event`   — audit-relevant system event (login, privilege, config change)
- `enforcement_action` — policy decision: ALLOWED, BLOCKED, or SHADOW_BLOCKED
- `network_flow`       — packet-level allow/drop decision (XDP/NIC enforcement)
- `system_baseline`    — infrastructure process; lowest analytical priority

Implementations that do not include this field remain fully valid under v0.2.0.

---

## Schema

See [SCHEMA.md](SCHEMA.md) for field definitions and semantics.  
See [schema.json](schema.json) for the machine-readable JSON Schema.

---

## Example Receipt

See the **Enterprise Cloud** profile example [profiles/enterprise-cloud/examples/v0.1-example.json](profiles/enterprise-cloud/examples/v0.1-example.json) for a sample compliant receipt you can run through `openssl` with your key and signature files.

---

## Profiles

ASARS keeps one core attestation envelope; **profiles** document domain-specific `event` payloads (OpenAPI- and FHIR-style specialization, not separate standard versions). See [profiles/README.md](profiles/README.md).

---

## Contributing

ASARS is designed to be extensible. New domains should prefer a **profile** under `profiles/`; cross-cutting changes to the attestation envelope follow semantic versioning and the contribution process.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution process.

---

## Versioning

ASARS follows semantic versioning for the **core** specification.

- **v0.1.x** — core receipt format, chain linking, simulation disclosure, independent verification (Full Profile semantics; see [ROADMAP.md](ROADMAP.md))
- **Profiles** — domain-specific `event` payloads under `profiles/` evolve on their own lifecycle; a new profile does not constitute a new ASARS version
- **v0.2.0 (June 2026)** — tiered receipt profiles: **Summary Profile** (attestation + event, spot verification) and **Full Profile** (v0.1 envelope with chain provenance). Does not weaken v0.1; makes the tiered access model a standards feature. See [ROADMAP.md](ROADMAP.md)

---

## Changelog

**v0.2.0 (June 2026)**
- Added RECOMMENDED `category` field for event classification and audience-specific filtering
- Added NIST SP 800-53 AU-2 and AU-12 to regulatory alignment
- Updated receipt count to 5M+ across two independently certified nodes
- Added Rocky Linux 9 / FIPS 140-3 second node to reference implementation

**v0.1.0 (April 2026)**
- Initial release: core receipt chain, hardware attestation, simulation disclosure requirement, independent verification method

---

## License

Apache 2.0. See [LICENSE](LICENSE).
