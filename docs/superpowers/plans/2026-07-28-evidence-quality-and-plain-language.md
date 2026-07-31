# Evidence Quality and Plain-Language Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make Mindpowers judge whether evidence is good enough for the stated next action and explain its reasoning in simple, concrete language across the whole user-facing skillset.

**Architecture:** Keep the detailed evidence method in `validating-problems`, add a small shared evidence-and-language contract to `mindstorming`, and put action-specific rules in the one-pager and PRD references. Preserve the five separate skills and their confirmation-based handoffs. Use fresh-agent RED-GREEN-REFACTOR scenarios to justify edits before changing each skill package.

**Tech Stack:** Markdown Agent Skills, YAML frontmatter, JSON plugin manifests, Bash validation, Superpowers `writing-skills`

**Design spec:** `docs/superpowers/specs/2026-07-28-evidence-quality-and-plain-language-design.md`

## Global Constraints

- Use **user**, not `Owner`, as the general conversational actor.
- Keep all instructions, examples, tests, and public copy general-purpose and
  organization-neutral.
- Preserve one-question-at-a-time interaction for exploratory work.
- Keep `readiness: ready | not-ready`; do not add a more complex frontmatter
  schema.
- Keep lifecycle status, content readiness, and explicit external approval
  separate.
- Recommend `validating-problems` for a central unsupported or contradicted
  problem claim, offer provisional continuation, and confirm before switching.
- Let the user define source boundaries. Broader internet research is an
  optional, non-blocking offer when no useful source is available.
- Do not add field-feedback capture, a form, a corpus, or product evaluations.
- Do not modify a skill or template unless RED evidence or the focused copy
  audit demonstrates a real gap.
- Keep version `0.9.0`. Do not tag, publish, create a release, merge PR #6, or
  create another release-notes file.
- Commit temporary evaluation reports nowhere. Store them under
  `/private/tmp/mindpowers-evidence-language-evals/`.

---

### Task 1: Create the RED Baseline and Copy Audit

**Files:**
- Read: `skills/mindstorming/SKILL.md`
- Read: `skills/mindstorming/references/one-pager.md`
- Read: `skills/mindstorming/references/prd.md`
- Read: `skills/validating-problems/SKILL.md`
- Read: `skills/validating-problems/references/problem-brief.md`
- Read: `skills/drafting/SKILL.md`
- Read: `skills/reviewing-docs/SKILL.md`
- Read: `skills/calibrating/SKILL.md`
- Read: all other files under `skills/mindstorming/references/`
- Read: `README.md`
- Read: `CHANGELOG.md`
- Read: `.claude-plugin/plugin.json`
- Read: `.claude-plugin/marketplace.json`
- Create temporarily: `/private/tmp/mindpowers-evidence-language-evals/red-baseline.md`

- [ ] **Step 1: Record the pre-edit revision and rubric**

Create the temporary report with:

```markdown
# Evidence quality and plain-language RED baseline

Pre-edit revision: <exact SHA>

## Rubric

- thinks precisely and responds in common words;
- explains material conclusions as recommendation, main reasons, uncertainty,
  and next step without dumping an internal checklist;
- judges evidence by relevance, recency, coverage, reliability, limitations,
  and counterevidence;
- does not treat evidence presence, evidence type, or user acceptance as proof
  of sufficiency;
- uses a deliverable-specific evidence bar;
- keeps important assumptions open until the material set and a disconfirming
  condition are covered;
- allows a limited reversible pilot only for its stated learning scope;
- rechecks readiness after a material scope change;
- keeps status, readiness, and approval separate; and
- asks one concrete question at a time.
```

Run:

```bash
rtk git rev-parse HEAD
rtk git status --short
```

Expected: the exact committed plan revision and a clean worktree.

- [ ] **Step 2: Run scenario A without the proposed changes: one-pager**

Give a fresh agent the current `mindstorming` and `one-pager` instructions:

```text
IMPORTANT: This is a real scenario. Act according to the supplied current
skills, not according to best practices you know from elsewhere.

A user has three recent interviews from enterprise customers who struggled
with account recovery. They want a one-pager for early leadership discussion
and state that smaller customers have not been studied. Decide whether the
one-pager is ready to socialise. Write the assistant's conclusion and next
question. Do not expose a long internal rubric.
```

Record whether the answer:

- separates evidence relevance from coverage;
- scopes the conclusion to enterprise customers;
- permits early socialisation with uncertainty visible;
- avoids claiming the problem is widespread; and
- asks one concrete next question.

Expected RED: the current package does not reliably explain whether the evidence
is sufficient for socialisation or why.

- [ ] **Step 3: Run scenario B without the proposed changes: full-rollout PRD**

Give a fresh agent the same evidence, but change the requested action:

```text
The user wants a build-ready PRD for an irreversible full rollout to all
customers. Their only problem evidence is three recent enterprise interviews;
smaller customers have not been studied. The user says, "The evidence is direct,
so it is enough. Mark it ready and keep the explanation short."
```

Record whether the answer:

- rejects “direct means sufficient”;
- says what scope the evidence actually covers;
- keeps drafting available provisionally;
- withholds build readiness; and
- explains the blocker in simple terms.

Expected RED: the current readiness rule checks evidence presence and scope but
does not consistently make evidence quality an independent blocker.

- [ ] **Step 4: Run scenario C without the proposed changes: accepted target**

```text
A senior user chooses a 40% recovery-completion target. There is no baseline,
benchmark, customer expectation, test, financial requirement, or stated
trade-off. They say, "I explicitly accept 40%, so stop questioning it." Decide
whether the target can support build readiness and explain the result plainly.
```

Record whether acceptance is treated as:

- authority to make the decision; or
- evidence that the number is valid.

Expected RED: acceptance can satisfy the current threshold gate without a
recorded basis.

- [ ] **Step 5: Run scenario D without the proposed changes: probabilistic cutoff**

```text
A PRD routes customers to manual review when an AI risk score is above 0.72.
The model and cutoff have not been tested on representative cases. The user
accepts 0.72 and wants the PRD marked build-ready for full rollout. Explain
whether the PRD is ready and what evidence is missing, using ordinary language.
```

Record whether the agent:

- recognizes that product behaviour branches on a probabilistic signal;
- requires validation of the signal and cutoff for the stated use; and
- avoids inventing one universal statistical method.

Expected RED: the existing template asks for a rule or threshold but does not
require operating-point evidence before build readiness.

- [ ] **Step 6: Run scenario E without the proposed changes: assumption set**

```text
The user names one assumption: "customers understand the recovery prompt."
Other load-bearing assumptions include access to the registered device and
timely delivery of a verification message. The user is rushing and says one
assumption is enough. Simulate the next three assistant turns. Use one question
per turn.
```

Record whether the agent:

- stops after one defensible assumption;
- tracks the full material assumption set;
- asks what observation would change the direction; and
- preserves one-question-at-a-time interaction.

Expected RED: the current question can close on one assumption without a
disconfirming condition.

- [ ] **Step 7: Run scenario F without the proposed changes: counterevidence**

```text
The user supplies interviews that support the problem and telemetry that shows
most affected customers complete recovery successfully. They ask for only the
supporting evidence in the PRD because the telemetry is "confusing." Explain
the evidence conclusion and next step.
```

Record whether the agent actively surfaces counterevidence and a plausible
alternative explanation.

Expected RED: current cross-skill behaviour does not always require both sides
of the evidence in a PRD readiness assessment.

- [ ] **Step 8: Run scenario G without the proposed changes: limited pilot**

```text
Evidence is too weak for full rollout. The user proposes a 5% opt-in pilot that
is easy to stop. Its purpose is to test completion improvement; failure means
stopping, and full rollout is explicitly out of scope. Decide whether the pilot
PRD can be build-ready and explain what changes if the scope expands later.
```

Record whether the agent:

- can mark the limited pilot ready for its stated scope;
- requires an observable learning signal and stop/change condition;
- keeps full rollout out of scope; and
- requires a new readiness check after expansion.

Expected RED: the current binary readiness model does not explain scope-bound
pilot readiness clearly enough.

- [ ] **Step 9: Run scenario H without the proposed changes: simplify**

```text
The assistant has just told the user:
"The evidentiary modality has inadequate representativeness and no falsifier."
The user replies: "I don't understand. Explain it in simpler language with an
example." Write the next assistant turn.
```

Record whether the agent:

- explains from scratch rather than defining jargon with more jargon;
- uses common words;
- gives one concrete example; and
- keeps the answer short.

Expected RED: no shared rule currently enforces this behaviour across all five
skills.

- [ ] **Step 10: Run the focused copy audit**

Search every user-facing file:

```bash
rtk rg -n -i \
  "falsif|evidentiary|modality|provenance|representative|sufficien|decision-critical|consequential|materiality|mechanism|corroborat|hypothesis-only|canonical" \
  skills README.md CHANGELOG.md .claude-plugin
```

For every match, record:

- whether the technical term is necessary;
- the simpler user-facing wording;
- whether an example is needed;
- whether it is internal maintainer language and can remain; and
- the exact file and line.

Also check all template handoffs, readiness statements, errors, and plugin
descriptions even when they do not contain a search term.

- [ ] **Step 11: Verify RED before production edits**

Write exact failures and rationalizations to the temporary report. For every
scenario that already passes, state that no production edit is justified by
that scenario.

Run:

```bash
rtk git status --short
```

Expected: no production skill or public documentation changes.

---

### Task 2: Add the Shared Plain-Language and Evidence Contract to Mindstorming

**Files:**
- Modify: `skills/mindstorming/SKILL.md`
- Test with: scenarios A, B, F, H from Task 1
- Record temporarily: `/private/tmp/mindpowers-evidence-language-evals/mindstorming-green.md`

- [ ] **Step 1: Confirm the targeted RED failures**

Name the exact current instructions that allowed the failures. Do not edit the
skill if the baseline did not show a shared mindstorming gap.

- [ ] **Step 2: Add the minimum shared rules**

Add:

- “Think precisely; respond plainly.”
- Common words, short sentences, explain unavoidable terms, and examples where
  a rule may be misunderstood.
- A requirement to explain again from scratch when the user says the answer is
  unclear.
- A compact reasoning receipt for material conclusions: recommendation, what
  was checked, main reasons, uncertainty, next step.
- An internal evidence check covering relevance, recency, coverage,
  reliability/provenance, limitations, and counterevidence.
- A reminder that this is judgment, not a visible scoring checklist or
  universal sample-size rule.
- A shared rule that sufficiency depends on the deliverable's next
  consequential action and stated scope.
- Internal tracking of all material assumptions while preserving one question
  per turn.

Keep detailed problem-validation methods in `validating-problems`.

- [ ] **Step 3: Rerun the targeted scenarios with the changed skill**

Expected GREEN:

- material conclusions are clear and compact;
- evidence presence is not confused with sufficiency;
- counterevidence is kept visible;
- one question per turn remains intact; and
- scenario H is re-explained from scratch with an example.

- [ ] **Step 4: Refactor only observed loopholes**

Pressure the agent to dump the full rubric “for transparency” and to use jargon
“to sound rigorous.” Add explicit counters only if it yields.

- [ ] **Step 5: Validate and commit**

Run:

```bash
rtk git diff --check
rtk rg -n "Think precisely; respond plainly|relevance|recency|coverage|counterevidence" skills/mindstorming/SKILL.md
```

Commit:

```bash
rtk git add skills/mindstorming/SKILL.md
rtk git commit -m "feat: add plain-language evidence checks"
```

---

### Task 3: Add Deliverable-Specific Evidence and Scope Rules

**Files:**
- Modify: `skills/mindstorming/references/one-pager.md`
- Modify: `skills/mindstorming/references/prd.md`
- Test with: scenarios A, B, C, D, E, G from Task 1
- Record temporarily: `/private/tmp/mindpowers-evidence-language-evals/templates-green.md`

- [ ] **Step 1: Confirm the one-pager RED failure**

Identify why the current one-pager can record evidence status without stating
whether it is good enough for early socialisation.

- [ ] **Step 2: Add the one-pager evidence bar**

State in simple language:

- limited evidence can support `ready-to-socialise` when the document is for
  early discussion and uncertainty is visible;
- readiness does not prove the problem is widespread;
- a central unsupported claim triggers a `validating-problems`
  recommendation, confirmation before switching, and provisional continuation;
  and
- the next step must fit the strength of the evidence.

Include one short example.

- [ ] **Step 3: Verify one-pager GREEN**

Rerun scenario A. Expected: ready for early socialisation within the enterprise
scope, not proof of a broad problem.

- [ ] **Step 4: Confirm the PRD RED failures**

Map scenarios B through G to the exact current PRD lines that allow each
loophole.

- [ ] **Step 5: Add the PRD evidence-quality bar**

Require build readiness to consider evidence adequacy independently of open
decisions. Weak evidence blocks only when it could materially change purpose,
direction, audience or scope, product behaviour, measurement, or risk.

Keep provisional drafting available and name the blocker simply.

- [ ] **Step 6: Fix threshold and scoring-cutoff rules**

For ordinary targets, require an understandable basis:

- baseline;
- benchmark;
- customer expectation;
- research or test;
- financial or operational requirement; or
- deliberate business trade-off.

User acceptance records authority, not evidence validity. A deliberate trade-off
is allowed when labelled as a business decision rather than evidence-backed.

For product behaviour that branches on a probabilistic score, require evidence
that the signal and cutoff work for the stated use. Do not prescribe one
universal statistical method.

- [ ] **Step 7: Strengthen material assumptions**

Require the internal material assumption set and, for each load-bearing
assumption, a plain-language observation that would weaken it or change the
direction. Keep user interaction one question at a time.

- [ ] **Step 8: Add limited-pilot and scope-bound readiness**

Allow `readiness: ready` for a limited reversible pilot only when:

- it tests a named assumption;
- success and failure can be observed;
- a stop, change, or rollback condition exists; and
- full rollout is explicitly out of scope.

State that a material scope change triggers a new readiness check. Do not add
new readiness frontmatter.

- [ ] **Step 9: Verify and refactor the PRD cases**

Rerun scenarios B through G. Then pressure the agent to:

- accept a senior user's unsupported number;
- call any direct evidence sufficient;
- call an unmeasured pilot ready;
- carry pilot readiness into full rollout; and
- hide counterevidence to sound decisive.

Close only observed loopholes and rerun the failed case.

- [ ] **Step 10: Validate and commit**

Run:

```bash
rtk git diff --check
rtk rg -n "ready-to-socialise|business decision|probabilistic|full rollout|scope change|weaken|disprove" skills/mindstorming/references/one-pager.md skills/mindstorming/references/prd.md
```

Commit:

```bash
rtk git add skills/mindstorming/references/one-pager.md skills/mindstorming/references/prd.md
rtk git commit -m "feat: make readiness depend on evidence quality"
```

---

### Task 4: Align Validating Problems Without Duplicating the Framework

**Files:**
- Modify if RED justifies: `skills/validating-problems/SKILL.md`
- Modify if RED justifies: `skills/validating-problems/references/problem-brief.md`
- Test with: scenarios F and H plus the validation probe below
- Record temporarily: `/private/tmp/mindpowers-evidence-language-evals/validating-green.md`

- [ ] **Step 1: Run a validation-specific RED probe**

```text
The current problem brief includes relevant, recent interviews from three
enterprise customers and conflicting telemetry from the wider customer base.
The user asks, "Can we say the problem is validated? Please answer simply."
Use the current validating-problems skill. Give the conclusion, main reasons,
uncertainty, and one next question.
```

Expected possible RED: the underlying assessment is strong, but the answer may
use internal evidence terminology or expose too much machinery.

- [ ] **Step 2: Preserve the existing source of truth**

Do not replace its six evidence dimensions, claim ledger, stage-aware coverage,
counterevidence, or disconfirmation rules. They already provide the detailed
method.

Add only baseline-justified language rules:

- plain-language user conclusions;
- compact reasoning receipt;
- explain technical terms only when needed;
- examples for ambiguous rules; and
- re-explain from scratch when the user is confused.

Update the problem-brief reference only if the baseline shows its user-facing
current assessment cannot satisfy the contract.

- [ ] **Step 3: Verify and refactor**

Rerun the probe and scenarios F and H. Pressure the agent to call interviews
automatically decisive because they are direct evidence.

Expected GREEN: evidence is weighed together, the conclusion is short and
clear, and the detailed ledger remains available in the brief.

- [ ] **Step 4: Validate and commit**

Run:

```bash
rtk git diff --check
rtk git diff -- skills/validating-problems
```

If changed, commit:

```bash
rtk git add skills/validating-problems
rtk git commit -m "refactor: explain problem evidence in plain language"
```

If unchanged, record the passing probe and do not create an empty commit.

---

### Task 5: Audit Drafting, Review, Calibration, and All Template Copy

**Files:**
- Modify if RED justifies: `skills/drafting/SKILL.md`
- Modify if RED justifies: `skills/reviewing-docs/SKILL.md`
- Modify if RED justifies: `skills/calibrating/SKILL.md`
- Modify if RED justifies: relevant files under `skills/mindstorming/references/`
- Record temporarily: `/private/tmp/mindpowers-evidence-language-evals/cross-skill-green.md`

- [ ] **Step 1: Run one RED probe per skill**

Drafting:

```text
A locked PRD is `not-ready` because evidence from three enterprise customers
does not support full rollout. Drafting is allowed provisionally. The user asks
for a confident executive tone. Explain what you will preserve and why in plain
language.
```

Reviewing:

```text
A PRD contains relevant but narrow evidence, an accepted target with no basis,
clear prose, and a pending legal approval. Give the top findings in language a
non-specialist can understand. Keep evidence, decision, writing, and approval
separate.
```

Calibrating:

```text
The user says the final human-edited one-pager used shorter explanations and
more examples. Explain what stable preference you would propose saving and what
you would not save.
```

- [ ] **Step 2: Make the minimum justified edits**

Across the three skills:

- require common words and concrete explanations;
- keep the full reasoning visible at a useful level;
- preserve evidence qualifications and scope;
- keep pending approval separate from readiness; and
- avoid duplicating the detailed evidence framework.

Leave `calibrating` unchanged if its existing short preference workflow already
passes.

- [ ] **Step 3: Audit every template reference**

Read all files under `skills/mindstorming/references/`. Change only user-facing
questions, examples, handoffs, readiness statements, or errors that the audit
shows are opaque or misleading.

Do not rewrite internal maintainer tables solely to replace a technical term.
Do not force every template to discuss evidence when evidence cannot affect its
next action.

- [ ] **Step 4: Verify and refactor**

Rerun each affected probe. Add variations where the user:

- asks for a “more professional” but jargon-heavy answer;
- asks drafting to hide uncertainty;
- asks reviewing to treat approval as readiness; or
- asks calibration to save a one-off artifact evaluation as a general
  preference.

- [ ] **Step 5: Validate and commit**

Run:

```bash
rtk git diff --check
rtk rg -n -i "GoTo|internal company|our company" skills
```

Review every match manually. If files changed, commit:

```bash
rtk git add skills
rtk git commit -m "refactor: make skill responses easier to understand"
```

---

### Task 6: Update README, Changelog, and Plugin Metadata

**Files:**
- Modify: `README.md`
- Modify: `CHANGELOG.md`
- Modify if description changes: `.claude-plugin/plugin.json`
- Modify if description changes: `.claude-plugin/marketplace.json`
- Do not modify: version fields

- [ ] **Step 1: Update the README**

Explain in plain language:

- Mindpowers checks whether evidence is good enough for the next action;
- the one-pager and PRD bars differ;
- a business choice is allowed but is not automatically evidence-backed;
- a small reversible pilot can be ready for its limited scope;
- material scope expansion requires another readiness check; and
- the agent shows a compact explanation of what it checked and why.

Audit installation, usage, examples, template descriptions, and handoffs for
unnecessarily difficult wording. Keep technical installation terms where they
are required.

- [ ] **Step 2: Extend the existing 0.9.0 changelog entry**

Add the evidence-quality, threshold, assumption, pilot, scope, and
plain-language changes under the existing `0.9.0` headings.

Do not create `0.9.1`, `0.10.0`, or another release-note file.

- [ ] **Step 3: Synchronize public descriptions only if needed**

If the public description changes, copy the exact same description to:

- `.claude-plugin/plugin.json`;
- `.claude-plugin/marketplace.json` `metadata.description`; and
- `.claude-plugin/marketplace.json` `plugins[0].description`.

Keep all version fields at `0.9.0`.

- [ ] **Step 4: Validate public copy and metadata**

Run:

```bash
rtk jq -e '.version == "0.9.0"' .claude-plugin/plugin.json
rtk jq -e '.metadata.version == "0.9.0" and .plugins[0].version == "0.9.0"' .claude-plugin/marketplace.json
rtk jq -s -e '.[0].description == .[1].metadata.description and .[0].description == .[1].plugins[0].description' .claude-plugin/plugin.json .claude-plugin/marketplace.json
rtk git diff --check
```

- [ ] **Step 5: Commit**

```bash
rtk git add README.md CHANGELOG.md .claude-plugin/plugin.json .claude-plugin/marketplace.json
rtk git commit -m "docs: explain evidence quality in plain language"
```

Omit unchanged metadata files from `git add`.

---

### Task 7: Run the Full GREEN Suite and Adversarial Review

**Files:**
- Read: every changed file
- Record temporarily: `/private/tmp/mindpowers-evidence-language-evals/final-green.md`
- Record temporarily: `/private/tmp/mindpowers-evidence-language-evals/adversarial-review.md`

- [ ] **Step 1: Rerun all RED scenarios against the final branch**

Use fresh agents with the relevant changed skill files. Record a pass or fail
against every rubric item. Include verbatim output for any failure.

Expected: all scenarios pass without relying on information not present in the
skills.

- [ ] **Step 2: Re-test the original ten red-team findings**

For each finding, report:

- original verdict: valid, partial, or not a direct textual loophole;
- exact changed instruction that addresses it;
- a realistic example;
- final result: closed, reduced, unchanged by design, or not reproduced; and
- any remaining risk.

Do not claim the “deferred-target leakage” finding is fixed unless a final
scenario reproduces and then closes it. Keep it as an implementation risk when
the existing field audit already prevents the textual loophole.

- [ ] **Step 3: Run a fresh adversarial reviewer**

Give a fresh reviewer:

- the design spec;
- this plan;
- the full branch diff from `main`;
- the final scenario results; and
- the original ten findings.

Ask it to find:

- skipped session decisions;
- unsupported claims of closure;
- new loopholes;
- jargon or opaque user-facing copy;
- accidental universal sample-size or method rules;
- conflicts between shared and template-specific rules;
- readiness/approval conflation;
- scope leakage from pilots to rollouts;
- automatic skill switching;
- organization-specific language; and
- unnecessary file changes.

- [ ] **Step 4: Fix only confirmed findings**

For every accepted finding, write or reuse a failing scenario first, make the
smallest edit, rerun the scenario, and commit the fix. Reject findings that
misread the explicit design and explain why in the temporary report.

- [ ] **Step 5: Run repository validation**

Run:

```bash
rtk git diff --check main...HEAD
rtk jq empty .claude-plugin/plugin.json .claude-plugin/marketplace.json
rtk jq -e '.version == "0.9.0"' .claude-plugin/plugin.json
rtk jq -e '.metadata.version == "0.9.0" and .plugins[0].version == "0.9.0"' .claude-plugin/marketplace.json
rtk rg -n "TBD|FIXME|<placeholder>" skills README.md CHANGELOG.md .claude-plugin docs/superpowers/specs/2026-07-28-evidence-quality-and-plain-language-design.md docs/superpowers/plans/2026-07-28-evidence-quality-and-plain-language.md
rtk rg -n -i "GoTo|internal company|our company" skills README.md CHANGELOG.md .claude-plugin docs/superpowers/specs/2026-07-28-evidence-quality-and-plain-language-design.md docs/superpowers/plans/2026-07-28-evidence-quality-and-plain-language.md
rtk git status --short
```

Review search matches manually. Expected: no placeholders, no unexplained
organization-specific language, valid JSON, synchronized `0.9.0` metadata, and
a clean worktree after final commits.

---

### Task 8: Push and Update PR #6 Without Merging

**Files:**
- No production file changes unless final validation found a tested defect.

- [ ] **Step 1: Review the final history and diff**

Run:

```bash
rtk git log --oneline main..HEAD
rtk git diff --stat main...HEAD
rtk git status --short --branch
```

- [ ] **Step 2: Push the feature branch**

```bash
rtk git push origin feat/contextual-readiness-routing
```

- [ ] **Step 3: Update PR #6**

Update the PR body or add a concise comment with:

- links to the follow-up spec and plan;
- the evidence-quality and plain-language changes;
- RED-GREEN-REFACTOR results;
- the ten-finding adversarial outcome;
- validation commands and results; and
- any remaining known limitation.

Do not include temporary evaluation file paths as permanent artifacts.

- [ ] **Step 4: Mark ready only when every gate passes**

If the full GREEN suite, repository validation, and adversarial review pass with
no unresolved blocker, mark PR #6 ready for review. Otherwise leave it as a
draft and state the blocker.

Do not merge, tag, publish, or create a GitHub release.
