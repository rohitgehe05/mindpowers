# Visual Companion — Design

**Date:** 2026-08-07
**Status:** Approved (verbal), pending spec review
**Owner:** Rohit Gehe

## Problem

Mindstorming's SKILL.md already defines a "Visual Companion" offer (timing, accept/decline flow, per-question render-vs-chat judgment, render list) but says only "they render inline as artefacts" — no rendering mechanism exists. Validating-problems and reviewing-docs have the most visually structured outputs (claim ledger, line-anchored findings) and no visual offer at all.

## Decision summary

| Decision | Choice |
|---|---|
| V1 scope | All three touchpoints: mindstorming, validating-problems, reviewing-docs |
| Server source | Vendor superpowers' companion server (MIT, attribution kept) |
| Feedback loop | Clicks + chat; no structured ratings/remix in v1 |
| Session dirs | `.mindpowers/companion/` in the working folder |
| Vendored code location | `skills/_shared/companion/` |

## 1. Architecture

Vendor the 5 files from superpowers' brainstorming skill (`server.cjs` ~720 lines, `start-server.sh`, `stop-server.sh`, `frame-template.html`, `helper.js`, ~48KB total) into `skills/_shared/companion/`.

Rebranding changes (the only code changes):

- Title/header: "Mindpowers Companion"
- Env vars: `MINDPOWERS_*` (from `BRAINSTORM_*`/`SUPERPOWERS_*`)
- Remove the `primeradiant.com` logo fetch entirely — the companion is always offline; screens can contain sensitive doc content (leadership comms, OKR politics)
- Version lookup reads mindpowers' `.claude-plugin/plugin.json`
- Session path: `.mindpowers/companion/<pid>-<epoch>/` with `content/` and `state/`
- Keep the MIT copyright notice and add one attribution line to obra/superpowers in each vendored file header

Server behavior is untouched: newest-HTML-file-wins serving, fragment wrapping in the themed frame, built-in component library (option cards, mockups, pros/cons, wireframe elements), click events appended to `state/events` as JSONL, per-session key auth (timing-safe), loopback binding, idle timeout, owner-process watchdog, reconnect tombstone.

License: upstream is MIT (Jesse Vincent, 2025). Redistribution is permitted with the copyright notice preserved.

## 2. Skill wiring — three touchpoints

Shared companion rules live in ONE referenced doc (`skills/_shared/companion/COMPANION.md`), never duplicated into each SKILL.md (avoids gstack's duplicated-preamble failure). The shared rules:

- The board is the chooser; a blocking question in chat is the wait mechanism
- A typed reply always wins over a browser click
- Per-question render-vs-chat judgment (visual content renders; text-shaped questions stay in chat)
- When dialogue leaves visual territory, push a "continuing in chat" screen so stale choices aren't left on screen
- Check `state/server-info` exists and `state/server-stopped` doesn't before every push

Per-skill wiring:

- **mindstorming** — replace "they render inline as artefacts" with the real mechanism (start server per the shared doc). Offer timing, own-message rule, and render list (2x2 matrices, scoring grids, swimlane flows, comparison tables, wireframes, structure options) all unchanged.
- **validating-problems** — add the same just-in-time offer pattern (currently absent) plus one named screen: the live claim ledger (4 claims × status × as_of date), updated as the dialogue progresses.
- **reviewing-docs** — add the offer plus an annotated-doc view: findings pinned to their quoted lines, severity-colored.

## 3. Fallback ladder (multi-client)

Mindpowers targets Claude Code, Cowork, Codex, ChatGPT desktop, Cursor. Detection happens at offer time, not mid-flow, and the offer message names which mode the user will get:

1. **bash + Node available** → browser companion (full experience)
2. **Artifact/canvas-capable client, no shell** (Cowork, claude.ai) → render the same HTML screens as artifacts; choices come back via chat
3. **Neither** → text tables in chat

## 4. Feedback → calibrating

Clicks land in `state/events` (existing server behavior). When a click resolves a structure or template choice, mindstorming records it in the spec as a user decision. Calibrating may later distill repeated choices into a preference entry through its normal flow. No new file contract in v1.

## 5. Out of scope (v1)

- Structured ratings / comments / remix boards (design-shotgun-style `feedback.json` contract)
- Cross-skill pipeline dashboard (problem brief → spec → draft → review status board)
- PRD traceability panel (US→REQ→AC coverage view)
- Calibrating draft-vs-final diff view
- Any Cowork-specific artifact plumbing beyond "render the same HTML"

## Sequencing context

This is build 1 of 3 agreed in the 2026-08-07 brainstorm (order: visual companion → reviewer lenses → fact-check gate). The other two builds get their own specs.
