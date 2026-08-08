# Reviewer Lenses — Design

**Date:** 2026-08-08
**Status:** Approved (verbal), pending spec review
**Owner:** Rohit Gehe

## Problem

`reviewing-docs` reviews from inside the conversation that produced the draft: it holds the drafting rationale in context and cannot read the doc the way the real audience does — cold. Its findings are also unnumbered, so nothing tracks fixed vs open vs regressed across review rounds, and the top-8 cap silently discards overflow findings.

## Decision summary

| Decision | Choice |
|---|---|
| Lens count | Auto by template type; user can override per run |
| No-subagent clients | Honest degraded mode — sequential fresh-eyes framing, isolation caveat stated in output |
| Finding IDs | Per-doc `R-###`, stable across rounds, never renumbered |
| Reader-model gate | Confirm reader card with user at 3-lens tier only |
| Files touched | `skills/reviewing-docs/SKILL.md` + new `skills/reviewing-docs/references/lenses.md` |

## 1. Architecture

Rewrite of `skills/reviewing-docs/SKILL.md` plus one new reference file, `skills/reviewing-docs/references/lenses.md`, holding the three lens prompt definitions so SKILL.md stays lean. No server, no scripts — pure skill files, works on every client. The existing skill's spec-finding step, template rubric loading, root-cause routing table, and Cowork fallback are retained; the single-persona pass is replaced by the lens panel, and the output format gains the findings ledger.

## 2. Lens panel

Three lenses, defined in `references/lenses.md`:

- **Audience** — builds a reader card (role, patience, prior beliefs, what they expect to decide) and writes a simulated first-read narrative from that reader's chair. Findings target comprehension: what confuses, what's out of order, what context is missing, where the reader stops reading.
- **Rigor** — argument logic, evidence gaps, internal consistency (the same figure quoted two ways), and a spec-conformance audit: every commitment in the locked spec classified delivered / partial / missing against the draft.
- **Premise** — is this the right ask, to the right audience, at the right time? What happens if nothing is done? What does the author regret about this doc in six months?

Tier by template type (user can override per run):

| Tier | Templates | Lenses |
|---|---|---|
| 1 | comms-draft, talking-points | audience |
| 2 | briefing-doc, business-review, one-pager | audience + rigor |
| 3 | decision-doc, prd, framework, post-mortem, self-shape | audience + rigor + premise |

At tier 3 only: before the panel runs, the audience lens's reader card and simulated first-read are shown to the user for correction ("Does this match your reader? Where am I wrong?"). Tiers 1–2 infer the reader from the spec's `audience` frontmatter without a gate.

## 3. Isolation

- **Subagent-capable clients** (Claude Code and similar): each lens runs as a fresh subagent given ONLY the locked spec and the draft — never the drafting conversation's history. Lenses run blind to each other.
- **Other clients** (Cowork, ChatGPT desktop): honest degraded mode. Lenses run sequentially in-conversation with an explicit fresh-eyes framing, and the review output states plainly that isolation was simulated and author-context leakage is possible. The skill never claims blind review it did not perform.

## 4. Synthesis and triage

The main thread merges lens outputs:

1. **Dedupe** overlapping findings into one finding that preserves each lens's angle.
2. **Triage** every finding into exactly one class:
   - **Mechanical** — objective defect (broken cross-reference, contradictory figures, missing spec section). Fix is obvious; presented with the fix.
   - **Taste** — judgment call (tone, ordering, depth). Presented with a recommendation, user decides.
   - **User-Challenge** — the finding disputes the user's stated direction or a locked-spec decision. Never auto-resolved; presented with "what we might be missing" and the cost if the reviewers are wrong.
3. **Disagreements** between lenses surface explicitly as disagreements, never silently averaged. The user's call is final.

## 5. Finding IDs and the ledger

- IDs are `R-001, R-002, …`, scoped to the reviewed doc, assigned at first sighting, never renumbered.
- The review file gains a findings ledger table: ID, severity (blocker / weakens / polish), lens, one-line summary, status (open / fixed / regressed / parked).
- Re-reviews of the same doc update statuses in the ledger instead of re-listing findings; a fixed finding that breaks again is marked regressed under its original ID.
- The top-8 presentation cap remains for the chat summary, but ALL findings are recorded in the review file's ledger — overflow is no longer discarded.
- The visual companion's `annotated-findings` screen uses these IDs, closing the dangling "finding ID" reference shipped in 0.10.0.

## 6. Out of scope

- Fact-check verifier machinery (build #1, next)
- Model-escalation logic for lens subagents
- Changes to `drafting` or `mindstorming`
- Changes to the talking-points live drill

## Sequencing context

Build 2 of 3 from the 2026-08-07 brainstorm (visual companion → reviewer lenses → fact-check gate). Build #1 reuses this build's fresh-context reviewer pattern and finding-ID convention.
