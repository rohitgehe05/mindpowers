# Reviewer Lenses

Prompt definitions for reviewing-docs' lens panel. SKILL.md owns the process
(tier selection, the tier-3 reader-card gate, dispatch, synthesis); this file
owns what each lens is and what it is told.

## Tier table

| Tier | Templates | Lenses |
|---|---|---|
| 1 | comms-draft, talking-points | audience |
| 2 | briefing-doc, business-review, one-pager | audience + rigor |
| 3 | decision-doc, prd, framework, post-mortem, self-shape | audience + rigor + premise |

The user can override the tier for any run: "quick pass" means tier 1,
"full panel" means tier 3. Say which tier and lenses are running before
findings appear.

## What every lens receives

A lens gets ONLY:

1. The locked spec — or, when none exists, the reverse-engineered audience,
   main claim, and shape written down in Step 1.
2. The doc under review.
3. Its own lens prompt from this file.
4. The template rubric file for the doc type, when one exists
   (`skills/mindstorming/references/<type>.md`).

A lens never receives: the drafting conversation's history, another lens's
findings, or discussion from prior review rounds. On subagent-capable
clients each lens runs as a separate fresh subagent, blind to the others.
Elsewhere, see "Degraded mode".

Every lens anchors every finding to a quoted line from the doc and returns
findings only — no rewrites, no praise beyond one earned line.

## Lens: audience

Simulates the doc's actual reader, arriving cold. Prompt core:

> You are this doc's reader, arriving cold: [reader card]. First write a
> 150-250 word first-read narrative in first person — where you skim, where
> you stop, what you conclude, what you would ask out loud. Then list
> findings: what confuses, what arrives in the wrong order, what context is
> missing, where you would stop reading. Anchor each finding to a quoted
> line.

The reader card holds: role, patience level, prior beliefs, and what they
expect to decide after reading. Seed it from the spec's `audience`
frontmatter when present; otherwise from this archetype table:

| Doc type | Default reader | Reads for |
|---|---|---|
| decision-doc, business-review | Exec skeptic | "What are you not telling me? Where's the number?" |
| briefing-doc | Regulator / hostile counsel | Where does this admit more than it should, or claim more than it can back up? |
| comms-draft | Distracted skimmer | Reads only the first line of each paragraph. Does the message still land? |
| prd, framework | First-time implementer | Could I execute this with no side channel to the author? |
| talking-points | Adversarial interviewer | Which predicted question breaks the point under follow-up? |
| post-mortem | Exec skeptic | Is the root cause real or a blameless-sounding non-answer? |
| self-shape | Nearest fit, by intent | Ask the user which of the above the doc's audience most resembles. |

At tier 3, the reader card and first-read narrative are shown to the user
for correction before the rest of the panel runs (see SKILL.md Step 3).

## Lens: rigor

Audits the argument, not the reader experience. Prompt core:

> Audit this doc's reasoning against its spec. (1) Spec conformance: list
> every commitment in the spec and classify each as delivered, partial, or
> missing in the doc, with the quoted line or its absence as evidence.
> (2) Internal consistency: find any figure, date, name, or claim stated
> two different ways. (3) Evidence: find claims presented as supported that
> the doc does not actually back, and qualified claims polished into
> certainty. (4) Logic: find conclusions that do not follow from what
> precedes them. Anchor each finding to a quoted line.

## Lens: premise

Challenges the doc's frame rather than its execution. Prompt core:

> Assume the doc is well written. Challenge its premise. Is this the right
> ask, to the right audience, at the right time? What happens if nothing is
> done — does the do-nothing case beat the proposal? What would the author
> regret about this doc in six months? Is there a stronger claim the same
> evidence supports, or a weaker claim it actually supports? Anchor each
> finding to a quoted line or to a named absence.

Premise findings frequently become **User-Challenge** items in triage
(SKILL.md Step 4): they dispute the user's stated direction, so they are
never auto-resolved — they are presented with what the reviewers might be
missing and the cost if the reviewers are wrong.

## Degraded mode (no subagents)

On clients that cannot spawn subagents (Cowork, ChatGPT desktop): run the
same lens prompts sequentially in this conversation, adopting each lens's
frame fully before producing its findings, and finish each lens before
starting the next. Then state plainly in the review output, and in the
saved review file:

> Lens isolation was simulated in-conversation on this client; the
> reviewers shared context with the drafting session, so author-context
> leakage is possible.

Never claim blind review that did not happen.
