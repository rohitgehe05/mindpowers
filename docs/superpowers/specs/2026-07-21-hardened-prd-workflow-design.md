# Hardened PRD Workflow Design

## Summary

Harden the existing `prd` route inside `mindstorming`. Do not add a separate
PRD skill. The route remains independently usable and may optionally consume a
problem brief from `validating-problems` or an earlier one-pager.

The workflow becomes:

```text
validating-problems (optional)
        ↓
mindstorming → one-pager (optional socialisation)
        ↓
prioritisation elsewhere
        ↓
mindstorming → adaptive, build-ready PRD
        ↓
drafting → reviewing-docs → calibrating
```

The PRD must be rigorous enough for engineering, design, analytics, and
operations to execute without a private side channel. It must also stay
pragmatic: a small reversible internal change should produce a compact PRD,
while an AI, regulated, multi-team, or risky launch should pull in the extra
contracts its risk actually requires.

## Why This Exists

The shipped template has good problem-first, falsifiability, YAGNI, and
non-goal discipline, but its output contract stops at eight high-level
sections. It does not structurally require traceable requirements, acceptance
criteria, telemetry, decision rights, rollout safety, or AI evaluations.

Three no-change baseline runs exposed the practical consequences:

- Under leadership urgency and one pilot anecdote, the route accepted the
  proposed problem as a working premise before the user explicitly narrowed it.
- The weak-evidence run later invented a 30% time-reduction target and a
  one-revision threshold.
- A low-risk internal-tool run invented a two-week measurement window and an
  adoption target of 8 out of 12 users.
- The strong checkout run produced a polished cross-functional outline but
  deferred exact event names, acceptance criteria, latency thresholds, and
  rollout parameters. It was not executable without later side-channel
  decisions.

The failure is primarily one of output shape and omitted elements. Following
the writing-skills framework, the fix should be a positive structural contract
plus observable conditional modules, not a long list of prohibitions.

## Goals

- Produce a PRD whose product decisions and requirements are executable and
  verifiable without relying on the author's memory.
- Preserve direct customer and behavioural evidence, baselines, scope, and
  recency without making problem validation a prerequisite.
- Challenge the chosen solution's premise and record credible alternatives
  without reopening roadmap prioritisation.
- Use stable identifiers so stories, requirements, acceptance criteria,
  metrics, events, risks, and open decisions can be traced or parsed by humans
  and agents.
- Add only the operational, analytics, AI, privacy, integration, and rollout
  detail triggered by observable risk.
- Expose unresolved build blockers instead of manufacturing false precision.
- Keep the PRD route, `validating-problems`, and external prioritisation
  independently usable.

## Non-Goals

- Prioritising the initiative or comparing it against roadmap items.
- Requiring a problem brief, one-pager, formal discovery phase, or a fixed
  amount of research before writing a PRD.
- Turning every PRD into a program charter, launch checklist, architecture
  document, or full DARCI process.
- Choosing technical architecture on engineering's behalf.
- Inventing success thresholds, confidence levels, sample sizes, rollout
  percentages, dates, or owners.
- Replacing implementation tickets, detailed designs, test plans, or runbooks.

## Workflow Boundaries

### Problem validation is optional context

When a relevant problem brief exists, the PRD links it and preserves its
scope, `as_of` date, claim statuses, limitations, conflicts, and unsupported
claims. It does not repeat the whole evidence ledger.

When no brief exists, Mindstorming continues normally. The PRD still records
the evidence basis and baseline available in the current context. Weak evidence
does not automatically stop an already-prioritised initiative, but it remains
labelled provisional and becomes an explicit product risk.

### Prioritisation stays elsewhere

The PRD assumes the direction has been selected for specification. It may
record the supplied priority or decision context, but it must not score,
sequence, or reprioritise the work.

### A one-pager is optional

If an approved one-pager exists, the PRD links it, carries forward its chosen
direction and constraints, and resolves its open product questions. If no
one-pager exists, the PRD asks only for the context needed to make the chosen
direction coherent.

## Adaptive Document Contract

Use one compact core plus conditional modules. A module is included because a
predicate is true, not because the template happens to have space for it.

### Core contract for every PRD

1. **TL;DR and ownership**
   - One-paragraph decision summary: user, problem, chosen direction, intended
     outcome, and present readiness.
   - Product owner/PIC.
   - Decision owner only when different from the product owner.

2. **Problem, evidence, and baseline**
   - Solution-free problem and affected user/workflow.
   - Current behaviour or baseline, with source, scope, and recency.
   - Evidence limitations and unsupported assumptions.
   - Links to a problem brief or one-pager when consumed.

3. **Users, use cases, goals, and non-goals**
   - Primary user and highest-frequency or highest-consequence use cases.
   - Desired outcome and falsifiable hypothesis where useful.
   - Explicit in-scope and out-of-scope boundaries.

4. **Chosen solution and premise check**
   - Functional shape and primary flow, including failure or empty states that
     materially affect behaviour.
   - At least one credible alternative, including a non-product alternative
     when plausible, and why the selected direction still fits.
   - Assumptions that could make the solution fail to address the problem.

5. **Engineering contract**
   - User stories use stable `US-###` identifiers.
   - Product requirements use stable `REQ-###` identifiers and describe
     required behaviour, not implementation tasks.
   - Acceptance criteria use stable `AC-###` identifiers, link to a
     requirement, and state an observable, verifiable condition.
   - Edge cases and failure states attach to the relevant requirement rather
     than living in a generic catch-all checklist.

6. **Measurement contract**
   - Outcome metric, current baseline when available, target or decision rule,
     measurement method, and guardrails.
   - Supplied or explicitly accepted thresholds only. A missing threshold is a
     named open decision, not an invented number.

7. **Risks, dependencies, and open decisions**
   - Decision-changing risks and dependencies, with a mitigation or owner when
     known.
   - Open decisions use stable `OD-###` identifiers and state why they matter.
   - Readiness says either `build-ready` or `needs-decision`; the latter lists
     the exact blockers.

Sections may be combined for a small PRD, but every core field remains visible.
For example, a reversible internal action may fit in four short sections with
one story, two requirements, and a handful of acceptance criteria.

### Conditional modules

| Observable predicate | Add this module |
|---|---|
| More than one team, approver, or operating owner must act | Stakeholders and decision rights: driver, approver, contributors, and informed groups. Do not force a full DARCI table for a single-team change. |
| Success cannot be observed with existing measurement | Telemetry contract: metric-to-event mapping, exact event name, trigger, required properties, prohibited sensitive fields, consumer/dashboard, and analytics owner or sign-off. |
| The product behaviour depends on model output or another probabilistic system | Evaluation contract: task, representative evaluation cases, grader or rubric, user-accepted threshold, failure classes, human fallback, safety checks, and production monitoring. |
| Release failure could materially harm users, revenue, data, or operations | Rollout and rollback: stages, entry/exit signals, monitoring, rollback trigger, and accountable owner. |
| The change handles sensitive data, permissions, abuse, or regulated activity | Privacy, security, and compliance: data handled, access, retention, consent, misuse cases, and required review. |
| The change migrates data or depends on complex integrations/state | Integration and state contract: upstream/downstream dependencies, states, errors, compatibility, migration, and recovery. |
| The change creates customer-support or operating work | Operational readiness: support flow, alerts, documentation, escalation, and operating owner. |

If a predicate is false, omit the module. If applicability is unknown and could
change scope or safety, ask one decision-critical question.

## Interaction Contract

### Inspect before asking

Read supplied evidence, problem briefs, one-pagers, research, analytics,
support material, designs, and relevant existing product behaviour first. Do
not ask the user to repeat accessible context.

### Establish the chosen direction

Confirm that prioritisation happened elsewhere and identify the selected
direction. If the user is still comparing live directions, route to a
`decision-doc` or one-pager rather than disguising an unresolved choice as a
PRD.

### Route by readiness gap

For exploratory PRDs, ask exactly one highest-value question per turn. Choose
the unknown most likely to change scope, user-visible behaviour, measurement,
or launch safety. For a routine PRD with a prior locked pattern, a short batch
remains acceptable under Mindstorming's existing adaptive elicitation rule.

### Do not fake precision

Never invent targets, windows, confidence methods, sample sizes, event names,
rollout percentages, owners, or dates. Recommend a default only when it is a
real product judgment and label it as a proposal requiring approval. Otherwise
record a named open decision and its readiness impact.

### Present at the right granularity

Group the design into a small number of coherent approval units. A small change
should not require seven conversational gates merely because the core contract
has seven concepts. A high-risk PRD may need separate approval for measurement,
AI evaluation, or rollout safety.

## Build-Ready Test

A PRD is `build-ready` only when:

- the chosen direction and non-goals are explicit;
- evidence claims are scoped and unsupported assumptions remain visible;
- every requirement has at least one linked, verifiable acceptance criterion;
- user-visible failure states and decision-changing edge cases are resolved;
- success and guardrails have a baseline, target/decision rule, and measurement
  method, or the user explicitly accepts a qualitative decision rule;
- required telemetry or AI evaluations are specified when their predicates are
  true;
- decision rights, dependencies, rollout safety, and operating ownership are
  clear when their predicates are true; and
- no open decision can still change scope, required behaviour, measurement, or
  launch safety.

Otherwise mark the PRD `needs-decision` and list the blockers. This is a
readiness statement, not a prioritisation decision or permission to ship.

## File and Frontmatter Changes

Retain the existing Mindpowers spec frontmatter. Permit these optional links:

```yaml
problem: docs/mindpowers/problems/YYYY-MM-DD-<slug>.md
one_pager: docs/mindpowers/specs/YYYY-MM-DD-one-pager-<slug>.md
```

Do not add a mandatory priority field. Keep ownership in the existing `owner`
field; record richer decision rights in the conditional body module.

## Drafting and Review Integration

`drafting` already reads the matched template and treats its standards as hard
requirements. Update its PRD quality-bar example so it checks traceable
  requirements, verifiable acceptance criteria, evidence boundaries, and honest
  readiness, not only measurable success criteria.

`reviewing-docs` already uses a first-time implementer persona for PRDs. The
expanded template becomes its objective rubric. A review should treat a
`build-ready` claim with unresolved contract fields as a blocker.

## Testing Strategy

Use the writing-skills RED-GREEN-REFACTOR cycle.

### RED baseline

Retain the three fresh-context runs described under “Why This Exists.” The
exact baseline failures become regression targets: premise inflation, invented
numbers, and polished but deferred handoff details.

### GREEN scenarios

Re-run fresh-context agents on:

1. an urgent AI PRD backed by one anecdote;
2. a build-ready checkout PRD with strong behavioural evidence and a supplied
   success threshold; and
3. a reversible internal row action whose process burden must remain small.

Pass criteria:

- does not turn urgency, stakeholder belief, or engineering readiness into
  problem evidence;
- preserves supplied evidence scope and marks broader claims provisional;
- does not invent any threshold, window, sample, owner, event, or rollout
  value;
- asks about the highest-impact readiness gap rather than walking a generic
  questionnaire;
- keeps the small PRD compact while retaining identifiers and testable
  acceptance criteria;
- produces exact `US-`, `REQ-`, `AC-`, and `OD-` contracts;
- adds telemetry, AI eval, decision-right, operational, privacy, integration,
  or rollout modules only when their predicates are true; and
- marks the result `needs-decision` when a build-critical value remains open.

### REFACTOR

Capture any new rationalisation or omission, change only the minimum guidance
needed, and rerun the affected scenario. Run repository structure and package
checks afterward. Record model portability as unverified if only one model
family is available.

## Industry-Guidance Fit

This design incorporates:

- [NASA software requirements guidance](https://swehb.nasa.gov/spaces/SWEHBVD/pages/102695426/SWE-051%2B-%2BSoftware%2BRequirements%2BAnalysis?desktop=true&macroName=set-data)
  on clear, complete, unambiguous, verifiable requirements and traceability;
- Atlassian guidance on [user stories](https://www.atlassian.com/agile/project-management/user-stories),
  [acceptance criteria](https://www.atlassian.com/work-management/project-management/acceptance-criteria),
  and its [PRD template](https://www.atlassian.com/software/confluence/templates/product-requirements)
  for purpose, assumptions, user value, testability, success metrics, and
  explicit out-of-scope boundaries;
- [GOV.UK service measurement guidance](https://www.gov.uk/service-manual/service-standard/point-10-define-success-publish-performance-data)
  and [baseline guidance](https://www.gov.uk/service-manual/design/understanding-and-meeting-policy-intent)
  for defining success, measurement sources, and pre-change baselines;
- Basecamp's [risk and rabbit-hole guidance](https://basecamp.com/shapeup/1.4-chapter-05)
  for resolving decision-changing unknowns before handing work to a delivery
  team; and
- OpenAI's [eval-driven system design](https://developers.openai.com/cookbook/examples/partners/eval_driven_system_design/receipt_inspection)
  for making evaluations a core product contract when behaviour is
  probabilistic rather than bolting them on after implementation.

It also incorporates anonymised pilot feedback asking for clearer ownership,
fact-based problem framing, baselines, user stories, acceptance criteria,
telemetry, rollout readiness, and a more machine-consumable engineering
handoff. No private organisation or document is referenced in public files.

## Implementation Boundary

This cycle is complete when:

- the PRD reference implements the adaptive core and conditional modules;
- Mindstorming can link an optional problem brief or one-pager into a PRD;
- drafting and review enforce the expanded contract;
- README and changelog describe the hardened PRD route without implying that
  Mindpowers performs prioritisation;
- all package versions and distribution bundles are consistent; and
- GREEN and REFACTOR runs pass the three real scenarios without inventing
  precision or bloating the small PRD.
