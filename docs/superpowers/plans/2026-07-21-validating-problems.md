# Validating Problems Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add and verify a standalone `validating-problems` skill that produces evidence-bounded problem briefs and hands them to Mindstorming without making validation mandatory.

**Architecture:** Keep the conversational decision logic in a concise `SKILL.md` and move the durable artifact schema plus worked example into one reference file. Integrate through an optional problem-brief link in Mindstorming and the one-pager template. Validate behaviour with fresh-agent pressure scenarios, then update plugin metadata and public documentation for a v0.7.0 minor release.

**Tech Stack:** Markdown agent skills, YAML frontmatter, Claude plugin metadata JSON, Bash packaging, skill forward-tests with fresh agents.

## Global constraints

- Preserve `validating-problems` and `mindstorming` as independently usable skills.
- Prefer direct customer and behavioural evidence, but never treat the evidence hierarchy mechanically.
- Ask exactly one decision-relevant question per conversational turn.
- Never invent sample sizes, durations, confidence scores, or success thresholds.
- Keep prioritisation, solution selection, solution validation, and PRD hardening out of this cycle.
- Keep skill descriptions limited to triggering conditions.
- Keep `SKILL.md` below 500 lines and references one level deep.
- Follow repository style: sentence case, no em dashes, one idea per bullet.
- Do not commit generated `.superpowers/` visual-companion state or generated `dist/*.zip` files.

---

## File map

| File | Responsibility |
|---|---|
| `skills/validating-problems/SKILL.md` | Trigger, evidence model, adaptive interaction, premise challenge, decision rules, and handoff behaviour |
| `skills/validating-problems/references/problem-brief.md` | Exact problem-brief frontmatter, body contract, evidence assignment schema, and concise example |
| `skills/mindstorming/SKILL.md` | Optional discovery and consumption of a relevant problem brief without re-asking settled questions |
| `skills/mindstorming/references/one-pager.md` | Qualification rules and optional `problem:` link for one-pager specs |
| `README.md` | Public workflow, skill list, file locations, and v0.7 summary |
| `.claude-plugin/plugin.json` | v0.7.0 plugin version, description, and discovery keywords |
| `.claude-plugin/marketplace.json` | Matching v0.7.0 marketplace metadata |
| `CHANGELOG.md` | v0.7.0 behavioural contract and integration notes |
| `skills/calibrating/SKILL.md` | Correct the existing template count from eight to nine |

### Task 1: Author the standalone skill

**Files:**
- Create: `skills/validating-problems/SKILL.md`
- Create: `skills/validating-problems/references/problem-brief.md`

**Interfaces:**
- Consumes: conversation context, linked workspace evidence, and optional existing research or data.
- Produces: `docs/mindpowers/problems/YYYY-MM-DD-<slug>.md` with the schema defined in `problem-brief.md`.

- [ ] **Step 1: Reconfirm RED behaviour**

Read the five existing no-skill baseline outputs and record the repeated failures in working notes only: batched questioning, premature pilot design, invented thresholds, absent claim-level statuses, and no disconfirmation route.

Expected: each failure occurred in all or most baseline runs and is addressed by an explicit requirement in the approved design.

- [ ] **Step 2: Create the minimal `SKILL.md`**

Use this frontmatter:

```yaml
---
name: validating-problems
description: Use when a user wants to test, sharpen, frame, or gather evidence for a customer or business problem before pitching a direction, prioritising work, or writing a PRD.
---
```

Implement these body sections in imperative form:

```text
Overview
Bound the decision
Inspect before asking
Evaluate four claims
Assess evidence
Route by product stage
Run the conversation
Challenge the premise
Stop for real-world evidence
Decide and write the brief
Hand off
Hard rules
```

The body must include the four claims, four claim statuses, three evidence classes, six evidence-quality dimensions, three stage routes, one-question response contract, alternative and disconfirming framing rules, evidence-assignment contract, and three workflow decisions from the design spec.

- [ ] **Step 3: Create the reference artifact**

Write `references/problem-brief.md` with:

```text
Problem brief schema
Body contract
Evidence assignment
Completed example
```

Use the exact frontmatter fields from the design. In the example, scope one pilot PM's evidence to that pilot's workflow and leave audience, materiality, and mechanism unsupported until evidence is supplied.

- [ ] **Step 4: Run structural checks**

Run:

```bash
python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/validating-problems
wc -l skills/validating-problems/SKILL.md
rg -n "TODO|TBD|—" skills/validating-problems
```

Expected: validator reports success, `SKILL.md` is below 500 lines, and `rg` returns no matches.

- [ ] **Step 5: Commit the standalone skill**

```bash
git add skills/validating-problems
git commit -m "Add problem validation skill"
```

### Task 2: Run GREEN pressure tests and close loopholes

**Files:**
- Modify if tests expose a loophole: `skills/validating-problems/SKILL.md`
- Modify if the output contract is ambiguous: `skills/validating-problems/references/problem-brief.md`

**Interfaces:**
- Consumes: the standalone skill from Task 1 and five fresh-context scenarios.
- Produces: observed compliant behaviours across the approved pass criteria.

- [ ] **Step 1: Run five independent GREEN scenarios**

Give one fresh agent each of these user-shaped requests and the path to the skill, without supplying the expected answer:

```text
1. We need an agentic PRD workflow. PMs take too long, are inconsistent, and miss edge cases. One pilot PM gave detailed feedback. Leadership wants a proposal tomorrow and engineering is ready. Help validate the problem and decide what can be said now.

2. Our largest customer asked for an approval dashboard, so this is clearly a market-wide problem. Sales wants it committed this quarter. Help me validate the problem before I pitch it.

3. Activation telemetry shows a large drop after workspace creation, but we do not know why. Help me validate the problem for a one-pager.

4. Six interviewees say weekly reporting is painful, but usage data shows most reports are completed quickly and on time. Help me determine what problem, if any, is supported.

5. Skip discovery. Leadership already wants an AI copilot and I need the solution one-pager today. Validate the problem quickly so we can move on.
```

Expected per run: claim-level statuses, scoped assessment, no invented numeric standard, no premature solution plan, and exactly one highest-value question in the first turn.

- [ ] **Step 2: Evaluate against one rubric**

For every output, mark pass or fail for:

```text
uses supplied context
separates decision from evidence status
evaluates the four claims
scopes by evidence and recency
assesses evidence non-mechanically
asks one question
seeks an alternative or disconfirming route
avoids invented thresholds
stays out of solution design
uses a valid socialise, gather-evidence, or stop decision
```

- [ ] **Step 3: Refactor only observed loopholes**

For each failure, capture the agent's exact rationalisation, make the smallest instruction change that blocks it, and rerun only the failed scenario plus one previously passing scenario.

Expected: all five scenarios pass without expanding the skill into a generic research handbook.

- [ ] **Step 4: Re-run structural checks and commit**

```bash
python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/validating-problems
git diff --check
git add skills/validating-problems
git commit -m "Harden problem validation behaviour"
```

Expected: validation and whitespace checks pass. If no refactor was necessary, do not create an empty commit.

### Task 3: Integrate the optional problem brief with Mindstorming

**Files:**
- Modify: `skills/mindstorming/SKILL.md`
- Modify: `skills/mindstorming/references/one-pager.md`

**Interfaces:**
- Consumes: an optional `docs/mindpowers/problems/*.md` brief.
- Produces: a Mindstorming spec that preserves evidence qualifications and may link back through `problem: <path>`.

- [ ] **Step 1: Add brief discovery to Mindstorming context exploration**

Add `docs/mindpowers/problems/` to context scanning only when the topic matches or the user supplies a brief. Require Mindstorming to read the brief before elicitation and skip settled questions.

Do not add `validating-problems` as a mandatory step or dependency.

- [ ] **Step 2: Add evidence-status handling**

Define these downstream rules:

```text
supported: may be stated within recorded scope
partially-supported: preserve the qualification
unsupported: discuss only as a hypothesis
contradicted: warn and require reframing before using it as the pitch premise
```

State explicitly that validation does not imply prioritisation, approval, or permission to build.

- [ ] **Step 3: Extend the one-pager reference**

Add an optional Problem brief input and the optional spec frontmatter field:

```yaml
problem: docs/mindpowers/problems/YYYY-MM-DD-<slug>.md
```

Require the one-pager's Problem section to preserve the brief's scope, status, limitations, and `as_of` date. Do not require a problem brief when none exists.

- [ ] **Step 4: Run two integration simulations**

Run one fresh-agent scenario with a supplied partially supported brief and one without any brief.

Expected with brief: no re-asking of settled facts, qualification preserved, and `problem:` linked.

Expected without brief: normal Mindstorming behaviour with no demand to run validation first.

- [ ] **Step 5: Check and commit**

```bash
rg -n "problem brief|problem:|partially-supported|prioritisation" skills/mindstorming
git diff --check
git add skills/mindstorming/SKILL.md skills/mindstorming/references/one-pager.md
git commit -m "Connect problem briefs to mindstorming"
```

### Task 4: Publish the new workflow in plugin metadata and docs

**Files:**
- Modify: `README.md`
- Modify: `.claude-plugin/plugin.json`
- Modify: `.claude-plugin/marketplace.json`
- Modify: `CHANGELOG.md`
- Modify: `skills/calibrating/SKILL.md`

**Interfaces:**
- Consumes: the completed skill and integration contract.
- Produces: consistent v0.7.0 public discovery and package metadata.

- [ ] **Step 1: Update README workflow and skill list**

Add `validating-problems` as an optional pre-shape step. Document `docs/mindpowers/problems/` under file locations. Explain that a one-pager socialises a supported or explicitly provisional problem, while prioritisation still happens elsewhere.

- [ ] **Step 2: Update release metadata**

Set both plugin version fields to `0.7.0`. Update descriptions to mention optional problem validation and add `problem-validation`, `product-discovery`, and `product-management` keywords without removing existing keywords.

- [ ] **Step 3: Add the changelog entry**

Add `## [0.7.0] - 2026-07-21` with Added, Changed, and Fixed entries covering the new skill, optional Mindstorming handoff, claim-level evidence statuses, and the template-count correction.

- [ ] **Step 4: Correct the stale calibrating count**

Change “8 template types” to “9 template types” and keep the existing nine names plus `general` unchanged.

- [ ] **Step 5: Validate metadata and commit**

```bash
python3 -m json.tool .claude-plugin/plugin.json >/dev/null
python3 -m json.tool .claude-plugin/marketplace.json >/dev/null
rg -n "0\.7\.0|validating-problems|docs/mindpowers/problems|9 template" README.md CHANGELOG.md .claude-plugin skills/calibrating/SKILL.md
git diff --check
git add README.md CHANGELOG.md .claude-plugin/plugin.json .claude-plugin/marketplace.json skills/calibrating/SKILL.md
git commit -m "Document problem validation workflow"
```

### Task 5: Verify the complete package

**Files:**
- Verify only: all files above
- Generated and ignored: `dist/mindpowers-cowork-v0.7.0.zip`

**Interfaces:**
- Consumes: completed v0.7.0 source tree.
- Produces: structural, behavioural, and packaging verification evidence.

- [ ] **Step 1: Run final source checks**

```bash
python3 /Users/gehe/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/validating-problems
python3 -m json.tool .claude-plugin/plugin.json >/dev/null
python3 -m json.tool .claude-plugin/marketplace.json >/dev/null
git diff --check
rg -n "TODO|TBD|—" skills/validating-problems README.md CHANGELOG.md
```

Expected: validators succeed and the final `rg` returns no matches.

- [ ] **Step 2: Build and inspect the Cowork package**

```bash
./scripts/build-cowork-zip.sh
unzip -l dist/mindpowers-cowork-v0.7.0.zip | rg "skills/validating-problems/(SKILL.md|references/problem-brief.md)|skills/mindstorming/SKILL.md|plugin.json"
```

Expected: the build reports `mindpowers-cowork-v0.7.0.zip` and all required files are present at the expected archive paths.

- [ ] **Step 3: Review repository state**

```bash
git status --short
git log -5 --oneline
```

Expected: only `.superpowers/` and ignored build output may remain outside committed source changes. No user-authored file is modified unintentionally.

- [ ] **Step 4: Report model-test coverage**

Report which model family ran the GREEN simulations. If only one family was available, state that cross-model portability remains unverified rather than implying broader coverage.
