# Kinetic-UAS Profile (v0.1-draft)

**Status:** Draft — not for production. **Do not treat as final for defense deployment** without review by practitioners familiar with autonomous systems policy and safety.

## Domain

Unmanned aerial systems, unmanned ground/surface vehicles, and other **kinetic-capable** autonomous platforms where commands can produce real-world effects.

## Liability question

When a kinetic or materially consequential action occurred (or was prevented), was the targeting / actuation decision **correct under the active Rules of Engagement (RoE)** and authorization boundaries, or was there malfunction / policy violation?

## Demarcation point

The instant the autonomy stack issues or gates an **actuator command** that could initiate or continue kinetic effect — the fork between decision and physical consequence.

## What auditors need

- Platform and controller identity, platform type.
- Geospatial and kinematic state at decision time (as observed).
- RoE evidence by reference (`roe_policy_hash`, `roe_policy_version`); **never** embed classified policy text in receipts.
- RoE compliance assessment (`roe_compliance`).
- Actuator target reference, HITL authorization fields when required.
- Core `event.outcome` **allowed** / **blocked** plus **command_disposition** for domain semantics (see schema).

## Governing frameworks (illustrative)

DoD Directive 3000.09 and related U.S. DoD autonomous-systems policy, Law of Armed Conflict (LOAC), emerging LAWS / CCW discussions — field set is a **draft audit vocabulary**, not legal advice.

## Export control note

The **profile JSON and documentation** in this repository are general technical text. **Implementing** this profile on a specific weapons or defense article may implicate **ITAR**, **EAR**, or other export regimes. Organizations must perform their own classification and compliance review before deployment.

## Review gate

Do not remove draft status without review from someone with **DoD autonomous systems** or equivalent operational policy experience (names are suggestions only — relationships TBD).

Schema: [v0.1-draft.json](v0.1-draft.json).
