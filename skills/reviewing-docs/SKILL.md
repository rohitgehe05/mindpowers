---
name: reviewing-docs
description: Use when the user has a finished or near-finished document (memo, business review, PRD, decision doc, briefing, comms, framework, talking points, post-mortem) and wants it pressure-tested before it ships, such as "review this doc", "poke holes in this", "is this ready to send". Works on any doc, not just mindpowers-drafted ones. Not for code review.
---

# Reviewing Docs

## Overview

A standalone red-team pass for a finished (or nearly finished) piece of writing. It works whether or not the doc was made with mindpowers: a pasted memo, a doc someone else wrote, a file on disk, all fine. It is the "review" step of the mindpowers loop (shape → draft → review → remember), but it doesn't require the other steps to have happened.

The job is not to improve the prose. It's to find the places where the doc will get punctured in the room it's headed for, before that room punctures it: the exec meeting, the regulator's inbox, the Slack thread. Track the steps below as todos if your harness has a task list.

**When this fires:** "review this doc," "poke holes in this," "is this ready to send," "what am I missing before I ship this," or being handed a file/pasted text and asked whether it holds up. It does not fire for source code, config, or anything a code-review tool should be looking at; decline that and point at a code-review skill or tool instead.

## Step 1: Find the spec

Check the doc for a paper trail before reviewing it blind.

1. Look at the doc's own frontmatter for a `spec:` link.
2. If there's none, scan `docs/mindpowers/specs/` (and legacy `docs/brainstorm/` if it exists) for a spec with a matching filename stem or topic.

**If a spec exists:** do a fidelity check before anything else.

- Is every section the spec called for actually present in the doc?
- Did anything make it into the doc that the spec didn't scope in?
- Has the claim or recommendation drifted between spec and doc: softened, hedged, or quietly changed?

Fidelity problems are worth surfacing on their own, separate from the persona pass below, because they mean the doc stopped tracking its own plan somewhere along the way.

**If no spec exists:** offer to reverse-engineer one before reviewing.

> "There's no spec for this doc. Want me to reverse-engineer one first, covering the audience, the claim, and the structure this doc implies, so we can check it says what you meant it to say? Takes about two minutes."

This is worth doing even when it feels like a formality: it's often where the real problem surfaces, because writing down "here's the claim this doc is actually making" tends to expose that the claim isn't the one the author intended. A doc that reads fine sentence-by-sentence can still imply a claim nobody signed up for once you state it plainly. If the user declines, proceed straight to the template rubric and persona pass without it.

Either way, don't skip Step 1 to save time. A doc that fails its own spec is a different, more useful finding than a doc that merely reads weak; surface it first so the rest of the review has the right frame.

## Step 2: Load the template rubric

1. Identify the doc's type from its content and shape (business review, decision doc, PRD, briefing doc, comms draft, framework, talking points, post-mortem) or from its frontmatter `type:` field if present.
2. Load `skills/mindstorming/references/<type>.md`.
3. Treat that file's **Standards baked in** and **Anti-patterns** sections as the objective rubric, not your own taste. Check the doc against them directly (e.g., for a decision doc: is the recommendation up front? Is a real counter-argument engaged, or a strawman?).
4. If the doc doesn't match any of the eight templates, treat it as self-shape: there's no reference file to load, so the rubric is whatever structure the (reverse-engineered or real) spec implies, plus general clarity and completeness.

Do not invent a rubric when a template exists. The template encodes standards someone already learned the hard way; skipping it means re-deriving from scratch and probably missing something the template would have caught.

For example: a decision doc gets checked against `decision-doc.md`'s standards directly: is the recommendation in the first section rather than the last, is there a real counter-argument rather than a strawman, is the ask explicit. A comms draft gets checked against `comms-draft.md`: is the key message identifiable on a skim, is the tone calibrated to the stated audience. Use the rubric file's own language when naming a finding; don't paraphrase a standard into something vaguer than the template already made it.

## Step 3: Persona pass

Pick exactly one persona based on the doc type and read the doc as that person would, adversarially.

| Doc type | Persona | Reads for |
|---|---|---|
| `decision-doc`, `business-review` | Exec skeptic | "What are you not telling me? Where's the number?" |
| `briefing-doc` | Regulator / hostile counsel | Where does this admit more than it should, or claim more than it can back up? |
| `comms-draft` | Distracted skimmer | Reads only the first line of each paragraph. Does the message still land? |
| `prd`, `framework` | First-time implementer | Could I actually execute this from what's written, with no side channel to the author? |
| `talking-points` | Adversarial interviewer | Which predicted question actually breaks the point under follow-up? |
| `post-mortem` | Exec skeptic | Is the root cause real or is this a blameless-sounding non-answer? |
| self-shape | Nearest fit, by intent | Ask the user which of the above the doc's audience most resembles. |

Run the whole doc through that one persona. Don't rotate personas mid-review; a single sharp lens beats several shallow ones. Say which persona you're using before giving findings, so the user knows what lens produced them (e.g., "reading this as the skeptical exec who wasn't in the room").

**Talking-points live drill (optional):** for talking-points docs specifically, offer a live drill after the written review.

> "Want to drill this out loud? I'll ask the predicted questions one at a time as the interviewer, you answer, and I'll score each answer against the prepared point and help sharpen it."

If accepted, ask one predicted question at a time, wait for the user's spoken answer, then score it (does it land the prepared point, does it survive a follow-up) and suggest a tighter version before moving to the next question.

## Output

Produce findings, not a rewrite.

- Rank findings by severity: **blocker** (this will get called out and the doc won't survive it as-is) → **weakens** (undercuts the doc but survivable) → **polish** (worth fixing, not urgent).
- Every finding anchors to a **quoted line** from the doc; don't describe a problem in the abstract, point at the sentence.
- Every finding carries a **suggested fix**: a direction, not necessarily rewritten prose.
- Cap it at the **top 8 findings**, ranked. This is a red-team pass, not a laundry list; if there are 20 problems, surface the 8 that matter most and say so.
- One line of praise is fine if genuinely earned. No more than one line, and don't lead with it.

Format each finding roughly like this:

> **[blocker] "the recommendation is to consolidate vendors over the next two quarters"**: no number attached to the savings this is supposed to justify. An exec skeptic asks "how much, exactly" in the first thirty seconds. Fix: attach the estimated savings range and the confidence behind it, even a rough one.

If there are zero findings above "polish," say that plainly instead of manufacturing minor nitpicks to fill out a list; a clean doc is a valid outcome.

**Saving the review:** per the file contract, save to `docs/mindpowers/reviews/YYYY-MM-DD-<type>-<slug>.md`, using the same stem as the doc/spec it reviewed so the pair sorts together. Exception: if the doc is a short comms piece (Slack message, brief email), present the findings in chat only; don't write a file for something that was never going to be filed itself.

**If the spec itself was wrong:** when the fidelity check or persona pass reveals that the problem traces back to the spec (wrong audience, wrong claim, wrong structure from the start, not just an execution slip), say so plainly and recommend flipping that spec's `status` to `superseded`, then rerunning mindstorming on the delta rather than patching the draft in place.

## Cowork / no-filesystem fallback

Paths above are relative to the working folder; in Cowork that's the user's shared folder. If no writable folder exists, present the full review in chat (or as an artifact) and say plainly it was not saved to disk.

## Rules

- Never rewrite the doc wholesale. That's drafting's job; offer to hand it to drafting instead of doing it here.
- At most the top 8 findings, ranked by severity. Not exhaustive, not a laundry list.
- Praise is allowed, capped at one line.
- Always name which persona you're reading as before giving findings, so the user knows the lens.
- If asked to review code, decline and point at a code-review tool instead; this skill is for prose deliverables.
