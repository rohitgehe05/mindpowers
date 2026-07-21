# One-Pager Template

For pitching one direction and getting fast alignment before investing in a full spec. New initiative charters, cross-team asks, "should we even do this" buy-in. Sometimes labeled BRD when the ask needs a heavier business case for finance or leadership sign-off — same shape, more depth, not a different document.

**Not decision-doc:** decision-doc weighs 2-3 live options and argues for one; use it any time there's a real menu on the table, even for an early build-vs-buy lean. One-pager already has its direction chosen and pitches it for a yes/no — that's a genre difference (the reader is asked to *approve*, not *choose*), not a rigor difference, so it doesn't collapse into decision-doc the way BRD collapsed into this template. The two share scene-setting mechanics on purpose — Background ≈ Context, One-line framing/Ask ≈ Decision required/Recommendation — because every pre-alignment doc needs the same framing move before its pitch; what differs is what the reader does with it.

**Not prd:** prd specs how to build what this got a yes on — user flows, acceptance criteria, build-ready detail. One-pager stops at direction.

## Optional problem brief input

A one-pager may consume a supplied or topic-matched brief from `docs/mindpowers/problems/YYYY-MM-DD-<slug>.md`. The brief is optional: when none exists, use the normal elicitation flow and do not require validation first.

Read a relevant brief before elicitation. Use settled facts instead of asking for them again, and ask only for inputs that remain missing or unresolved. Preserve each claim's evidence status: state `supported` claims only within their recorded scope, keep `partially-supported` qualifications intact, discuss `unsupported` claims only as hypotheses, and warn and require reframing before using a `contradicted` claim as the pitch premise. Validation does not imply prioritisation, approval, or permission to build.

When a brief is used, the one-pager spec must link it in frontmatter:

```yaml
problem: docs/mindpowers/problems/YYYY-MM-DD-<slug>.md
```

## Sections

| Section | What goes here |
|---|---|
| One-line framing | For [audience], [problem], we propose [direction] — unlike [status quo]. Forces the pitch into one sentence before any prose. |
| Background | 2-4 bullets. Context a reader needs to follow the problem; cite prior art or competitor moves if the direction draws on them. Resist over-explaining. |
| Problem | The pain, concrete. Why now. When a problem brief is used, preserve its recorded scope, evidence status, limitations, and `as_of` date. |
| Goal | What "solved" looks like. Include a metric if one honestly exists; don't force false precision. |
| Proposed direction | The one direction you're pitching, not a menu. High-level shape, enough to react to, not enough to build from. No user flows, no acceptance criteria, no options-with-trade-offs. |
| Key principles | Non-negotiables the direction must respect. Stand-in for formal non-goals. |
| Ask | The specific yes/no you need, and from whom. Not "let's discuss." |
| Open questions | What's unresolved, to be answered in the PRD if this proceeds. |
| Stakeholders (add if the ask needs multiple sign-offs) | Who decides, who's consulted. |
| Rough milestones (BRD-weight only, add if leadership wants a timeline sense) | Directional, not commitments. |

## Elicitation prompts

These prompts are a coverage guide, not a script. If a problem brief settles a prompt, carry that answer forward and skip the question. Do not ask the user to restate the brief.

When self-shaping, one at a time:

1. One sentence: for whom, what problem, what direction, unlike what today?
2. Is there one direction here, or are you still weighing live alternatives against each other? (Weighing alternatives — even "build vs. buy" — is decision-doc, not this template.)
3. What's the background a reader needs before the problem makes sense — any prior art or competitor moves worth citing?
4. What's the problem, concretely, and why does it matter now?
5. What does "solved" look like? Is there a real metric, or is it directional?
6. What direction are you leaning, at a level someone could react to (not build from)?
7. What are the non-negotiables this direction has to respect?
8. What's the exact ask, and from whom?
9. Is this a quick gut-check, or does the ask need BRD-weight (stakeholders, milestones, heavier business case) for sign-off?

When a template match is suspected (user said "one-pager", "BRD", "pitch for X", "need buy-in on"), batched:

> "Quick frame: do you have one clear direction or are you still weighing options, what's the one-sentence pitch, what's the problem, what does solved look like, and what's the exact ask?"

## Standards baked in

- **Problem before direction.** Same discipline as prd, applied one stage earlier.
- **One-line framing forces the clarity test.** If it can't compress to one sentence, the pitch isn't ready.
- **Direction, not spec.** No user flows, acceptance criteria, or build-ready detail — that's what a PRD is for, after this earns a yes.
- **One direction, not options.** Enforced above, not just asserted: elicitation prompt 2 gates it, and the Proposed direction cell rules out options-with-trade-offs. A menu is a decision-doc, even at the earliest single-lean stage of a build-vs-buy call.
- **Ask stated explicitly.** Name the yes/no and the decision-maker, not "thoughts welcome."
- **Weight scales to stakes, not habit.** Default is the eight unconditional sections (framing, background, problem, goal, direction, principles, ask, open questions). Multi-team or budget asks pull in stakeholders and milestones (BRD-weight) — don't add them out of habit.
- **Source attribution where applicable, via Background.** If the direction draws on prior art, competitor moves, or an existing framework, cite it there (elicitation prompt 3) — not a separate section.

## Anti-patterns

- Writing a spec disguised as a pitch (user flows, edge cases, acceptance criteria) — that's a PRD, and reaching for it here means the buy-in step got skipped
- Presenting 2-3 options with trade-offs instead of one direction — that's a decision-doc, even if the options are just "build" vs "buy"
- Padding with architecture or process detail nobody asked for, to look thorough
- A vague ask ("let's discuss", "thoughts?") instead of a named yes/no
- Skipping the problem because it feels obvious to the author
- No signal at all of what "solved" looks like, because "it's just a one-pager"
- Reaching for BRD-weight (stakeholders, milestones) on a pitch that only needed the default frame
