# ASARS v0.1 — Schema Reference

This document defines every field in the ASARS v0.1 receipt format.

---

## Top-Level Structure

An ASARS receipt is a JSON object. All fields listed as required must be present in every compliant receipt.

---

## Fields

### `receipt_id`
**Type:** string (UUID v4)  
**Required:** yes  

A unique identifier for this receipt. Must be a UUID v4. Used to reference this receipt in subsequent receipts via `prev_receipt_id`.

---

### `schema_version`
**Type:** string  
**Required:** yes  
**Value:** `"0.1.0"`  

The ASARS schema version this receipt conforms to. Must be present to allow version-aware verification tooling.

---

### `timestamp_utc`
**Type:** string (ISO 8601)  
**Required:** yes  

The timestamp at which the receipt was generated, in UTC, formatted as ISO 8601. Example: `"2026-04-13T14:22:01.847Z"`

---

### `sequence_id`
**Type:** integer  
**Required:** yes  

A monotonically increasing integer identifying the receipt's position in the chain. The genesis receipt has sequence_id 1. Each subsequent receipt increments by 1. Gaps in sequence_id indicate missing receipts.

---

### `observation_layer`
**Type:** string  
**Required:** yes  
**Recommended values:** `"kernel_syscall"`, `"kernel_lsm"`, `"userspace_proxy"`, `"network_tap"`  

Identifies the architectural layer at which the observed event was captured. This field allows verifiers to assess the tamper-resistance properties of the observation mechanism. Kernel-layer observations have different trust properties than userspace observations.

---

### `agent_identity`
**Type:** object  
**Required:** yes  

Identifies the process or agent that generated the observed event.

| Field | Type | Required | Description |
|---|---|---|---|
| `pid` | integer | yes | Process ID at time of observation |
| `process_name` | string | yes | Name of the observed process |
| `parent_pid` | integer | no | PID of the parent process |
| `parent_process_name` | string | no | Name of the parent process |
| `ancestry_chain` | array of strings | no | Full process ancestry from init to observed process |

The `ancestry_chain` field supports attribution of network events to originating agents when subprocess laundering is a concern. An agent that spawns a child process to make network connections is still attributable via this field.

---

### `event`
**Type:** object  
**Required:** yes  

Describes the observed event.

| Field | Type | Required | Description |
|---|---|---|---|
| `type` | string | yes | Event type. Recommended values: `"network_connect_attempt"`, `"network_connect_blocked"`, `"process_exec"`, `"file_access"` |
| `syscall` | string | no | The specific syscall observed. Example: `"connect"`, `"execve"` |
| `destination_ip` | string | no | Destination IP address for network events |
| `destination_port` | integer | no | Destination port for network events |
| `destination_hostname` | string | no | Resolved hostname if available at observation time |
| `outcome` | string | yes | `"allowed"` or `"blocked"` |
| `latency_ns` | integer | no | Time in nanoseconds from syscall entry to receipt generation |

---

### `chain`
**Type:** object  
**Required:** yes  

The chain linking fields that connect this receipt to the previous receipt.

| Field | Type | Required | Description |
|---|---|---|---|
| `prev_receipt_id` | string | yes | The `receipt_id` of the immediately preceding receipt. For the genesis receipt, use the string `"GENESIS"` |
| `prev_receipt_hash` | string | yes | SHA-256 hash of the complete JSON of the preceding receipt, hex-encoded. For the genesis receipt, use 64 zero characters |
| `chain_hash` | string | yes | SHA-256 of the concatenation of `prev_receipt_id` and the current receipt's `attestation.signature`, hex-encoded |

**Chain integrity rule:** If `chain_hash` in receipt N does not match the value computed from receipt N-1, the chain is broken at that point. All receipts after the break point cannot be relied upon. The break point itself is evidence of tampering or data loss.

---

### `attestation`
**Type:** object  
**Required:** yes  

The cryptographic attestation fields.

| Field | Type | Required | Description |
|---|---|---|---|
| `simulation` | boolean | yes | `false` if signed by hardware. `true` if signed by software. This field is mandatory and may not be omitted. |
| `method` | string | yes | The signing method. For hardware: `"TPM2-ECDSA-P256-PCR-SEALED"`. For software: `"HMAC-SHA256-SOFTWARE"` or `"ECDSA-P256-SOFTWARE"` |
| `signature` | string | yes | The cryptographic signature over the receipt payload, hex-encoded |
| `public_key_hint` | string | no | A short identifier for the signing key, to assist key lookup without exposing the full key |
| `tpm_manufacturer` | string | no | TPM manufacturer identifier if hardware-signed. Example: `"Infineon"` |
| `pcr_sealed` | boolean | no | `true` if the signing key is PCR-sealed to the boot state of the observation infrastructure |

**Simulation disclosure rule:** Any implementation that sets `simulation: false` when the signing key is software-accessible is in violation of ASARS v0.1. The distinction between hardware and software attestation is material to the evidentiary value of the receipt and must be disclosed honestly.

---

### `payload_hash`
**Type:** string  
**Required:** yes  

SHA-256 hash of the canonical JSON serialization of all fields except `attestation.signature` and `chain.chain_hash`, hex-encoded. This is the value over which the attestation signature is computed.

---

## Genesis Receipt

The first receipt in a chain is the genesis receipt. It differs from subsequent receipts only in its chain fields:

- `chain.prev_receipt_id` must be the string `"GENESIS"`
- `chain.prev_receipt_hash` must be 64 zero characters
- All other fields follow the standard schema

---

## Chain Gap Detection

A gap in the chain — two receipts where receipt N+2 references receipt N as its predecessor with no receipt N+1 in between — is itself evidence. Gaps may occur from:

- System downtime (expected, documented by restart receipts)
- Data loss during high-load conditions
- Tampering or deletion

ASARS-compliant implementations must record restart events as receipts so that expected gaps are distinguishable from unexpected gaps.

---

## Verification

Any ASARS receipt signed with ECDSA P-256 can be verified:

```bash
openssl dgst -sha256 \
  -verify public_key.pem \
  -signature receipt.sig \
  receipt.json
```

The public key must be obtained from the receipt producer through an out-of-band channel. ASARS does not specify key distribution. Key distribution is an implementation concern.
