# Reviewer Lenses Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace reviewing-docs' single-persona pass with a blind multi-lens panel, and give findings stable per-doc IDs tracked in a ledger, per `docs/superpowers/specs/2026-08-08-reviewer-lenses-design.md`.

**Architecture:** One new reference file (`skills/reviewing-docs/references/lenses.md`) holds the three lens prompt definitions, the tier table, the reader-archetype table (moved from SKILL.md's persona table), and the degraded-mode rules. SKILL.md's Step 3 is rewritten to orchestrate the panel, a new Step 4 covers synthesis/triage, and the Output section gains `R-###` IDs and the findings ledger. Markdown only — no code, no server.

**Tech Stack:** Markdown skill files only.

## Global Constraints

- Spec: `docs/superpowers/specs/2026-08-08-reviewer-lenses-design.md`
- Finding IDs: `R-001, R-002, …` scoped per reviewed doc, assigned at first sighting, never renumbered
- Ledger columns exactly: ID, severity, lens, one-line summary, status (`open | fixed | regressed | parked`)
- Triage classes exactly: **Mechanical** / **Taste** / **User-Challenge**
- Tier table exactly: tier 1 = comms-draft, talking-points → audience; tier 2 = briefing-doc, business-review, one-pager → + rigor; tier 3 = decision-doc, prd, framework, post-mortem, self-shape → + premise
- Reader-card confirmation gate at tier 3 only
- Lenses receive ONLY: spec (or reverse-engineered stand-in), doc, lens prompt, template rubric — never chat history, never each other's findings
- Degraded mode (no subagents): sequential fresh-eyes framing; review output must state plainly that isolation was simulated
- Out of scope (spec §6): fact-check machinery, model-escalation logic, changes to drafting/mindstorming, changes to the talking-points live drill (the drill subsection stays verbatim)
- Version bumps 0.10.0 → 0.11.0 in the final task (all manifests carrying it)

---

### Task 1: Create references/lenses.md

**Files:**
- Create: `skills/reviewing-docs/references/lenses.md`

**Interfaces:**
- Produces: the file SKILL.md (Task 2) points to as `skills/reviewing-docs/references/lenses.md`, with section headings exactly: `## Tier table`, `## What every lens receives`, `## Lens: audience`, `## Lens: rigor`, `## Lens: premise`, `## Degraded mode (no subagents)`.

- [ ] **Step 1: Write the file**

Full content:

````markdown
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
````

- [ ] **Step 2: Verify**

Run: `grep -n '^## ' skills/reviewing-docs/references/lenses.md`
Expected: exactly the six headings named in Interfaces, in that order.

- [ ] **Step 3: Commit**

```bash
git add skills/reviewing-docs/references/lenses.md
git commit -m "feat: lens prompt definitions for reviewing-docs"
```

---

### Task 2: Rewrite SKILL.md Step 3 and add Step 4

**Files:**
- Modify: `skills/reviewing-docs/SKILL.md:73-94` (the `## Step 3: Persona pass` section)

**Interfaces:**
- Consumes: `skills/reviewing-docs/references/lenses.md` (Task 1) and its six headings.
- Produces: sections `## Step 3: Lens panel` and `## Step 4: Synthesis and triage`; the triage class names **Mechanical**/**Taste**/**User-Challenge** that Task 3's Output section references.

- [ ] **Step 1: Replace the Step 3 section**

Replace everything from the `## Step 3: Persona pass` heading up to (not including) the `**Talking-points live drill (optional):**` paragraph with:

```markdown
## Step 3: Lens panel

Review runs as a panel of one to three lenses, each reading the doc cold.
Load `skills/reviewing-docs/references/lenses.md` for the lens definitions,
the tier table, and the reader archetypes.

1. **Pick the tier** from the doc type using the tier table (comms-draft
   and talking-points get the audience lens only; briefing-doc,
   business-review, and one-pager add rigor; decision-doc, prd, framework,
   post-mortem, and self-shape add premise). The user can override for any
   run: "quick pass" drops to tier 1, "full panel" raises to tier 3.
2. **Tier 3 gate:** before the panel runs, build the audience lens's reader
   card and first-read narrative and show both to the user: "Does this
   match your reader? Where am I wrong?" Correct the card from their
   answer, then run the panel. Tiers 1-2 skip this gate and seed the reader
   card from the spec's `audience` frontmatter or the archetype table.
3. **Dispatch:** on clients that can spawn subagents, run each lens as a
   fresh subagent given ONLY what "What every lens receives" in lenses.md
   allows — the spec (or its Step 1 stand-in), the doc, the lens prompt,
   and the template rubric. Never the drafting conversation, never another
   lens's findings. Lenses run blind to each other. On clients without
   subagents, follow "Degraded mode" in lenses.md and say plainly in the
   output that isolation was simulated.
4. Say which tier, lenses, and isolation mode produced the findings before
   presenting them (e.g., "full panel: audience + rigor + premise, run as
   isolated subagents").

## Step 4: Synthesis and triage

Merge the lens outputs into one findings list:

1. **Dedupe.** Where lenses hit the same underlying problem, merge into one
   finding that keeps each lens's angle visible.
2. **Triage** every finding into exactly one class:
   - **Mechanical** — objective defect (broken cross-reference,
     contradictory figures, a spec section missing from the doc). Present
     with the fix.
   - **Taste** — judgment call (tone, ordering, depth). Present with a
     recommendation; the user decides.
   - **User-Challenge** — the finding disputes the user's stated direction
     or a locked-spec decision. Never auto-resolved: present it with what
     the reviewers might be missing and the cost if they are wrong.
3. **Disagreements** between lenses surface explicitly as disagreements,
   never silently averaged. The user's call is final.
```

The `**Talking-points live drill (optional):**` paragraph and its blockquote and follow-up paragraph stay exactly as they are, now at the end of Step 3.

- [ ] **Step 2: Verify**

Run: `grep -n '^## Step' skills/reviewing-docs/SKILL.md`
Expected: Step 1, Step 2, `Step 3: Lens panel`, `Step 4: Synthesis and triage` — and `grep -n 'Persona pass' skills/reviewing-docs/SKILL.md` returns nothing.

Run: `grep -c 'lenses.md' skills/reviewing-docs/SKILL.md`
Expected: 2 (the load instruction and the degraded-mode pointer).

- [ ] **Step 3: Commit**

```bash
git add skills/reviewing-docs/SKILL.md
git commit -m "feat: lens panel replaces single-persona pass in reviewing-docs"
```

---

### Task 3: Finding IDs and ledger in the Output section, Rules update

**Files:**
- Modify: `skills/reviewing-docs/SKILL.md` (the `## Output` section and the `## Rules` section)

**Interfaces:**
- Consumes: triage class names from Task 2; the `R-###` convention from Global Constraints.
- Produces: the ledger format the visual companion's `annotated-findings` screen and future re-reviews rely on.

- [ ] **Step 1: Update the Output section**

In `## Output`:

a. Replace the metadata block bullet (the one beginning "Every finding carries" is unchanged; the one beginning "Every surfaced finding classifies") and its yaml with:

```markdown
- Every finding gets a stable ID at first sighting: `R-001, R-002, …`,
  scoped to the reviewed doc and never renumbered. A re-review of the same
  doc reuses existing IDs and continues the sequence for new findings.
- Every surfaced finding classifies its root cause, recommended route, and readiness impact using this exact metadata:

  ```yaml
  id: R-001
  severity: blocker | weakens | polish
  lens: audience | rigor | premise
  triage: mechanical | taste | user-challenge
  root_cause: evidence | decision | writing | verification | preference | approval
  recommended_route: validating-problems | mindstorming | drafting | reviewing-docs | calibrating | none
  readiness_impact: blocking | non-blocking | none
  ```
```

b. Replace the top-8 cap bullet ("Cap it at the **top 8 findings**…") with:

```markdown
- Present the **top 8 findings** in chat, ranked. The saved review file
  records ALL findings in the ledger — overflow beyond the top 8 is
  recorded there, never discarded; say in chat how many more the file holds.
```

c. Update the example finding to carry its ID — replace the example blockquote's opening `> **[blocker]` with `> **[R-001 · blocker]` (rest of the example unchanged).

d. After the "**Saving the review:**" paragraph, add:

```markdown
**The findings ledger:** every review file contains a ledger table of ALL
findings for the doc, one row each:

| ID | Severity | Lens | Summary | Status |
|---|---|---|---|---|
| R-001 | blocker | rigor | Savings claim has no number attached | open |

Status is `open | fixed | regressed | parked`. A re-review of the same doc
updates statuses in this ledger instead of re-listing findings: a fixed
finding that breaks again is marked `regressed` under its original ID, and
new findings continue the ID sequence. The ledger is the durable record;
the chat summary is the view.
```

- [ ] **Step 2: Update the Rules section**

In `## Rules`:

a. Replace `- At most the top 8 findings, ranked by severity. Not exhaustive, not a laundry list.` with `- Top 8 findings in chat, ranked by severity; the review file's ledger records all of them.`

b. Replace `- Always name which persona you're reading as before giving findings, so the user knows the lens.` with `- Always name the tier, lenses, and isolation mode before giving findings, so the user knows what produced them.`

- [ ] **Step 3: Verify**

Run: `grep -n 'persona' skills/reviewing-docs/SKILL.md`
Expected: no matches (case-insensitive check too: `grep -in 'persona' …` — no matches).

Run: `grep -c 'R-001' skills/reviewing-docs/SKILL.md`
Expected: 3 (metadata yaml, example finding, ledger row).

- [ ] **Step 4: Commit**

```bash
git add skills/reviewing-docs/SKILL.md
git commit -m "feat: stable finding IDs and ledger in reviewing-docs output"
```

---

### Task 4: Release metadata 0.11.0

**Files:**
- Modify: `CHANGELOG.md` (new 0.11.0 entry at top)
- Modify: `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, `.codex-plugin/plugin.json` (version 0.10.0 → 0.11.0)

- [ ] **Step 1: Changelog**

Add at the top of `CHANGELOG.md`, matching the file's existing entry format (`## [X.Y.Z] - date` with `### Added` / `### Changed` subsections):

```markdown
## [0.11.0] - 2026-08-08

### Added

- Reviewer lens panel in `reviewing-docs`: one to three blind fresh-context
  lenses (audience, rigor, premise) tiered by document type, with a
  reader-card confirmation gate for high-stakes docs and an honest degraded
  mode on clients without subagents.
- Stable finding IDs (`R-###`) and a findings ledger in review files:
  statuses tracked across review rounds, overflow findings recorded instead
  of discarded.

### Changed

- The single-persona pass is replaced by the lens panel; persona archetypes
  now seed the audience lens's reader card
  (`skills/reviewing-docs/references/lenses.md`).
```

- [ ] **Step 2: Version bumps**

Set version `0.11.0` in `.claude-plugin/plugin.json` (top-level `version`), `.claude-plugin/marketplace.json` (`metadata.version` AND `plugins[0].version`), `.codex-plugin/plugin.json` (top-level `version`). Then check nothing was missed:

Run: `grep -rn '0\.10\.0' .claude-plugin .codex-plugin .agents 2>/dev/null`
Expected: no output.

- [ ] **Step 3: Commit**

```bash
git add CHANGELOG.md .claude-plugin/plugin.json .claude-plugin/marketplace.json .codex-plugin/plugin.json
git commit -m "chore: 0.11.0 release metadata for reviewer lenses"
```

---

## Self-review notes

- Spec coverage: §1 architecture → Tasks 1-2 file split; §2 lens panel + tiers + gate → Task 1 definitions, Task 2 orchestration; §3 isolation both modes → Task 1 "What every lens receives"/"Degraded mode" + Task 2 dispatch; §4 synthesis/triage → Task 2 Step 4; §5 IDs + ledger + cap change + companion IDs (companion section already says "and ID", now defined — no edit needed) → Task 3; §6 out of scope untouched (live drill kept verbatim in Task 2).
- Post-merge release ritual (learned from 0.10.0): after merge, tag `v0.11.0` and push the tag to trigger the release workflow. Recorded here so it isn't missed again; not a task since it happens after PR merge.
- Consistency: heading names in Task 1 Interfaces match Task 2's load instruction; triage class casing (**Mechanical/Taste/User-Challenge** prose, `mechanical | taste | user-challenge` yaml) is deliberate — prose labels vs machine field.
