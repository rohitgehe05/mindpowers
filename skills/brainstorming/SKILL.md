---
name: brainstorming
description: You MUST use this before any substantive knowledge-work deliverable, including strategic memos, business reviews, OKR defence docs, PRDs, briefing docs, decision documents, frameworks, exec talking points, slack messages to leadership, or any communication where intent matters more than output speed. Refines rough ideas through Socratic dialogue, proposes alternatives, and locks intent in a written spec before drafting begins. Triggers whenever the user asks for help drafting, framing, or thinking through any deliverable, even casually-phrased asks like "help me write up X", "I need to send Y to leadership", "draft this for me", or "what should I say to Z". Do not skip even for tasks that seem simple. Simple tasks are where unexamined assumptions cost the most.
---

# Brainstorming for Knowledge Work

## Overview

Help turn rough ideas into locked specs for knowledge-work deliverables (memos, business reviews, decision docs, PRDs, briefing docs, comms, frameworks, talking points) through Socratic dialogue.

The skill enforces two approval gates: a verbal section-by-section approval during dialogue, and a final approval of the written spec on disk. Drafting only begins after both.

Do NOT draft any deliverable, write any prose, or otherwise produce output until you have presented a design, written it to disk, and the user has approved the written spec. This applies to EVERY task regardless of perceived simplicity.

## Anti-Pattern: "This is too simple to need a spec"

Every task goes through this process. A Slack reply, a one-paragraph note, a routine update, all of them. Simple tasks are where unexamined assumptions cause the most wasted work and miscommunication. The spec can be short (3-5 lines for trivially simple tasks), but you MUST write it and get user approval.

## The 10-Step Process

You MUST create a task for each of these items and complete them in order:

1. **Explore context.** Check files, recent specs in `docs/brainstorm/`, conversation history for relevant prior work.
2. **Detect template match.** Does the task fit one of the 7 templates? (See "Template Selection" below.) If yes, load that template's reference file. Also classify: is this routine (user has done this template before) or exploratory (first time, novel topic)?
3. **Offer visual companion (if applicable).** Defer until the dialogue is heading into visually-shaped territory. May not happen at all for text-only tasks.
4. **Adaptive elicitation.** Batched only when template match AND routine. Otherwise one-question-at-a-time.
5. **Propose 2-3 approaches.** When self-shaping, before presenting the design, propose alternatives with trade-offs and your recommendation. (For template-matched routine tasks, this often happens inside the template's elicitation.)
6. **Present design sections.** Scaled to complexity, get verbal approval after each section. If the user rejects a structure, invoke Research as Recovery before re-proposing.
7. **Write spec to file.** At `docs/brainstorm/<type>/YYYY-MM-DD-<slug>.md` with YAML frontmatter.
8. **Self-review and report.** Inline check for placeholders, contradictions, ambiguity, scope creep, source attribution. Report the checklist results to the user when handing the file over.
9. **User reviews written spec.** Explicitly ask the user to read the file and approve before drafting.
10. **Type-aware handoff.** For brief-style specs ask "draft now, hand back, or stop?". For spec-is-the-deliverable specs (frameworks, post-mortems, retros) ask "stop, draft a derivative, or pause?".

## Process Flow

```
digraph mindpowers_brainstorming {
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

Seven templates plus a self-shape fallback for novel tasks.

| Template | When to use |
|---|---|
| `business-review` | Weekly or quarterly product BRs. Insight before data, lowlights surfaced. |
| `decision-doc` | Strategic argument with options, trade-offs, recommendation. OKR defence, build-vs-buy, prioritisation memos. |
| `prd` | Product spec. Problem framing, users, proposed solution, success criteria, open questions. |
| `briefing-doc` | Meeting prep. Topics, your positions, asks or decisions sought. Partner meetings, exec syncs. |
| `comms-draft` | Short-form internal comms. Audience, intent, key message, tone calibration. |
| `framework` | Methodology or framework documents. Principles, structure, examples. |
| `talking-points` | Punchy anticipatory points for verbal delivery. Predicted questions and pithy responses. |
| `self-shape` (fallback) | Anything that doesn't clearly match. Skill asks "what shape does this need?" first. |

To select the right template:

1. Examine the user's request and recent context.
2. If the language clearly matches a template (e.g., "weekly product update" implies business-review, "should we build X or buy" implies decision-doc), load that template's reference file from `references/<type>.md`.
3. If two templates could fit (e.g., a briefing doc that contains a decision), pick the one that better matches the primary deliverable shape and ask the user to confirm.
4. If genuinely novel, self-shape.

Read the matching template file from `references/<type>.md` to load its sections, elicitation prompts, and standards. Do NOT improvise the section structure when a template exists. The templates encode learned standards; deviating loses that.

## Adaptive Elicitation

The elicitation rhythm depends on TWO axes: template match (yes/no) and topic familiarity (routine/exploratory).

**Template matches AND topic is routine** (user has done this template before, e.g. weekly BR, recurring decision doc): Use batched questions. Read the template's elicitation prompts and ask 3-5 of them in one message. Faster because the structure is known and the user is filling in known slots.

**Template matches BUT topic is exploratory** (first time using this template, novel subject, personal or unfamiliar territory): Fall back to one-question-at-a-time even though the template is loaded. Justification: batching is justified when "structure is known and user has answered similar questions before." Neither holds for exploratory topics. Better to surface the user's actual thinking through dialogue than blast through with assumed familiarity.

**No template match (self-shape):** One question per message. Multiple-choice preferred when possible. Focus on understanding purpose, audience, constraints, success criteria. Only after the shape is clear, propose 2-3 approaches with trade-offs.

**Heuristic for "routine vs exploratory":** Has the user invoked this template (or a close analogue) in the past few weeks of conversation history? Routine. Is this their first time, or is the subject highly personal, philosophical, or open-ended? Exploratory. When in doubt, default to one-at-a-time, since over-batching costs more than under-batching.

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
3. Run the research. Use web_search and web_fetch (or equivalent), with 2-4 targeted queries.
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

## Spec File Format

Save to: `docs/brainstorm/<type>/YYYY-MM-DD-<slug>.md`

Where:

- `<type>` is one of the 7 template types or `self-shape`
- `<slug>` is a short kebab-case description (e.g., `q1-product-business-review`, `vendor-selection-decision`)
- Date is the date of the brainstorming session

Frontmatter:

```yaml
---
type: business-review | decision-doc | prd | briefing-doc | comms-draft | framework | talking-points | self-shape
date: YYYY-MM-DD
topic: <kebab-case slug>
owner: <user name or handle>
audience: <primary audience for the eventual deliverable>
status: draft | locked | superseded
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
- [ ] For BRs and decision-docs: is the insight or recommendation up front, not buried?
- [ ] When principles or claims map to existing thinkers' work, are sources attributed?

Fix issues inline before presenting. If a section needs more work, return to elicitation and ask the user.

**Reporting the review:** When you hand the spec to the user for review, list the checklist results inline so the user can see what was checked. Format: a short bulleted summary saying which items passed and which were fixed during self-review. This makes the review visible rather than implicit, and lets the user catch anything you missed.

## Handoff

The handoff prompt is type-aware. Some specs are briefs for a separate downstream deliverable (BR, decision-doc, briefing-doc, comms-draft, talking-points, prd). Some specs ARE the deliverable themselves and have no separate downstream artefact (framework, and any spec-is-the-deliverable subtype like a post-mortem or retro). The handoff text should match.

**For brief-style specs (BR, decision-doc, briefing-doc, comms-draft, talking-points, prd):**

> "Spec approved. Want me to draft now, hand it back to you, or stop here?"

Then:

- **Draft now:** Write the deliverable using the spec as the brief. Apply the standards baked into the matched template (e.g., insight before data for BRs, recommendation up front for decision-docs).
- **Hand back:** Provide the file path and stop. The user will draft elsewhere.
- **Stop:** Acknowledge and end the session. The spec stays on disk for later.

**For spec-is-the-deliverable specs (framework, post-mortem, retro):**

The spec itself is the artefact. There is no separate downstream draft. So the standard handoff doesn't fit. Instead:

> "Spec locked. For framework-style specs the spec is the deliverable. Three options: stop here (you'll refer back to the file), draft a derivative artefact from this (e.g., an annual review template, daily habit checklist, or a public-facing essay), or pause and discuss next steps."

Then:

- **Stop:** Acknowledge and end. The spec is the artefact.
- **Draft derivative:** Ask which derivative artefact, then draft it using the spec as a brief.
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
