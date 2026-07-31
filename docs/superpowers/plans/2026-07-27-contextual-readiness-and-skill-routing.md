# Contextual Readiness and Skill Routing Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add contextual premise checks, conditional-module recommendations, shared readiness semantics, and root-cause skill routing while preserving Mindpowers' one-question-at-a-time interaction model.

**Architecture:** Keep `mindstorming` as the shared shaping workflow and keep template-specific detail in reference files. Use temporary fresh-agent scenarios for RED-GREEN-REFACTOR evidence, then make only the instruction changes those failures justify. Preserve the existing skills as separate capabilities and add explicit handoff contracts rather than a new router skill.

**Tech Stack:** Markdown Agent Skills, YAML frontmatter, JSON plugin manifests, Bash validation scripts, Superpowers `writing-skills`

**Design spec:** `docs/superpowers/specs/2026-07-27-contextual-readiness-and-skill-routing-design.md`

---

## File Structure

### Primary behaviour files

- `skills/mindstorming/SKILL.md`: shared conversational workflow, source boundaries, premise-check routing, readiness semantics, and confirmation before skill switches.
- `skills/mindstorming/references/prd.md`: contextual triggering and recommendation of PRD conditional modules.
- `skills/drafting/SKILL.md`: preservation of provisional claims, readiness, blockers, and external-review status.
- `skills/reviewing-docs/SKILL.md`: root-cause classification and recommended skill handoffs.

### Conditional behaviour files

Modify these only when the RED baseline demonstrates the named gap:

- `skills/mindstorming/references/one-pager.md`: only if the shared `mindstorming` premise check does not preserve one-pager evidence semantics clearly enough.
- `skills/validating-problems/SKILL.md`: only if a fresh agent restarts an existing problem brief rather than resuming or updating its unresolved claim.
- `skills/calibrating/SKILL.md`: only if a fresh agent cannot compare a user-directed final artifact with the Mindpowers draft under the existing process.
- Other files under `skills/mindstorming/references/`: only when a baseline or variation test shows that the shared readiness rule cannot determine the template's consequential action.

### Documentation and release files

- `README.md`: user-facing workflow and `0.9` summary.
- `CHANGELOG.md`: `0.9.0` release entry.
- `.claude-plugin/plugin.json`: `0.9.0` version and synchronized public description.
- `.claude-plugin/marketplace.json`: both `0.9.0` version fields and synchronized public description.

### Temporary, uncommitted evaluation evidence

- `/private/tmp/mindpowers-0.9-skill-evals/red-baseline.md`
- `/private/tmp/mindpowers-0.9-skill-evals/green-results.md`
- `/private/tmp/mindpowers-0.9-skill-evals/refactor-results.md`

Do not add evaluation fixtures, field-feedback forms, generated archives, or private terminology to the repository.

---

### Task 1: Establish the RED Baseline

**Files:**
- Read: `skills/mindstorming/SKILL.md`
- Read: `skills/mindstorming/references/one-pager.md`
- Read: `skills/mindstorming/references/prd.md`
- Read: `skills/drafting/SKILL.md`
- Read: `skills/reviewing-docs/SKILL.md`
- Read: `skills/validating-problems/SKILL.md`
- Read: `skills/calibrating/SKILL.md`
- Create temporarily: `/private/tmp/mindpowers-0.9-skill-evals/red-baseline.md`

- [ ] **Step 1: Record the pre-edit revision and evaluation rubric**

Create the temporary baseline report with this header:

```markdown
# Mindpowers 0.9 RED baseline

Pre-edit revision: 71d44213dee7245f92b9c8c195307d390d32fade

## Rubric

- recommends the appropriate deliverable when the choice is consequential;
- uses one contextual question at a time for exploratory work;
- recommends validating-problems for a central unsupported problem claim;
- offers provisional continuation when validation is declined;
- does not broaden internal source search without user direction;
- recommends conditional modules after contextual evidence, not as a batch checklist;
- separates readiness from external approval;
- preserves provisional status during drafting;
- classifies review findings by root cause;
- asks for confirmation before switching skills; and
- resumes existing problem validation instead of restarting settled work.
```

Run:

```bash
rtk git rev-parse HEAD
```

Expected: one commit SHA. Replace the single revision marker in the temporary report with that exact SHA.

- [ ] **Step 2: Run baseline scenario A, unsupported central claim**

Dispatch a fresh agent with the current `mindstorming` and `one-pager` instructions and this exact scenario:

```text
You are using the current Mindpowers skills from this repository.

A user says: "I need a one-pager today proposing automated account recovery.
Leadership believes customers abandon recovery because the process is confusing,
but no customer research, support analysis, or behavioural data has been supplied.
Do not slow me down with a validation exercise. Start shaping the one-pager."

Simulate the next three assistant turns. For exploratory work, include exactly
one question per turn and provide plausible short user answers between turns.
Act as the skill would act today; do not improve the rules.
```

Record verbatim:

- whether it recommends `validating-problems`;
- whether it offers provisional continuation;
- whether it overstates the leadership belief;
- whether it asks one question per turn; and
- every rationalization for skipping validation or readiness labelling.

Expected RED signal: at least one of the validation recommendation,
provisional-continuation contract, or readiness consequence is absent.

- [ ] **Step 3: Run baseline scenario B, contextual conditional modules**

Dispatch a fresh agent with the current `mindstorming` and `prd` instructions:

```text
You are using the current Mindpowers skills from this repository.

A user needs a PRD for an account-setting change. The selected direction is
settled. The flow depends on an external eligibility service, handles sensitive
identity information, performs a completed action that cannot be reversed, and
creates a new manual appeal queue. The user says: "We are late. Ask only what
matters and do not dump a template checklist on me."

Simulate the next five assistant turns with plausible short user answers. Show
when and why any conditional PRD module is recommended. Act as the skill would
act today; do not add proposed 0.9 behaviour.
```

Record whether the agent:

- asks contextual product questions;
- presents multiple conditional modules at once;
- silently includes or omits modules;
- explains readiness consequences when a module is declined; and
- proposes a decision with trade-offs without inventing a domain answer.

Expected RED signal: a module is silently omitted/included, presented as part
of a batch checklist, or declined without a readiness consequence.

- [ ] **Step 4: Run baseline scenario C, source boundary**

Dispatch a fresh agent with the current `mindstorming` instructions:

```text
You are using the current Mindpowers skill. A connected internal drive and
internet search are available, but the user has not supplied a source or named
an internal location. The user asks for a decision document based on "whatever
evidence you can find" and says they need it quickly.

State what sources you would inspect before the first elicitation question and
write the first assistant turn. Act according to the current skill only.
```

Record whether the agent:

- searches the broad internal drive without a user-directed scope;
- offers optional internet research;
- explains that declining research leaves claims provisional; and
- asks the user to identify a relevant internal source.

Expected RED signal: the source boundary or optional-research behaviour is
ambiguous.

- [ ] **Step 5: Run baseline scenario D, provisional drafting**

Dispatch a fresh agent with the current `drafting` instructions:

```text
You are using the current Mindpowers drafting skill. The supplied spec is
locked, but its body states that the main customer claim is unsupported and
lists one unresolved decision that could change product behaviour. The user
says: "The spec is locked, so make the draft sound decisive and ready."

Explain whether you draft, what status appears in the draft, and what you report
to the user. Act according to the current skill only.
```

Record whether the agent:

- treats `locked` as proof of readiness;
- preserves unsupported claims and blockers;
- uses a provisional readiness label; and
- resists pressure to imply certainty.

Expected RED signal: lifecycle status and content readiness are conflated or
the provisional state is not carried into the draft contract.

- [ ] **Step 6: Run baseline scenario E, mixed review findings**

Dispatch a fresh agent with the current `reviewing-docs` instructions:

```text
You are using the current Mindpowers reviewing-docs skill. A PRD has four
findings:

1. its central customer claim has no supporting evidence;
2. fallback behaviour for a failed dependency is undecided;
3. the opening repeats settled context in dense prose; and
4. a required external approval is recorded as pending.

Show the review findings and the recommended next action for each. The user has
not approved switching to another skill. Act according to the current skill
only.
```

Record whether the agent distinguishes:

- evidence work from product-decision work;
- reasoning work from prose work;
- pending approval from content readiness; and
- recommendation from automatic skill invocation.

Expected RED signal: findings lack root-cause routes or everything is sent to
one skill.

- [ ] **Step 7: Run baseline scenario F, resume and calibration**

Run two fresh-agent probes:

```text
Probe 1: A current problem brief marks one central claim unsupported and all
other claims settled. The user returns from mindstorming and asks to strengthen
only that claim. Using the current validating-problems skill, explain whether
you resume the brief or restart validation.

Probe 2: The user points to a final human-edited document and its Mindpowers
draft and says, "Learn what changed for next time." Using the current calibrating
skill, explain what you compare, what you ask, and what you save.
```

Record whether either current skill already satisfies the design. A passing
probe is evidence to leave that skill unchanged.

- [ ] **Step 8: Verify RED before editing**

Summarize every observed failure and exact rationalization in
`/private/tmp/mindpowers-0.9-skill-evals/red-baseline.md`.

Do not edit production skill files unless at least one scenario fails for the
expected reason. For every scenario that passes, mark its proposed production
edit as unnecessary.

Run:

```bash
rtk git status --short
```

Expected: only the approved design spec and this plan are new; `.superpowers/`
remains untouched; no skill file is modified.

---

### Task 2: Implement Contextual Mindstorming and PRD Recommendations

**Files:**
- Modify: `skills/mindstorming/SKILL.md:22-166`
- Modify: `skills/mindstorming/SKILL.md:214-342`
- Modify: `skills/mindstorming/references/prd.md:43-198`
- Modify only if RED requires: `skills/mindstorming/references/one-pager.md:9-55`
- Test temporarily: `/private/tmp/mindpowers-0.9-skill-evals/green-results.md`

- [ ] **Step 1: Add the minimal shared interaction rules**

Make only the additions tied to Task 1 failures:

```markdown
## Source boundaries

Inspect material the user supplies, connected sources the user points toward,
and relevant workspace artifacts already inside the stated task scope. Do not
broaden an internal search merely because a connector is available.

When a decision-critical evidence gap remains and the user has not identified
another source, offer broader internet research. The offer is non-blocking. If
the user declines, continue with the claim at its honest evidence status.

## Lightweight premise check

When a deliverable depends on a customer or business problem claim, inspect
whether the problem is solution-free, who experiences it, what supports it,
what remains assumed, and whether another explanation could change the
direction.

If a central claim is unsupported or contradicted, state the evidence gap,
recommend `validating-problems`, and ask the user to confirm the skill switch.
Offer provisional continuation in the same turn. If a relevant problem brief
already exists, preserve its findings and offer to resume or update only the
material gap; do not restart or re-ask settled questions.

## Readiness and approval

Keep lifecycle status separate from content readiness. A locked spec may remain
`not-ready`; drafting may continue, but the provisional state and every material
blocker must remain visible.

A gap blocks readiness only when leaving it unresolved could materially change
what the audience decides, does, builds, measures, or understands. Keep
optional improvements as non-blocking notes.

Content readiness never implies external approval. Record an explicitly
required approval separately and never claim it was received without evidence.
```

Integrate these rules into the existing process rather than duplicating the
same text in multiple sections. Keep the actor term `user`.

- [ ] **Step 2: Make deliverable recommendations visible only when useful**

Amend Template Selection so that an ambiguous, unfamiliar, or consequential
match produces:

```text
I recommend a decision document because you are comparing live alternatives
and need a durable record of the choice. I will use that shape unless you want
a different deliverable.
```

Do not insert a confirmation turn when the requested format and outcome are
already unambiguous.

- [ ] **Step 3: Add readiness to the spec contract**

Extend the frontmatter example with:

```yaml
readiness: ready | not-ready
```

Add a body rule:

```markdown
Every `not-ready` spec names its material blockers. `status: locked` means the
user approved the working brief; it does not erase blockers or imply that the
eventual artifact is ready for its consequential action.
```

Add the approved user-facing mapping once in `mindstorming/SKILL.md`, not
repeated across every template:

```markdown
| Template | Ready label |
|---|---|
| business-review | ready-to-present |
| decision-doc | decision-ready |
| one-pager | ready-to-socialise |
| prd | build-ready |
| briefing-doc | meeting-ready |
| comms-draft | ready-to-send |
| framework | ready-to-apply |
| talking-points | ready-to-deliver |
| post-mortem | action-ready |
| self-shape | define the consequential action during elicitation |
```

- [ ] **Step 4: Replace silent PRD omission with contextual recommendation**

Keep the predicate/module table in `prd.md`, then replace the current
omit-or-ask rule with:

```markdown
Treat this table as internal coverage, not a user-facing checklist. For an
exploratory PRD, detect a possible predicate from the actual context, ask one
question about that context, and recommend the module only when the answer
confirms or leaves material uncertainty about the need.

Do not silently omit a relevant or uncertain module. Explain why it may be
needed and let the user add it, discuss it, or decline it. If declined, state
whether the missing contract blocks build readiness under the build-ready test.
```

Add one compact contextual-question table covering:

- external state/integration;
- unobservable outcome;
- difficult reversal;
- sensitive information;
- support or operating work;
- multiple decision participants; and
- probabilistic behaviour.

Use generic examples only.

- [ ] **Step 5: Add routing and confirmation principles**

Update Key Principles and Anti-Patterns in `mindstorming/SKILL.md` with these
minimal rules:

```markdown
- Recommend a skill handoff with a reason; wait for user confirmation before
  switching.
- Do not turn internal template coverage into a batch questionnaire.
- Do not silently search broad connected sources outside the user's stated
  scope.
- Do not treat `locked`, `ready`, and externally approved as synonyms.
```

- [ ] **Step 6: Validate structure**

Run:

```bash
rtk python3 -m pip install --upgrade --target /private/tmp/mindpowers-skill-validator PyYAML==6.0.3
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/mindstorming
rtk git diff --check
```

Expected:

- validator reports the skill is valid;
- diff check exits successfully;
- no organization-specific term appears in the edited skill or reference.

- [ ] **Step 7: Run GREEN scenarios A-C**

Re-run Task 1 scenarios A-C with fresh agents and the modified files available.
Record verbatim results in
`/private/tmp/mindpowers-0.9-skill-evals/green-results.md`.

Expected:

- A recommends `validating-problems` and offers provisional continuation;
- B asks contextual questions and recommends modules after the answer;
- C respects user-directed internal-source boundaries and offers optional
  internet research.

- [ ] **Step 8: Commit the verified shaping changes**

Stage only:

```bash
rtk git add docs/superpowers/specs/2026-07-27-contextual-readiness-and-skill-routing-design.md
rtk git add docs/superpowers/plans/2026-07-27-contextual-readiness-and-skill-routing.md
rtk git add skills/mindstorming/SKILL.md
rtk git add skills/mindstorming/references/prd.md
```

If `one-pager.md` changed because RED required it, stage that exact file too.
Never stage `.superpowers/`.

Commit:

```bash
rtk git commit -m "feat: add contextual mindstorming readiness"
```

Expected: one commit containing the approved spec, implementation plan, and
verified shaping changes.

---

### Task 3: Preserve Provisional Drafts and Route Review Findings

**Files:**
- Modify: `skills/drafting/SKILL.md:14-89`
- Modify: `skills/reviewing-docs/SKILL.md:16-109`
- Modify only if RED requires: `skills/validating-problems/SKILL.md:25-166`
- Modify only if RED requires: `skills/calibrating/SKILL.md:14-55`
- Test temporarily: `/private/tmp/mindpowers-0.9-skill-evals/green-results.md`

- [ ] **Step 1: Preserve readiness in drafting**

Add to the drafting input and process contract:

```markdown
A locked spec may have `readiness: not-ready`. Draft from it when the user asks,
but preserve its provisional label, evidence qualifications, blocking gaps, and
external-review status. `locked` proves approval of the working brief, not
content readiness.

Do not make prose sound certain, ready, or approved when the spec does not
support that claim. Add `readiness` to draft frontmatter and keep every material
blocker visible in the draft and handoff report.
```

Add to the self-review checklist:

```markdown
- [ ] Does the draft preserve readiness, blockers, and external-review status
      without implying unrecorded certainty or approval?
```

Add a matching anti-pattern forbidding polished false readiness.

- [ ] **Step 2: Classify review findings by root cause**

Add a root-cause table to `reviewing-docs`:

```markdown
| Root cause | Recommended route |
|---|---|
| Missing or weak problem evidence | validating-problems |
| Missing scope, product, requirement, or measurement decision | mindstorming |
| Settled reasoning expressed poorly | drafting |
| Corrected artifact needs verification | reviewing-docs |
| Stable preference revealed by final human edits | calibrating |
| External approval is pending | record it; do not switch skills |
```

Require each material finding to include:

```yaml
severity: blocker | weakens | polish
root_cause: evidence | decision | writing | verification | preference | approval
recommended_route: validating-problems | mindstorming | drafting | reviewing-docs | calibrating | none
readiness_impact: blocking | non-blocking | none
```

Keep the existing quoted-line anchor and suggested-fix requirements.

- [ ] **Step 3: Require confirmation before switching**

Add:

```markdown
Recommend the next skill and explain why. Wait for user confirmation before
switching. Carry forward the source artifact, exact finding, unresolved
question, affected section or identifier, severity, and readiness impact so the
next skill does not restart the whole workflow.
```

When several finding types coexist, recommend resolving evidence and reasoning
before prose, then re-run review.

- [ ] **Step 4: Apply conditional resume or calibration edits only if RED failed**

If Task 1 Probe 1 restarted settled validation, add to
`validating-problems/SKILL.md`:

```markdown
When a current problem brief exists, preserve its settled boundaries, evidence,
and claim statuses. Resume only the unresolved or newly disputed claim unless
the user explicitly asks to reopen the whole brief.
```

If Task 1 Probe 2 could not learn from a user-directed final artifact, add to
`calibrating/SKILL.md`:

```markdown
When the user supplies or points to both the Mindpowers draft and the final
human-edited artifact, compare them before asking questions. Ask only about
meaningful changes whose intent cannot be inferred. Record stable preferences,
not a general product evaluation, and do not ingest either artifact into a
corpus.
```

If a probe passed, leave that skill unchanged and record the no-op in the GREEN
results.

- [ ] **Step 5: Validate all modified skills**

Run the validator once for each modified skill directory:

```bash
rtk python3 -m pip install --upgrade --target /private/tmp/mindpowers-skill-validator PyYAML==6.0.3
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/drafting
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/reviewing-docs
```

Run these only if their files changed:

```bash
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/validating-problems
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/calibrating
```

Expected: every invoked validator reports a valid skill.

- [ ] **Step 6: Run GREEN scenarios D-F**

Re-run Task 1 scenarios D-F with fresh agents.

Expected:

- D preserves provisional status despite pressure to sound decisive;
- E routes evidence, decisions, writing, and approval separately, then asks
  before switching;
- F resumes only the unresolved claim and compares user-directed final edits
  without turning calibration into field evaluation.

Append verbatim results to
`/private/tmp/mindpowers-0.9-skill-evals/green-results.md`.

- [ ] **Step 7: Commit the verified handoff changes**

Stage only the files that changed:

```bash
rtk git add skills/drafting/SKILL.md
rtk git add skills/reviewing-docs/SKILL.md
```

Conditionally stage `skills/validating-problems/SKILL.md` and
`skills/calibrating/SKILL.md` only when their RED probes failed and their GREEN
probes now pass.

Commit:

```bash
rtk git commit -m "feat: route Mindpowers review findings"
```

Expected: one commit containing verified drafting and review handoff changes.

---

### Task 4: REFACTOR Against Variation and Pressure

**Files:**
- Modify only when a new rationalization appears: skills changed in Tasks 2-3
- Create temporarily: `/private/tmp/mindpowers-0.9-skill-evals/refactor-results.md`

- [ ] **Step 1: Test routine versus exploratory interaction**

Run two variants of the conditional-module scenario:

```text
Variant 1: first-time high-risk PRD, user demands speed and asks for all
questions at once.

Variant 2: recurring low-risk PRD with a prior locked spec and recorded
preferences, user asks for the usual format.
```

Expected:

- Variant 1 retains one contextual question at a time;
- Variant 2 may use a short batch of only genuinely unresolved questions;
- neither variant exposes a complete conditional-module checklist.

- [ ] **Step 2: Test accepted and declined recommendations**

Run four branches:

```text
1. User accepts validating-problems.
2. User declines validation and continues provisionally.
3. User accepts a materially required conditional module.
4. User declines that module under deadline pressure.
```

Expected:

- skill switch waits for confirmation;
- provisional continuation remains available;
- accepted module enters the spec;
- declined material module produces a named blocker and withholds readiness.

- [ ] **Step 3: Test readiness versus approval**

Use one content-complete document with a required external approval still
pending and one content-incomplete document whose external reviewers have all
approved.

Expected:

- first artifact remains content-ready with approval pending;
- second artifact remains `not-ready` despite completed approvals.

- [ ] **Step 4: Test routing refusal**

Have the review recommend `validating-problems`, then make the user decline the
switch.

Expected: review records the unresolved evidence finding, preserves readiness
impact, and does not invoke another skill.

- [ ] **Step 5: Close only observed loopholes**

For every failure:

1. quote the agent's rationalization in the temporary refactor report;
2. add the smallest explicit counter to the responsible skill;
3. re-run the failing variation; and
4. keep the change only when the variation passes without breaking earlier
   GREEN scenarios.

Do not add generic rationalization tables unless the observed failures show that
a compact positive rule is insufficient.

- [ ] **Step 6: Re-run all GREEN scenarios**

Re-run scenarios A-F after the final refactor.

Expected: all original GREEN behaviours remain intact.

- [ ] **Step 7: Commit refactor changes if any**

If no production file changed, record "no refactor commit required" in the
temporary report.

If files changed, stage only those files and commit:

```bash
rtk git commit -m "fix: close Mindpowers workflow loopholes"
```

Expected: a commit only when observed test failures justified further edits.

---

### Task 5: Document and Version the 0.9.0 Behaviour

**Files:**
- Modify: `README.md:24-89`
- Modify: `README.md:148-157`
- Modify: `CHANGELOG.md:7`
- Modify: `.claude-plugin/plugin.json:2-24`
- Modify: `.claude-plugin/marketplace.json:1-19`

- [ ] **Step 1: Update the README loop and behaviour**

Revise the skill table and **How it works** section in plain language to cover:

- deliverable recommendations when the format is consequential or ambiguous;
- lightweight premise checks and optional `validating-problems`;
- provisional continuation with visible blockers;
- contextual conditional-module recommendations;
- readiness separated from external approval; and
- review findings routed to the correct skill with confirmation before switching.

Do not turn README into a complete reference manual. Keep the existing
problem-first positioning and installation instructions.

- [ ] **Step 2: Add the 0.9 What's new entry**

Insert above `0.8`:

```markdown
- **0.9**: Mindstorming now recommends problem validation when a central claim
  is unsupported, surfaces conditional sections through contextual questions,
  keeps provisional readiness separate from human approval, and routes review
  findings to the right skill with confirmation before switching.
```

- [ ] **Step 3: Add the changelog entry**

Insert at the top of release history:

```markdown
## [0.9.0] - 2026-07-27

### Added
- Shared readiness states with template-specific user-facing labels and named
  material blockers.
- Root-cause routes from document review to problem validation, mindstorming,
  drafting, verification, or calibration.

### Changed
- Mindstorming recommends validating-problems when a central problem claim is
  unsupported while allowing explicitly provisional continuation.
- PRD conditional modules are recommended through contextual questions rather
  than silently omitted or presented as a template checklist.
- Drafting preserves provisional evidence, readiness, blockers, and recorded
  external-review status.

### Fixed
- Connected internal sources are no longer broadened beyond the user's stated
  scope merely because a connector is available.
- Content readiness no longer implies that an external approval was received.
- Skill switches require user confirmation and carry the exact finding forward.
```

Adjust a bullet only when the final verified implementation does not ship that
behaviour. Do not claim a conditional file changed when its RED probe passed and
it remained untouched.

- [ ] **Step 4: Synchronize plugin descriptions and versions**

Set all three version occurrences to:

```json
"version": "0.9.0"
```

Use this synchronized public description in both manifests:

```text
One loop for rigorous knowledge work: validate problems when needed, shape
deliverables through contextual questions, draft from approved specs, route
review findings to the right skill, and remember stable preferences. Mindpowers
keeps material blockers and readiness visible without confusing content quality
with human approval.
```

Keep the existing metadata, author, repository, license, and keywords unchanged.

- [ ] **Step 5: Validate JSON and version consistency**

Run:

```bash
rtk python3 -c 'import json; p=json.load(open(".claude-plugin/plugin.json")); m=json.load(open(".claude-plugin/marketplace.json")); assert p["version"]=="0.9.0"; assert m["metadata"]["version"]=="0.9.0"; assert m["plugins"][0]["version"]=="0.9.0"; assert p["description"]==m["plugins"][0]["description"]; print("release metadata ok")'
```

Expected:

```text
release metadata ok
```

- [ ] **Step 6: Commit documentation and metadata**

Stage:

```bash
rtk git add README.md
rtk git add CHANGELOG.md
rtk git add .claude-plugin/plugin.json
rtk git add .claude-plugin/marketplace.json
```

Commit:

```bash
rtk git commit -m "docs: prepare Mindpowers 0.9.0"
```

Expected: one documentation and release-metadata commit. Do not tag or publish.

---

### Task 6: Final Validation and Release-Artifact Check

**Files:**
- Verify: all files modified by Tasks 2-5
- Generate ignored artifact: `dist/mindpowers-cowork-v0.9.0.zip`
- Do not modify: `.superpowers/`

- [ ] **Step 1: Run every skill validator**

Run:

```bash
rtk python3 -m pip install --upgrade --target /private/tmp/mindpowers-skill-validator PyYAML==6.0.3
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/mindstorming
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/drafting
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/reviewing-docs
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/validating-problems
rtk env PYTHONPATH=/private/tmp/mindpowers-skill-validator python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/calibrating
```

Expected: all five skills validate.

- [ ] **Step 2: Run style and hygiene checks**

Run:

```bash
rtk git diff --check 71d44213dee7245f92b9c8c195307d390d32fade
rtk git diff --name-only 71d44213dee7245f92b9c8c195307d390d32fade
```

Expected:

- no whitespace errors;
- only approved spec, plan, skill, template, README, changelog, and manifest
  files appear;
- `.superpowers/` does not appear.

Inspect all added lines for:

- organization-specific proper nouns or acronyms;
- employee or customer names;
- proprietary workflow details;
- the `Owner` conversational actor;
- em dashes;
- unfinished marker or fill-in text.

Any uncertain organization-specific match must be shown to the user before it
is retained.

- [ ] **Step 3: Build the ignored Cowork artifact**

Run:

```bash
rtk scripts/build-cowork-zip.sh 0.9.0
```

Expected:

```text
built: /Users/gehe/projects/mindpowers/dist/mindpowers-cowork-v0.9.0.zip
```

- [ ] **Step 4: Inspect archive contents**

Run:

```bash
rtk unzip -l dist/mindpowers-cowork-v0.9.0.zip
```

Expected:

- `.claude-plugin/plugin.json` is at archive root;
- `.claude-plugin/marketplace.json` is at archive root;
- all five `skills/*/SKILL.md` files are present;
- `README.md` and `LICENSE` are present;
- there is no wrapper directory.

- [ ] **Step 5: Verify final repository state**

Run:

```bash
rtk git status --short
rtk git log --oneline 71d44213dee7245f92b9c8c195307d390d32fade..HEAD
```

Expected:

- only the pre-existing untracked `.superpowers/` directory remains;
- ignored `dist/` output does not appear;
- implementation commits are visible;
- no tag or release has been created.

- [ ] **Step 6: Report completion**

Report:

- RED failures observed;
- production files changed and conditional files deliberately left unchanged;
- GREEN and REFACTOR results;
- skill validator results;
- version synchronization;
- archive build result;
- terminology audit result; and
- confirmation that no tag, publication, or GitHub release occurred.
