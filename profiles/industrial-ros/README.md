# Industrial-ROS Profile (v0.1-draft)

**Status:** Draft — not for production. Requires validation by someone who has integrated **ROS** with **safety-critical** controls.

## Domain

Factory robotics, ROS-based industrial cells, collaborative robots, and PLC/safety-monitor-gated motion.

## Liability question

When the robot caused harm, unexpected motion, or stoppage, did the **AI issue a wrongful command**, or did the **control / safety stack fail to enforce** a correct command?

## Demarcation point

The **ROS publish / command injection** instant — observed at the message bus boundary before or as the actuator stack consumes the command (exact probe point is deployment-defined).

## What auditors need

- ROS attribution (`ros_node_name`, `ros_namespace`, `ros_topic`).
- Robot and facility identity.
- Command semantics (`command_type`, `event.type`).
- Safety monitor decision (`safety_monitor_outcome`).
- Human-in-the-loop flags and operator reference where applicable.
- SIL context where required (`iec_61508_sil_level`).
- Core `event.outcome` **allowed** / **blocked** plus **command_disposition** (`executed` / `blocked` / `escalated`) per schema.

## Governing frameworks (illustrative)

IEC 61508, ISO 10218, ISO/TS 15066, OSHA 1910.217 (US) — jurisdiction-specific mapping is deployer responsibility.

## Review gate

At least one technical review from a robotics or integration engineer with **IEC 61508** (or equivalent) experience on ROS deployments. Acknowledge reviewers in schema `notes` or this README when agreed.

Schema: [v0.1-draft.json](v0.1-draft.json).
