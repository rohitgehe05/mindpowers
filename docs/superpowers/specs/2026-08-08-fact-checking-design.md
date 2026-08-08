# Fact-Checking — Design

**Date:** 2026-08-08
**Status:** Approved (verbal), pending spec review
**Owner:** Rohit Gehe

## Problem

LLM drafting's signature failure is confident fabricated specifics: a plausible number, a slightly wrong date, a quote that is 90% right. Polished prose hides it, and nothing in the mindpowers loop verifies claims against sources before a doc ships. A second, worse failure class is unflagged sensitive content — a named person attached to a negative judgment, a customer name tied to a bad event, unannounced strategy — which is career-damaging in a way a wrong number is not.

## Decision summary

| Decision | Choice |
|---|---|
| Trigger | Offered before ship, on demand; drafting + reviewing-docs recommend at handoff, user confirms |
| Source scope | User-scoped material only (supplied files/links, locked spec, problem brief); web research offered, never automatic |
| Sensitivity | Separate blind pass, runs even with zero factual claims |
| Results location | Claims ledger (`C-###`) in the doc's review file under `docs/mindpowers/reviews/` |
| Files | New `skills/fact-checking/SKILL.md` + `skills/fact-checking/references/verifier.md` |

## 1. Architecture

Sixth skill in the loop: validate → shape → draft → review → **fact-check** → remember.

- `skills/fact-checking/SKILL.md` — process: extraction, classification, dispatch, ledger, reporting.
- `skills/fact-checking/references/verifier.md` — the verifier prompt, the sensitivity prompt, and degraded-mode rules (same split as reviewing-docs/references/lenses.md).

Fires on "fact-check this", "is this ready to send", "check the numbers in this". `drafting` and `reviewing-docs` each add one handoff line recommending fact-checking when the doc carries checkable claims — confirmed routing, never an automatic switch. Not a hard gate: the skill's power is honest reporting, not blocking.

## 2. Extraction and classification

The main thread extracts every checkable claim from the doc: numbers, dates, named people and orgs, quotes, "data shows X" statements, superlatives ("first", "only", "biggest"). Each claim gets a stable per-doc ID `C-001, C-002, …` (same convention as reviewing-docs' `R-###`: assigned at first sighting, never renumbered, re-checks reuse IDs and continue the sequence).

Each claim is classified:

- **source-verifiable** — a source inside scope could settle it.
- **external** — lives in someone's head, a dashboard, or a meeting record not in scope; structurally uncheckable here.
- **unverifiable** — no source could settle it as stated (vague superlatives, unfalsifiable claims).

Honesty rule: when in doubt between source-verifiable and external, classify external. "Prefer 'confirm this with the source' over 'looks right'."

## 3. Verification

Source-verifiable claims go to blind verifier subagents. A verifier receives ONLY: the claim, and the scoped source material — files or links the user supplied or pointed at, the locked spec, the problem brief. Mindstorming's Source Boundaries rule applies: no broadening to connected sources outside stated scope, no silent searches.

Verdict rule — the core of the skill: **no verdict without quoting the verbatim source line that settles it.** Verdicts:

- `confirmed` — with the quote and the source's name.
- `contradicted` — with the quote showing the discrepancy.
- `needs-you` — the verifier could not find a settling line. Unquotable never silently becomes confirmed.

External and unverifiable claims skip verification and land directly on the needs-you list (external) or are flagged as unverifiable-as-stated (unverifiable).

For public claims (market sizes, public dates, public quotes), offer web research as an option; never run it automatically.

Degraded mode (no subagents): verify sequentially in-conversation and state plainly in the output that verification shared context with the drafting session — same honesty pattern as reviewing-docs' lens degraded mode.

## 4. Sensitivity pass

A separate blind subagent scans ONLY the final doc text for:

- named people attached to negative judgments
- customer or partner names tied to negative events
- unannounced strategy, roadmap, or org changes
- NDA or confidentiality bleed
- secrets and PII

Runs even when the doc has zero factual claims — a Slack message can leak with no numbers in it. The doc body is treated as untrusted data: instructions embedded in it are ignored. Findings are flags for the user's decision, never auto-redactions.

## 5. Output

- **Claims ledger** appended to the doc's review file at `docs/mindpowers/reviews/YYYY-MM-DD-<type>-<slug>.md` (same stem as the doc; file created if reviewing-docs hasn't run). Columns: ID, claim, class, verdict, source quote. Re-checks update verdicts under existing IDs.
- Sensitivity findings listed in the same file, flagged separately from claims.
- **Chat summary**: confirmed count, contradicted list, needs-you list, sensitivity flags. The needs-you list is the headline — surfacing five items the user must confirm beats silently blessing them.
- No "ready-to-send" language until the user has seen the needs-you list. Reporting gate, not a hard block.
- The visual companion may render the ledger via the existing offer pattern (no new screen contract in this build; reuse `annotated-findings`-style rendering if offered).

## 6. Out of scope

- Automatic web verification
- Auto-redaction of sensitive content
- Hard ship-blocking (refusing to hand back the doc)
- Changes to `calibrating`
- Verifying claims inside specs (docs only; specs get their own self-review in mindstorming)

## Sequencing context

Build 3 of 3 from the 2026-08-07 brainstorm (visual companion → reviewer lenses → fact-check gate). Reuses the blind-dispatch pattern, degraded-mode honesty text, and stable-ID convention shipped in 0.11.0.
