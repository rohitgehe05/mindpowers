# Problem brief schema

Write the brief to `docs/mindpowers/problems/YYYY-MM-DD-<slug>.md` relative to the invoking workspace. Use these exact frontmatter fields:

```yaml
---
type: problem-validation
date: YYYY-MM-DD
as_of: YYYY-MM-DD
topic: <kebab-case slug>
owner: <name or handle>
product_stage: pre-product | existing | mature
decision_to_inform: <decision>
desired_outcome: <customer or business condition>
scope: <users, workflow, context, and period>
evidence_status: supported | partially-supported | unsupported | contradicted
decision: ready-to-socialize | gather-evidence | stop
---
```

# Body contract

Write these sections in order:

1. **Current assessment:** State the concise evidence status and workflow decision.
2. **Scoped problem statement:** State a solution-free problem no broader than the evidence.
3. **Decision context:** Record the desired outcome, decision to inform, and what remains out of scope.
4. **Claim ledger:** Record each claim, its status, supporting or weakening evidence, limitations, and conflicts.
5. **Evidence ledger:** Record the source or link, evidence class, raw observation, scope, recency, limitations, and interpretation.
6. **Alternative framings and mechanisms:** Include at least two plausible alternatives and any credible non-product explanation.
7. **Disconfirming evidence:** Record evidence already observed or still needed that could make the framing false.
8. **What is not supported:** List claims the team must not repeat as fact.
9. **Next validation action:** Include one specific evidence assignment for `gather-evidence`; otherwise explain why the team should socialise or stop.
10. **Handoff:** State how a one-pager may use the result and which scope, status, limitations, and `as_of` caveats it must preserve.

Keep stable claim, status, and evidence-class values for traceability, but do not
leave them unexplained in user-facing prose or tables. Use a plain display label
or explain the term at first use:

- `Existence`: whether the problem happened;
- `Audience`: who experiences it;
- `Materiality`: whether the impact matters for the decision;
- `Mechanism / context`: the conditions or possible explanations;
- `anchor`: direct starting evidence;
- `corroborating`: supporting evidence from another source;
- `hypothesis-only`: a clue or belief, not proof;
- `partially-supported`: some evidence exists, but important gaps remain;
- `unsupported`: no adequate evidence yet; and
- `contradicted`: credible evidence points the other way.

Describe evidence provenance in common words: where it came from and how it was
collected.

# Evidence assignment

Use this contract whenever the workflow decision is `gather-evidence`:

| Field | Required content |
|---|---|
| Claim to test | Name one decision-critical claim. |
| Evidence needed | State what kind of real-world evidence can resolve the gap. |
| Source or participant profile | Identify the relevant population, system, record, or artefact without inventing a sample size. |
| Method | Specify the interview, observation, analysis, or record review. |
| Observation or measure | State exactly what to observe or measure. |
| Strengthening result | State what would strengthen the claim. |
| Weakening or contradicting result | State what would weaken or contradict the claim. |
| Decision affected | Name the decision that would change based on the result. |

Ask the user to provide or explicitly accept any threshold before including it. Do not invent sample sizes, durations, confidence scores, or success thresholds.

# Completed example

```markdown
---
type: problem-validation
date: 2026-07-21
as_of: 2026-07-21
topic: agentic-prd-workflow
owner: product-workflow-team
product_stage: existing
decision_to_inform: what problem claims may be socialised in an agentic PRD workflow one-pager
desired_outcome: PMs produce engineering-ready PRDs with less delay and downstream rework
scope: one pilot PM's account of that PM's most recent PRD workflow, reported on 2026-07-21
evidence_status: partially-supported
decision: gather-evidence
---

## Current assessment

Some evidence shows that the problem happened in one pilot PM's reported
workflow. Important gaps remain: there is no adequate evidence yet about who
else experiences it, whether the impact matters, or what conditions explain it.
Gather evidence before describing the problem beyond this pilot or claiming
meaningful delay or rework.

## Scoped problem statement

In one pilot PM's most recent PRD workflow, the PM reported that reaching an engineering-ready draft took too long, varied across drafts, and left edge cases unresolved. The available evidence does not show that this pattern applies to other PMs or that it caused material downstream impact.

## Decision context

- Desired outcome: Help PMs produce engineering-ready PRDs with less delay and downstream rework.
- Decision to inform: Decide which problem claims may be included in an agentic PRD workflow one-pager.
- Out of scope: Prioritising the initiative, selecting an agentic solution, designing a pilot, or approving a build.

## Claim ledger

| Claim (plain meaning) | Status (plain meaning) | Evidence | Limitations and conflicts |
|---|---|---|---|
| Existence (did the problem happen?) | partially-supported — some evidence, important gaps remain | One pilot PM reported delay, inconsistency, and missed edge cases in that PM's most recent PRD workflow. | Self-report from one workflow with no artefact review or supporting behaviour from another source. |
| Audience (who experiences it?) | unsupported — no adequate evidence yet | No evidence covers other PMs, teams, product areas, or workflow contexts. | The pilot PM may not represent any broader audience. |
| Materiality (does the impact matter?) | unsupported — no adequate evidence yet | No elapsed time, revision count, clarification load, rework, or business consequence was supplied. | Leadership urgency does not establish impact. |
| Mechanism / context (what conditions may explain it?) | unsupported — no adequate evidence yet | No evidence distinguishes authoring difficulty from process, review, training, data access, incentives, or organisational constraints. | Engineering readiness does not explain the reported symptom. |

## Evidence ledger

| Source | Class | Raw observation | Scope | Recency | Limitations | Interpretation |
|---|---|---|---|---|---|---|
| Pilot PM feedback supplied in conversation | anchor — direct starting evidence | The pilot PM reported that PRD work took too long, was inconsistent, and missed edge cases. | One PM's most recent PRD workflow | Reported 2026-07-21 | No transcript, artefact, telemetry, elapsed time, or downstream record was supplied. | Supports that the problem happened only in the pilot's workflow; does not show a broader audience, meaningful impact, or what explains the pattern. |
| Leadership request for a proposal | hypothesis-only — a clue or belief, not proof | Leadership wants a proposal quickly. | Internal decision context | Current as of 2026-07-21 | Reflects urgency, not customer or workflow evidence. | Does not strengthen any problem claim. |
| Engineering readiness | hypothesis-only — a clue or belief, not proof | Engineering is ready to work on the proposed direction. | Internal delivery context | Current as of 2026-07-21 | Reflects capacity, not problem evidence. | Does not strengthen any problem claim. |

## Alternative framings and mechanisms

1. The friction may sit in review handoffs and decision latency rather than initial PRD authoring.
2. The missed edge cases may reflect inconsistent inputs, templates, training, or access to prior decisions rather than a missing agentic workflow.

## Disconfirming evidence

The framing would weaken if the pilot's recent PRDs reached engineering-ready status without unusual elapsed time, revision rounds, clarification, or rework. It would also weaken as a broader audience claim if comparable PM workflows do not show the pattern.

## What is not supported

- PMs generally take too long to produce PRDs.
- PRD inconsistency is common across teams.
- Missed edge cases create material engineering rework.
- The workflow problem is caused by a lack of agentic tooling.
- The initiative is prioritised, approved, or ready to build.

## Next validation action

| Field | Assignment |
|---|---|
| Claim to test | Whether the impact matters within the pilot PM's most recent PRD workflow. |
| Evidence needed | A reconstruction of the workflow from first draft to engineering-ready, supported by available document history and downstream records. |
| Source or participant profile | The pilot PM, the most recent PRD artefact and revision history, and engineering clarification or rework records tied to that PRD. |
| Method | Conduct a recent-behaviour interview and inspect the corresponding artefacts and records. |
| Observation or measure | Record elapsed time, revision rounds, blocked handoffs, clarification requests, and downstream rework without applying an invented threshold. |
| Strengthening result | The records show meaningful delay, repeated revision, blocked handoffs, clarification, or rework attributable to the PRD workflow. |
| Weakening or contradicting result | The records show a normal workflow with little delay or rework, or show that the main constraint occurred outside PRD authoring. |
| Decision affected | Whether the one-pager may claim meaningful impact and whether the problem statement should focus on authoring or another workflow constraint. |

## Handoff

A one-pager may state only that one pilot PM reported this pattern in that PM's
most recent PRD workflow as of 2026-07-21. Preserve the `partially-supported`
status—some evidence exists, but important gaps remain—and the single-workflow
scope. State plainly that there is no adequate evidence yet about a broader
audience, meaningful impact, or what conditions explain the pattern. Do not
imply prioritisation, approval, or permission to build.
```
