# Contextual Readiness and Skill Routing Design

## Summary

Harden the Mindpowers workflow without turning `mindstorming` into a universal
orchestrator. The user continues to describe an outcome, Mindpowers recommends
the most suitable deliverable, and `mindstorming` shapes it through contextual
questions.

The design adds four shared behaviours:

1. a lightweight premise check that can recommend `validating-problems`;
2. contextual recommendations for conditional template modules;
3. a readiness contract separate from lifecycle status and human approval; and
4. root-cause routing between the existing Mindpowers skills.

The workflow remains useful when evidence or decisions are incomplete. The user
may continue with a provisional artifact, but Mindpowers must keep material gaps
visible and withhold the artifact's final readiness label.

**Audience:** Mindpowers maintainers and contributors changing the skill
contracts, template references, and cross-skill handoffs.

## Why This Exists

Mindpowers already provides adaptive elicitation, optional problem briefs,
template selection, approval gates, drafting, review, and calibration. Its PRD
template also has a compact core plus risk-triggered modules.

The remaining gaps are interaction and routing gaps:

- a relevant conditional module may be silently omitted instead of discussed;
- a batch of template questions can feel like a checklist rather than a
  conversation;
- an unsupported central problem claim may remain visible without prompting an
  explicit `validating-problems` recommendation;
- lifecycle status, content readiness, and external approval can be conflated;
- review findings may be sent back to the wrong skill; and
- source discovery boundaries are not explicit enough.

These are shared workflow problems, not reasons to create another all-purpose
skill.

## Goals

- Keep one-question-at-a-time elicitation for exploratory work.
- Recommend a deliverable when the user's desired outcome implies one.
- Detect decision-changing premise gaps without making formal problem
  validation mandatory.
- Let provisional work continue while preserving unsupported claims and open
  decisions.
- Recommend conditional sections through contextual questions, not a visible
  template checklist.
- Distinguish content readiness from spec lifecycle and human approval.
- Route evidence, reasoning, writing, review, and preference-learning work to
  the appropriate existing skill.
- Keep all instructions, examples, and tests organization-neutral.

## Non-Goals

- Creating a new workflow-router skill.
- Requiring `validating-problems` before every one-pager or PRD.
- Automatically searching internal repositories that the user did not identify.
- Automatically ingesting final artifacts into a shared corpus.
- Embedding field-feedback forms or product evaluations in a user-facing skill.
- Encoding organization-specific approval policies.
- Replacing document export or connector tooling.
- Requiring every deliverable to name an accountable owner.

## Terminology

Use **user** for the person interacting with Mindpowers. Do not introduce
`Owner` as a general conversational actor.

This design does not add or alter ownership metadata already used by individual
templates. Decision makers, reviewers, contributors, or other roles appear only
when the deliverable and its risks require them.

## Shared Workflow

```text
User describes the desired outcome
        ↓
Mindpowers recommends a deliverable when useful
        ↓
Mindpowers inspects user-supplied or user-directed context
        ↓
Deliverable depends on a central problem claim?
        ↓ yes
Run a lightweight premise check
        ↓
Material evidence gap?
  yes → recommend validating-problems
        user confirms switch or continues provisionally
        ↓
mindstorming asks one contextual question at a time
        ↓
An answer reveals a conditional need
        ↓
Recommend the relevant module and explain why
        ↓
User adds it, discusses it, or declines it
        ↓
Lock the approved working spec
        ↓
drafting → reviewing-docs
        ↓
Review classifies root cause and recommends the next skill
        ↓
User confirms before any skill switch
        ↓
Optional export and calibration
```

## Deliverable Recommendation

Keep the existing template-matching behaviour. Make the recommendation visible
when the choice is ambiguous, unfamiliar, or costly to get wrong:

> I recommend a decision document because you are still comparing live
> alternatives. I will use that shape unless you want a different deliverable.

Do not add a confirmation interruption when the requested format and intended
outcome are already unambiguous.

## Source Boundaries

Mindpowers may inspect:

- material the user supplies;
- connected sources the user explicitly points toward; and
- relevant workspace artifacts already within the task's stated scope.

Do not broaden an internal search merely because a connector is available.

When a decision-critical evidence gap remains and the user has not identified
another source, offer broader internet research. The offer is non-blocking. If
the user declines, continue with the claim marked at its honest evidence status.
Do not invent evidence or treat external benchmarks as proof of an internal
problem.

## Lightweight Premise Check

Apply a brief premise check when a deliverable depends on a customer or business
problem claim. Inspect available context before asking anything. Check:

- whether the problem is stated without assuming a solution;
- who experiences it and in what scope;
- what evidence supports it;
- what remains an assumption; and
- whether a plausible alternative explanation could change the direction.

This is not a miniature mandatory validation exercise.

When a central claim is unsupported or contradicted:

1. state the current evidence status and why it matters;
2. recommend `validating-problems`;
3. ask the user to confirm the skill switch; and
4. offer provisional continuation as an explicit alternative.

If a relevant problem brief already exists, preserve its scope, date,
limitations, and claim statuses. Do not restart validation or re-ask settled
questions. Recommend resuming or updating `validating-problems` only when the
user wants to strengthen a still-material gap.

## Contextual Conditional Modules

Templates may retain an internal coverage table of observable predicates and
conditional modules. That table is an agent aid, not a user-facing questionnaire.

For exploratory work:

1. detect a possible predicate from the user's actual context;
2. ask one question about that context;
3. use the answer to determine whether the module is relevant;
4. recommend the module with a short reason; and
5. let the user add it, discuss it, or decline it.

Do not silently omit a relevant or uncertain module. Do not present all possible
modules as a batch checklist.

For routine work, the existing adaptive elicitation rule still permits a short
batch of genuinely unresolved questions. Conditional coverage must not become a
full template dump.

### PRD examples

| Contextual signal | Question shape | Recommended module |
|---|---|---|
| Behaviour depends on an external state or integration | Can the product reliably obtain the state needed to make this decision? | Integration and state |
| The intended outcome cannot be observed today | How will the team know the change produced the intended result? | Telemetry and measurement |
| A harmful action is difficult to reverse | If this causes harm, how can it be stopped or recovered? | Rollout and recovery |
| Sensitive information may be handled differently | Does this change how sensitive information is collected, stored, exposed, or sent? | Privacy and security |
| The product creates support or operating work | Who helps the affected person, and what must they do? | Operational readiness |
| Multiple teams or decision makers must act | Who must decide, validate, contribute, or be informed? | Decision rights and reviewers |
| Behaviour depends on probabilistic output | How will representative cases, failure classes, and fallback behaviour be evaluated? | Evaluation contract |

Recommendations should include a proposed direction and its trade-off when the
available context supports one. Label it as a proposal for the user or relevant
domain expert to confirm. Do not invent a domain decision.

## Readiness Contract

Keep lifecycle status and readiness separate:

```yaml
status: draft | locked | superseded
readiness: ready | not-ready
```

- `status` records whether the working spec has been approved or replaced.
- `readiness` records whether the artifact meets its template's quality bar for
  the next consequential action.

A user may approve and lock a spec whose readiness is `not-ready`. Drafting may
continue, but the draft must preserve the provisional state and its blockers.

Every `not-ready` artifact must state its blocking gaps. A gap blocks readiness
only when leaving it unresolved could materially change what the audience
decides, does, builds, measures, or understands.

Optional polish, advisory input, or additional evidence that cannot change the
decision remains a visible non-blocking note.

### User-facing readiness labels

The internal state remains `ready` or `not-ready`. Templates use language that
matches the action the artifact supports:

| Template | Ready label |
|---|---|
| `business-review` | ready-to-present |
| `decision-doc` | decision-ready |
| `one-pager` | ready-to-socialise |
| `prd` | build-ready |
| `briefing-doc` | meeting-ready |
| `comms-draft` | ready-to-send |
| `framework` | ready-to-apply |
| `talking-points` | ready-to-deliver |
| `post-mortem` | action-ready |
| `self-shape` | define the consequential action during elicitation |

The exact blocker, not merely the label, must be visible.

## Human Review and Approval

Content readiness does not imply stakeholder approval.

Mindpowers may suggest a reviewer role when a specific decision or risk justifies
it. The user may accept, change, or decline the suggestion. Reviewer suggestions
are non-blocking by default.

If the user or an external policy explicitly marks an approval as required,
record it separately from readiness. Mindpowers must not claim an approval was
received unless the user or an accessible source explicitly records it.

An artifact may therefore be content-ready while a required external approval
is still pending.

## Root-Cause Skill Routing

`reviewing-docs` should classify each material finding before recommending the
next action:

| Root cause | Recommended route |
|---|---|
| Missing or weak problem evidence | `validating-problems` |
| Missing product, scope, requirement, or measurement decision | `mindstorming` |
| Settled reasoning expressed poorly | `drafting` |
| Artifact needs adversarial verification | `reviewing-docs` |
| Final human edits reveal a stable user preference | `calibrating` |
| External approval is pending | Record it; do not switch skills |

A routed finding must carry:

- the source artifact;
- the exact finding;
- the unresolved question or requested change;
- the affected sections or identifiers;
- severity and readiness impact; and
- the reason for the recommended route.

Mindpowers recommends the switch and waits for user confirmation. It must not
silently start a deeper validation, redrafting, or calibration exercise.

Work upstream to downstream when several finding types coexist: evidence and
reasoning before prose, then review the corrected artifact.

## Drafting, Review, and Calibration

`drafting` must preserve:

- evidence qualifications;
- blocking gaps;
- readiness state;
- stable template identifiers; and
- explicitly recorded external-review status.

It must not polish a provisional artifact into language that implies certainty
or approval.

`reviewing-docs` must treat a false readiness claim or a hidden material blocker
as a blocker. It should route the cause instead of treating every issue as a
writing problem.

After export or publication, `calibrating` may compare a Mindpowers draft with a
final version only when the user supplies or points to that version. It records
stable user preferences, not general product-evaluation findings. Do not
automatically ingest the final artifact into a corpus.

## General-Purpose Guardrail

All skill instructions, examples, fixtures, and committed specifications must
remain organization-neutral.

- Do not include private product names, internal system names, company-specific
  acronyms, employee names, or proprietary workflow details.
- Convert real-workflow observations into reusable predicates and anonymized
  scenarios.
- Keep connector names out of the reasoning contract unless the skill is
  explicitly connector-specific.
- Validate edited files for organization-specific terminology before
  completion and surface any uncertain match to the user.

## Documentation and Release Surface

The behaviour changes are user-visible and should be documented as a minor
release. Prepare `0.9.0` consistently across the repository, without tagging,
publishing, or creating a GitHub release unless the user separately requests
those actions.

Update:

- `README.md`: explain contextual conditional-module recommendations,
  provisional continuation, readiness versus approval, and root-cause skill
  routing; add the release to **What's new**;
- `CHANGELOG.md`: add a `0.9.0` entry that distinguishes added, changed, and
  fixed behaviour;
- `.claude-plugin/plugin.json`: synchronize the version and public description
  when the release metadata changes; and
- `.claude-plugin/marketplace.json`: synchronize both version fields and the
  public description with `plugin.json`.

The existing GitHub workflow generates release notes from repository history.
Do not add a parallel release-notes file unless the release process itself
changes.

Do not modify `CONTRIBUTING.md`, `.github/workflows/release.yml`, packaging
scripts, or installation instructions unless baseline testing or release
validation exposes an actual contract change.

## Expected File Changes

The implementation should modify the minimum files justified by failing
baseline scenarios:

- `skills/mindstorming/SKILL.md`
- relevant files under `skills/mindstorming/references/`
- `skills/drafting/SKILL.md`
- `skills/reviewing-docs/SKILL.md`
- `skills/calibrating/SKILL.md` only if baseline testing shows its existing
  final-edit workflow is insufficient
- `skills/validating-problems/SKILL.md` only if resume/update handoff testing
  exposes a real gap
- `README.md`
- `CHANGELOG.md`
- `.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`

Do not edit every template merely to make terminology uniform. Add readiness
language only where the template's consequential action and blocking rule can be
stated clearly and tested.

## Validation Strategy

Use Superpowers `writing-skills` and its RED-GREEN-REFACTOR workflow.

### RED

Run fresh-agent baseline scenarios against the current skills. Include:

1. a central unsupported problem claim where the user is under time pressure;
2. a complex PRD that triggers several conditional modules but whose user asks
   for a fast answer;
3. a user who declines optional validation or research;
4. a review containing mixed evidence, decision, writing, and approval findings;
5. a request with no supplied sources and a broad internal connector available;
6. a provisional artifact whose prose could easily imply false readiness.

Capture the exact failures and rationalizations. Do not change a skill before a
scenario demonstrates the gap.

### GREEN

Make the smallest instruction and template changes that correct the observed
failures. Re-run the same scenarios with the modified skills.

### REFACTOR

Test variations:

- routine versus exploratory work;
- problem brief present versus absent;
- relevant conditional module accepted versus declined;
- material blocker versus optional improvement;
- content-ready with external approval pending; and
- correct route accepted versus skill switch declined.

Close only observed loopholes, keep the main skill concise, and move
template-specific detail into the relevant reference file.

## Acceptance Criteria

- The general actor term is `user`; no new `Owner` actor terminology appears.
- Mindpowers recommends a deliverable when the match is ambiguous or
  consequential, without interrupting obvious routine requests.
- A material unsupported problem claim produces a `validating-problems`
  recommendation and an explicit provisional-continuation option.
- Existing problem-brief findings are consumed without re-asking settled
  questions.
- User-directed source boundaries are respected; optional internet research is
  offered rather than silently performed when no source was identified.
- Conditional modules arise from contextual questions, not a visible batch
  checklist.
- Declining a relevant module produces an explicit readiness consequence.
- Lifecycle status, content readiness, and external approval remain distinct.
- Every `not-ready` result names the material blocker.
- Review findings recommend the correct existing skill and require confirmation
  before switching.
- Drafting and review preserve provisional claims and do not imply unrecorded
  approval.
- Final-edit calibration occurs only from a user-supplied or user-directed final
  artifact.
- README and changelog describe the shipped behaviour in plain language.
- Release metadata uses `0.9.0` consistently across plugin and marketplace
  manifests.
- No release tag, GitHub release, or publication occurs without separate user
  authorization.
- No organization-specific terminology appears in committed skill, template,
  example, test, plan, or changelog content.
