# Changelog

All notable changes to the ASARS specification are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
ASARS follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added

- **Profiles** — `profiles/` directory: domain-specific `event` payload schemas (Enterprise Cloud v0.1 published; Kinetic-UAS, Industrial-ROS, and Telecom-SLA drafts). Core attestation envelope unchanged.

### Changed

- **Profiles** — Per-profile READMEs (liability question, demarcation point, frameworks, review gates). Draft schemas add `telecom_context`, `industrial_context`, `kinetic_context`; domain enums for `event.type` where helpful; parallel fields `sla_result` / `command_disposition` while retaining core `event.outcome` (`allowed` | `blocked`).

---

## [0.1.0] — 2026-05-11

### Initial Release

First public release of the Autonomous Systems Audit Receipt Standard.

**Defines:**
- Core receipt structure with required and optional fields
- Chain linking mechanism via `prev_receipt_id`, `prev_receipt_hash`, and `chain_hash`
- Simulation disclosure requirement — every receipt must declare hardware or software attestation
- Independent verification method using standard OpenSSL
- Regulatory alignment notes for EU AI Act Article 12, NIST 800-53, CMMC 2.0, ISO 27001

**Reference implementation:**
- Residual Delta production deployment
- 1,100,000+ hardware-attested receipts generated continuously since April 13, 2026
- Infineon SLB9670 discrete TPM 2.0, ECDSA P-256, PCR-sealed

**Status:** Draft. Public comment welcome via GitHub Issues.
