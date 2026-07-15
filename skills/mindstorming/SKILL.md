---
name: mindstorming
description: Use before drafting any non-code knowledge-work deliverable, including strategic memos, business reviews, OKR defences, PRDs, decision docs, briefing docs, exec talking points, Slack messages to leadership, frameworks, post-mortems, one-pagers, BRDs. Triggers on asks like "help me write up X", "draft this memo", "what should I say to Y", even casually phrased. NOT for software implementation; for creating features, components, or code changes use superpowers:brainstorming instead; for authoring the PRD document itself, use this skill. For non-code deliverables this skill supersedes generic brainstorming. Do not skip for simple asks; simple tasks hide the costliest assumptions.
---

# Mindstorming: Brainstorming for Knowledge Work

## Overview

mindpowers does one loop: shape, draft, review, and remembers what you like. This skill is the "shape" step.

Help turn rough ideas into locked specs for knowledge-work deliverables (memos, business reviews, decision docs, PRDs, briefing docs, comms, frameworks, talking points, post-mortems) through Socratic dialogue.

The skill enforces two approval gates: a verbal section-by-section approval during dialogue, and a final approval of the written spec on disk. Drafting only begins after both.

Do NOT draft any deliverable, write any prose, or otherwise produce output until you have presented a design, written it to disk, and the user has approved the written spec. This applies to EVERY task regardless of perceived simplicity.

## Anti-Pattern: "This is too simple to need a spec"

Every task goes through this process. A Slack reply, a one-paragraph note, a routine update, all of them. Simple tasks are where unexamined assumptions cause the most wasted work and miscommunication. The spec can be short (3-5 lines for trivially simple tasks), but you MUST write it and get user approval.

## The 10-Step Process

Track these steps as todos if your harness has a task list, and complete them in order:

1. **Explore context.** Check recent specs in `docs/mindpowers/specs/`, sorted by filename descending (the date prefix keeps them in chronological order); read the frontmatter of the 5-10 most recent. Also check `docs/mindpowers/preferences.md` if it exists; it holds per-template-type notes on what this user likes. Also scan legacy `docs/brainstorm/` if it exists; always write new files under `docs/mindpowers/`.
2. **Detect template match.** Does the task fit one of the 9 templates? (See "Template Selection" below.) If yes, load that template's reference file. Also classify: is this routine (a template type with prior locked specs and/or a recorded preference in `preferences.md`) or exploratory (first time, novel or personal topic)?
3. **Offer visual companion (if applicable).** Defer until the dialogue is heading into visually-shaped territory. May not happen at all for text-only tasks.
4. **Adaptive elicitation.** Batched only when template match AND routine. Otherwise one-question-at-a-time.
5. **Propose 2-3 approaches.** When self-shaping, before presenting the design, propose alternatives with trade-offs and your recommendation. (For template-matched routine tasks, this often happens inside the template's elicitation.)
6. **Present design sections.** Scaled to complexity, get verbal approval after each section. If the user rejects a structure, invoke Research as Recovery before re-proposing.
7. **Write spec to file.** At `docs/mindpowers/specs/YYYY-MM-DD-<type>-<slug>.md` with YAML frontmatter. Before writing, if the working folder is a shared or public git repo, warn the user that specs often contain sensitive content (leadership comms, OKR politics, exec briefings) and suggest adding `docs/mindpowers/` to `.gitignore` or choosing a private location.
8. **Self-review and report.** Inline check for placeholders, contradictions, ambiguity, scope creep, source attribution. Report the checklist results to the user when handing the file over.
9. **User reviews written spec.** Explicitly ask the user to read the file and approve before drafting.
10. **Type-aware handoff.** On approval, flip the spec's `status` to `locked`. For brief-style specs ask "draft now, hand back, or stop?". For spec-is-the-deliverable specs (frameworks, post-mortems) ask "stop, draft a derivative, or pause?".

## Process Flow

```
digraph mindpowers_mindstorming {
    "Explore context" [shape=box];
    "Template match?" [shape=diamond];
    "Routine vs exploratory?" [shape=diamond];
    "Self-shape" [shape=box];
    "Visual questions ahead?" [shape=diamond];
    "Offer visual companion (own message)" [shape=box];
    "Batched elicitation" [shape=box];
    "One-at-a-time elicitation" [shape=box];
    "Propose 2-3 approaches" [shape=box];
    "Present design sections" [shape=box];
    "Verbal approval?" [shape=diamond];
    "Research as recovery" [shape=box];
    "Write spec to file" [shape=box];
    "Self-review and report inline" [shape=box];
    "User reviews written spec" [shape=box];
    "Final approval?" [shape=diamond];
    "Type-aware handoff" [shape=doublecircle];

    "Explore context" -> "Template match?";
    "Template match?" -> "Routine vs exploratory?" [label="yes"];
    "Template match?" -> "Self-shape" [label="no"];
    "Routine vs exploratory?" -> "Visual questions ahead?";
    "Self-shape" -> "Visual questions ahead?";
    "Visual questions ahead?" -> "Offer visual companion (own message)" [label="yes"];
    "Visual questions ahead?" -> "Batched elicitation" [label="no, template+routine"];
    "Visual questions ahead?" -> "One-at-a-time elicitation" [label="no, exploratory or self-shape"];
    "Offer visual companion (own message)" -> "Batched elicitation" [label="template+routine"];
    "Offer visual companion (own message)" -> "One-at-a-time elicitation" [label="exploratory or self-shape"];
    "Batched elicitation" -> "Present design sections";
    "One-at-a-time elicitation" -> "Propose 2-3 approaches";
    "Propose 2-3 approaches" -> "Present design sections";
    "Present design sections" -> "Verbal approval?";
    "Verbal approval?" -> "Research as recovery" [label="rejected as too generic"];
    "Verbal approval?" -> "Present design sections" [label="no, minor revise"];
    "Verbal approval?" -> "Write spec to file" [label="yes"];
    "Research as recovery" -> "Present design sections";
    "Write spec to file" -> "Self-review and report inline";
    "Self-review and report inline" -> "User reviews written spec";
    "User reviews written spec" -> "Final approval?";
    "Final approval?" -> "Self-review and report inline" [label="no, revise"];
    "Final approval?" -> "Type-aware handoff" [label="yes"];
}
```

## Template Selection

Nine templates plus a self-shape fallback for novel tasks.

| Template | When to use |
|---|---|
| `business-review` | Weekly or quarterly product BRs. Insight before data, lowlights surfaced. |
| `decision-doc` | Strategic argument with options, trade-offs, recommendation. OKR defence, build-vs-buy, prioritisation memos. |
| `one-pager` | Pre-solution pitch for one direction, before a PRD gets written or options get formally weighed. Sometimes labeled BRD (same shape, more depth). New initiatives, cross-team asks, buy-in. |
| `prd` | Product spec. Problem framing, users, proposed solution, success criteria, open questions. |
| `briefing-doc` | Meeting prep. Topics, your positions, asks or decisions sought. Partner meetings, exec syncs. |
| `comms-draft` | Short-form internal comms. Audience, intent, key message, tone calibration. |
| `framework` | Methodology or framework documents. Principles, structure, examples. Spec-is-the-deliverable. |
| `talking-points` | Punchy anticipatory points for verbal delivery. Predicted questions and pithy responses. |
| `post-mortem` | Incident or project retro. What happened, timeline, root cause, what changes as a result. Spec-is-the-deliverable, like `framework`. |
| `self-shape` (fallback) | Anything that doesn't clearly match. Skill asks "what shape does this need?" first. |

To select the right template:

1. Examine the user's request and recent context.
2. If the language clearly matches a template (e.g., "weekly product update" implies business-review, "should we build X or buy" implies decision-doc), load that template's reference file from `references/<type>.md`.
3. If two templates could fit (e.g., a briefing doc that contains a decision), pick the one that better matches the primary deliverable shape and ask the user to confirm.
4. If genuinely novel, self-shape.

Read the matching template file from `skills/mindstorming/references/<type>.md` to load its sections, elicitation prompts, and standards. Do NOT improvise the section structure when a template exists. The templates encode learned standards; deviating loses that.

## Adaptive Elicitation

The elicitation rhythm depends on TWO axes: template match (yes/no) and topic familiarity (routine/exploratory).

**Template matches AND topic is routine** (user has done this template before, e.g. weekly BR, recurring decision doc): Use batched questions. Read the template's elicitation prompts and ask 3-5 of them in one message. Faster because the structure is known and the user is filling in known slots.

**Template matches BUT topic is exploratory** (first time using this template, novel subject, personal or unfamiliar territory): Fall back to one-question-at-a-time even though the template is loaded. Justification: batching is justified when "structure is known and user has answered similar questions before." Neither holds for exploratory topics. Better to surface the user's actual thinking through dialogue than blast through with assumed familiarity.

**No template match (self-shape):** One question per message. Multiple-choice preferred when possible. Focus on understanding purpose, audience, constraints, success criteria. Only after the shape is clear, propose 2-3 approaches with trade-offs.

**Heuristic for "routine vs exploratory":** Does `docs/mindpowers/specs/` contain a prior locked spec of this template type, or does `docs/mindpowers/preferences.md` have a recorded entry for it? Routine. Is this the first spec of this type on file, or is the subject highly personal, philosophical, or open-ended? Exploratory. This file-based check replaces guessing from conversation history, which doesn't persist across sessions. When in doubt, default to one-at-a-time, since over-batching costs more than under-batching.

Either way:

- Lead with your recommended option when proposing alternatives, then explain why
- Be ready to back up and clarify when something doesn't make sense
- YAGNI ruthlessly. Remove unnecessary sections from the spec
- Be flexible. Templates are starting points, not straitjackets. If the user wants to deviate from a template, deviate.

## Research as Recovery

When the user rejects a proposed structure as "too generic," "doesn't capture the connections," or "needs more specificity," do not just propose another variant of the same generic shape. That's the failure mode this section exists to prevent.

The right move: pause the structure decision and research adjacent existing frameworks, then return with a revised proposal informed by the research.

**When to invoke:**

- User explicitly rejects a structure (not just a small tweak)
- User asks for connections, specificity, or research-informed alternatives
- The dialogue has surfaced principles that map to known thinkers, but you haven't yet attributed or compared against established frameworks
- The proposed structure feels too clean to actually be true (often a sign of generic placeholders)

**How to invoke:**

1. Acknowledge the pushback explicitly. Name what's missing (specificity, connections, research grounding).
2. Identify 2-3 adjacent frameworks worth researching. Bias toward established sources the user is likely to recognise (e.g., for life frameworks: Naval, Housel, Stoic/Buddhist; for technical decision frameworks: established engineering principles, well-known papers; for product frameworks: pyramid principle, jobs-to-be-done, etc.).
3. Run the research. Use your web search/fetch tools, with 2-4 targeted queries.
4. Synthesise briefly: 3-5 bullets of what the research surfaced, focused on what's relevant to the user's principles.
5. Propose a revised structure that genuinely incorporates the research. Attribute sources. Show connections.
6. Re-render or re-present and ask if it lands.

**Anti-pattern:** Doing research as a stalling tactic without using it. The research must visibly shape the new proposal. If the new proposal looks the same as the old one, the research wasn't actually useful and the structure is still wrong.

## Visual Companion

**When to offer:** Defer until the dialogue is heading into visually-shaped territory. Step 3 in the process flow says "offer when upcoming questions involve visual content," and that's deliberate. Don't offer the companion before the elicitation has warmed up. Common offer points:

- Just before the structure question (frameworks, PRDs, decision-docs often need diagrams here)
- Before a comparison or trade-off question (decision matrices)
- Before a system or flow question (PRDs especially)
- When the user explicitly asks for a visual

If the dialogue stays text-shaped throughout (a comms-draft, a short briefing-doc, a routine BR), you may never offer the companion at all. That's fine.

When you do offer, this message MUST be its own turn. Do not combine with clarifying questions, context summaries, or any other content:

> "Some of what we're working on might be easier to see. I can render decision matrices, flows, comparison tables, or simple diagrams alongside our chat. Want me to use visuals where they help? They render inline as artefacts."

If the user accepts, decide per-question whether to render visually or stay in chat:

- Render visually: 2x2 matrices, scoring grids, swimlane flows, side-by-side comparison tables, simple wireframes, layered structure diagrams
- Stay in chat: requirements questions, conceptual choices, tradeoff lists, audience clarification, anything text-shaped

Acceptance does NOT mean every question goes through the visual companion. Per-question judgement applies.

## File Contract

mindpowers is one loop across four skills: shape (`mindstorming`, this skill) -> draft (`drafting`) -> review (`reviewing-docs`) -> remember (`calibrating`). All paths below are relative to the working folder (see "no filesystem / Cowork" note in "Spec File Format").

- **Specs**, written by this skill: `docs/mindpowers/specs/YYYY-MM-DD-<type>-<slug>.md`. Flat, no type subdirectories; the type lives in the filename. YAML frontmatter is authoritative (see "Spec File Format" below).
- **Drafts**, written by `drafting`: `docs/mindpowers/drafts/YYYY-MM-DD-<type>-<slug>.md`, same stem as the spec it came from, so the pair sorts together. Draft frontmatter carries `spec: <path>`, `type`, and `status: draft | final`.
- **Reviews**, written by `reviewing-docs`: `docs/mindpowers/reviews/YYYY-MM-DD-<type>-<slug>.md`.
- **Preferences**, written by `calibrating`: `docs/mindpowers/preferences.md`, entries keyed by template type.

**Status protocol:** a spec's `status` moves `draft -> locked -> (optionally) superseded`. This skill writes new specs as `draft` and flips them to `locked` on final approval. `drafting` consumes ONLY specs with `status: locked`; never draft from an unapproved spec. `reviewing-docs` can review any doc regardless of status and may recommend flipping a spec to `superseded` if it's since been reworked. `calibrating` only appends to `preferences.md`.

Also scan legacy `docs/brainstorm/` if it exists; always write new files under `docs/mindpowers/`.

## Spec File Format

Save to: `docs/mindpowers/specs/YYYY-MM-DD-<type>-<slug>.md`

Where:

- `<type>` is one of the 9 template types or `self-shape`, and lives in the filename (no subdirectories)
- `<slug>` is a short kebab-case description (e.g., `q1-product-business-review`, `vendor-selection-decision`)
- Date is the date of the brainstorming session

**Confidentiality:** these specs often contain sensitive content (leadership comms, OKR politics, exec briefings). If the working folder is a shared or public git repo, warn the user before writing and suggest adding `docs/mindpowers/` to `.gitignore` or choosing a private location.

**No filesystem / Cowork:** the paths above are relative to the working folder; in Cowork that's the user's shared folder. If no writable folder exists, present the full spec in chat (or as an artifact) instead, and say plainly that it was NOT saved to disk. Still require explicit approval of that written spec before drafting: the approval gate doesn't relax just because there's no file.

Frontmatter:

```yaml
---
type: business-review | decision-doc | one-pager | prd | briefing-doc | comms-draft | framework | talking-points | post-mortem | self-shape
date: YYYY-MM-DD
topic: <kebab-case slug>
owner: <user name or handle>
audience: <primary audience for the eventual deliverable>
status: draft | locked | superseded
draft: <path to the drafts/ file, once one exists, optional>
---
```

Body structure depends on template (see `references/<type>.md`). For self-shape, default sections:

- Audience
- Intent or claim (one sentence)
- Key context
- Options considered (when applicable)
- Recommendation or main point
- Risks and counter-arguments
- Open questions

## Self-Review Checklist

Before showing the spec to the user, run through:

- [ ] Are there any TODO or [TBD] placeholders? Replace or flag explicitly.
- [ ] Are there contradictions between sections?
- [ ] Is the scope clear, or did it creep during dialogue?
- [ ] Is the audience explicit?
- [ ] Is the recommendation or claim crisp (one sentence if possible)?
- [ ] Are open questions surfaced rather than buried?
- [ ] For BRs, decision-docs, and one-pagers: is the insight, recommendation, or ask up front, not buried?
- [ ] When principles or claims map to existing thinkers' work, are sources attributed?

Fix issues inline before presenting. If a section needs more work, return to elicitation and ask the user.

**Reporting the review:** When you hand the spec to the user for review, list the checklist results inline so the user can see what was checked. Format: a short bulleted summary saying which items passed and which were fixed during self-review. This makes the review visible rather than implicit, and lets the user catch anything you missed.

## Handoff

The handoff prompt is type-aware. Some specs are briefs for a separate downstream deliverable (BR, decision-doc, briefing-doc, comms-draft, talking-points, prd). Some specs ARE the deliverable themselves and have no separate downstream artefact (framework, post-mortem, and any other spec-is-the-deliverable subtype). The handoff text should match.

Before presenting either handoff option below, flip the spec's `status` from `draft` to `locked`. `drafting` only reads locked specs, so this step is what makes the handoff real.

**For brief-style specs (BR, decision-doc, one-pager, briefing-doc, comms-draft, talking-points, prd):**

> "Spec approved. Want me to draft now, hand it back to you, or stop here?"

Then:

- **Draft now:** Invoke the mindpowers `drafting` skill (`skills/drafting`). It reads this locked spec and writes the deliverable to `docs/mindpowers/drafts/` using the same date-type-slug stem, with frontmatter cross-linking the two files. Exception: for short comms (a Slack message, a brief email), present the draft in chat instead and only save a file if the user wants a record. Once a draft exists, `reviewing-docs` is the natural next step if the user wants a second pass on it.
- **Hand back:** Provide the file path (or the in-chat spec, if there's no filesystem) and stop. The user will draft elsewhere.
- **Stop:** Acknowledge and end the session. The spec stays on disk for later.

**For spec-is-the-deliverable specs (framework, post-mortem):**

The spec itself is the artefact. There is no separate downstream draft. So the standard handoff doesn't fit. Instead:

> "Spec locked. For framework-style specs the spec is the deliverable. Three options: stop here (you'll refer back to the file), draft a derivative artefact from this (e.g., an annual review template, daily habit checklist, or a public-facing essay), or pause and discuss next steps."

Then:

- **Stop:** Acknowledge and end. The spec is the artefact.
- **Draft derivative:** Ask which derivative artefact, then invoke the `drafting` skill with this spec as the brief, same path convention as above.
- **Pause:** Engage in whatever follow-on discussion the user wants.

## Key Principles

- **Two approval gates.** Verbal then written. Never collapse to one.
- **One question per message when self-shaping or when the topic is exploratory.** Forces actual reflection between turns.
- **Batched questions only when template matches AND the topic is routine.** Faster when the user is filling in known slots; otherwise revert to one-at-a-time.
- **YAGNI ruthlessly.** Every section in the spec must justify its presence.
- **Lead with the recommendation.** When proposing alternatives, state your view first.
- **Incremental validation.** Present design sections, get approval before moving on.
- **Research as recovery.** When structure feedback is "too generic," research before re-proposing.
- **Source attribution.** When principles map to existing thinkers, cite.
- **Be flexible.** Go back and clarify when something doesn't make sense.

## Anti-Patterns (Never Do)

- Drafting the deliverable before the written spec is approved
- Skipping the written spec because "verbal approval was enough"
- Asking 5 questions in one message during self-shape
- Burying open questions in the body of the spec instead of surfacing them
- Reproducing the user's original request as the "claim" or "recommendation" without refinement
- Producing a spec longer than it needs to be (a Slack reply spec is 3-5 lines, not 30)
- Loading a template and ignoring its standards (e.g., putting data before insight in a BR)
