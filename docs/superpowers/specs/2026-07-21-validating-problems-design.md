# Validating Problems Skill Design

## Summary

Add a standalone `validating-problems` skill before `mindstorming`. It helps a PM determine what can defensibly be said about a problem before a one-pager socialises a solution direction.

The skill must remain useful when evidence is incomplete without weakening the standard for calling a claim supported. It inspects available context first, evaluates evidence claim by claim, challenges premises and alternative explanations, asks one high-value question at a time, and stops the conversation when the next useful step requires real-world evidence.

The workflow becomes:

```text
validating-problems (optional, standalone)
        ↓
mindstorming → one-pager / socialisation
        ↓
prioritisation elsewhere
        ↓
mindstorming → PRD
        ↓
drafting → reviewing-docs → calibrating
```

Problem validation and `mindstorming` remain independently usable. This design covers only problem validation and its one-pager handoff. Hardening the PRD route is a separate second skill-authoring cycle.

## Why This Exists

Generic assistants usually produce reasonable discovery advice but behave poorly under delivery pressure. In five no-skill baseline runs on the same PM scenario, all five:

- batched six to eight questions rather than routing to the most decision-relevant unknown;
- moved prematurely into pilots or solution design;
- invented sample sizes, durations, or success thresholds;
- omitted claim-level evidence statuses; and
- failed to seek evidence that could disconfirm the proposed framing.

Several also described the problem as broadly real even though the only direct evidence came from one pilot PM. The new skill exists to correct those behaviours, not to reproduce a generic discovery checklist.

## Goals

- Produce a scoped, solution-free problem definition whose claims are traceable to evidence.
- Prefer direct customer and behavioural input while remaining pragmatic when evidence is incomplete.
- Distinguish evidence strength from the decision to socialise, gather evidence, or stop.
- Route questions according to product stage, decision risk, and the weakest decision-critical claim.
- Challenge the premise, alternative framings, and plausible non-product explanations.
- Generate a durable problem brief that `mindstorming` can consume without repeating discovery.
- Work as a useful conversational workflow even when the user does not want a one-pager.

## Non-Goals

- Prioritising the problem against a roadmap or portfolio.
- Selecting, specifying, prototyping, or validating a solution.
- Evaluating solution value, usability, feasibility, or business viability.
- Requiring statistically representative research or arbitrary sample counts.
- Replacing researchers, analytics work, or customer contact with agent inference.
- Hardening the PRD template or changing the drafting and review contracts in this cycle.

## Skill Shape

Create:

```text
skills/validating-problems/
├── SKILL.md
└── references/
    └── problem-brief.md
```

Keep the interaction rules and decision logic in `SKILL.md`. Put the output schema and a concise completed example in `references/problem-brief.md`. Do not add scripts: this workflow is judgement-heavy and does not contain a repeated deterministic operation worth automating.

The skill description must contain triggering conditions only. It should fire when a user wants to test, sharpen, frame, validate, or gather evidence for a customer or business problem before pitching, prioritising, or writing a PRD. It must not summarize the workflow in the description.

## Core Concepts

### Decision context

Begin by establishing or inferring four boundaries:

- `decision_to_inform`: the decision this work will support;
- `desired_outcome`: the customer or business condition that should improve;
- `scope`: the exact users, workflow, context, and time period covered; and
- `out_of_scope`: especially prioritisation and solution selection.

Do not force the user to restate boundaries already available in linked documents, repository files, research, data, or the conversation.

### Claim model

Evaluate four claims independently:

| Claim | Question |
|---|---|
| Existence | Does the problem demonstrably happen? |
| Audience | For whom, where, and when does it happen? |
| Materiality | What customer or business consequence does it create? |
| Mechanism / context | What conditions, behaviours, or constraints appear to produce or sustain it? |

Use `mechanism / context`, not `cause`. Causal explanations may remain hypotheses; causal proof is not a prerequisite for socialising a well-supported problem.

Each claim receives one status:

- `supported`: the scoped claim has relevant evidence strong enough for the current decision;
- `partially-supported`: some parts are supported but important scope, coverage, or mechanism gaps remain;
- `unsupported`: available material does not substantiate the claim;
- `contradicted`: relevant evidence materially conflicts with the claim.

Statuses are scope- and time-bound. Record `as_of` and never generalise beyond the users, workflow, or context represented by the evidence.

### Evidence model

Prefer evidence that reflects what people did or experienced over what stakeholders hope will happen.

**Anchor evidence** includes observed workflow behaviour, product telemetry, transactions, churn or funnel data, support cases, direct interviews about recent past behaviour, workarounds and artefacts, and workflow observation.

**Corroborating evidence** includes stakeholder input, prior internal documents and research, sales or operations reports, customer-success patterns, and relevant external benchmarks.

**Hypothesis-only inputs** include PM or executive judgement, isolated feature requests, AI reasoning, trend narratives, survey intent, and proposed solutions.

The categories are a starting point, not a mechanical score. Assess every item across:

- directness: observed, reported, or inferred;
- relevance: exact workflow or adjacent context;
- recency;
- coverage across relevant users and situations;
- reliability and provenance; and
- direction: supports, weakens, or is ambiguous about the claim.

Separate raw observation from interpretation. Direct evidence is not automatically decisive: a recent observation from an atypical account may be less probative than repeated telemetry and support records from the scoped population.

### Stage-aware evidence routing

Adjust the most useful evidence to the product stage without lowering the meaning of `supported`:

| Stage | Prefer |
|---|---|
| Pre-product | direct accounts of recent pain, observed current workflows, workarounds, artefacts, and evidence that users already spend effort coping |
| Existing product | behavioural and operational data showing the pattern, paired with research or support evidence explaining the context |
| Mature or paid product | quantified customer and business impact, segmented behavioural evidence, churn or revenue consequences, and direct evidence explaining the pattern |

Coverage depends on the decision and relevant user variation, not a universal sample size. Seek stable patterns across the user types and contexts inside the proposed scope. If coverage is narrow, narrow the claim.

## Interaction Contract

### Inspect before asking

When tools or files are available, inspect the relevant documents, research, analytics summaries, support material, and previous problem briefs first. Cite the source or path in the evidence ledger. Never ask the user to transcribe information the agent can access safely.

### Route to one question

Each conversational turn contains:

1. a concise current assessment;
2. the decision-critical claim and its current status;
3. evidence that supports, weakens, or limits it; and
4. exactly one highest-value question, with a concrete example only when helpful.

Choose the question whose answer is most likely to change the decision, narrow the scope, or distinguish between competing explanations. Do not march through a fixed questionnaire.

### Challenge the premise

At relevant moments, test:

- whether the statement contains a solution disguised as a problem;
- who does not experience the problem and why;
- who has been excluded from the evidence;
- who benefits from the current state;
- whether incentives, policy, process, training, data access, or organisational constraints explain the symptom;
- whether the team's own assumptions or process contribute to it; and
- what evidence would make the proposed framing false.

Generate at least two plausible alternative framings or mechanisms before settling on the final problem statement. Do not require every prompt above when it cannot affect the decision.

### Stop questioning when evidence must come from the world

Do not simulate evidence through more conversation. When the remaining gap requires research, observation, or data, issue one specific evidence assignment containing:

- claim to test;
- evidence needed;
- source or participant profile;
- method;
- observation or measure;
- what would strengthen the claim;
- what would weaken or contradict it; and
- which decision the result will affect.

If a threshold is useful, ask the user to provide or accept it before the test. Never invent sample sizes, durations, confidence scores, or success thresholds and present them as standards.

## Overall Decision

Keep evidence status separate from workflow action:

- `ready-to-socialize`: the decision-critical claims are sufficiently supported for the stated scope, and limitations are explicit;
- `gather-evidence`: a named evidence gap could materially change the framing or decision;
- `stop`: the problem is contradicted, immaterial for the stated decision, or no longer the problem that should be investigated.

`ready-to-socialize` does not mean prioritised, approved, or ready to build. A partially supported problem may still be socialised if it is explicitly presented as a hypothesis and the unresolved claims are visible.

## Artifact Contract

Write the result, relative to the invoking workspace, to:

```text
docs/mindpowers/problems/YYYY-MM-DD-<slug>.md
```

Use this frontmatter:

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

The body contains:

1. **Current assessment** — concise status and decision.
2. **Scoped problem statement** — solution-free and no broader than the evidence.
3. **Decision context** — desired outcome, decision to inform, and out of scope.
4. **Claim ledger** — claim, status, evidence, limitations, and conflicts.
5. **Evidence ledger** — source or link, type, raw observation, scope, recency, limitations, and interpretation.
6. **Alternative framings and mechanisms** — including non-product explanations.
7. **Disconfirming evidence** — observed or still needed.
8. **What is not supported** — claims the team must not repeat as fact.
9. **Next validation action** — a specific evidence assignment when the decision is `gather-evidence`; otherwise the reason to socialise or stop.
10. **Handoff** — how a one-pager may use the result and the caveats it must preserve.

If the workspace is shared or public, warn before writing customer-sensitive evidence and offer a private or ignored location, consistent with the existing Mindpowers file-safety convention.

## Mindstorming Integration

Update `mindstorming` and the one-pager reference so that:

- `mindstorming` continues to work independently when no problem brief exists;
- if a relevant brief exists or is supplied, it reads the brief before elicitation and does not re-ask settled questions;
- a one-pager spec may add `problem: <path>` to its frontmatter;
- `supported` evidence may be stated within its recorded scope;
- `partially-supported` evidence may appear only with the qualification intact;
- `unsupported` claims may be discussed as hypotheses, not facts;
- `contradicted` claims trigger a warning and cannot be used as the premise of the pitch without explicit reframing; and
- validation never implies prioritisation, approval, or permission to build.

Do not make `validating-problems` a mandatory dependency of `mindstorming`; the two skills must remain independently usable.

## Worked Behaviour Example

Input:

> We need an agentic PRD workflow. PMs take too long, are inconsistent, and miss edge cases. One pilot PM gave detailed feedback. Leadership wants a proposal tomorrow and engineering is ready.

Expected first response shape:

```text
Current assessment: partially supported, but only within one pilot PM's workflow.

Existence is partially supported by one direct report. Audience, materiality, and mechanism are unsupported beyond that case. Leadership urgency and engineering availability do not strengthen the problem evidence.

The most decision-relevant gap is materiality: whether PRD quality creates meaningful delay or rework in the current workflow.

For the pilot's most recent PRD, what actually happened from first draft to engineering-ready—elapsed time, revision rounds, and downstream clarification or rework?
```

The skill must not respond with a multi-question intake, call the problem broadly validated, recommend a production build, or prescribe a two-week pilot with an invented sample size.

## Testing Strategy

Use the writing-skills RED-GREEN-REFACTOR loop.

### Existing RED evidence

Retain the five baseline outputs as the behavioural baseline. The repeated failures are the test targets listed under “Why This Exists.”

### GREEN tests

Run at least five fresh-context agents against pressure scenarios covering:

1. leadership urgency and engineering readiness;
2. one vocal customer or executive request presented as a market-wide problem;
3. strong telemetry with a weak causal story;
4. persuasive interview evidence that conflicts with behavioural data; and
5. a user pushing the agent to skip validation and draft the solution.

Each run must use the skill as a user would, without leaking the expected answer or prior diagnosis.

Pass criteria per run:

- inspects supplied context instead of re-asking for it;
- distinguishes decision context from evidence status;
- evaluates the four claims independently;
- scopes conclusions to evidence and recency;
- prioritises direct or behavioural evidence without treating the hierarchy mechanically;
- asks exactly one decision-relevant question per turn;
- surfaces at least one plausible alternative or disconfirming route before finalising;
- does not invent thresholds, sample sizes, or confidence scores;
- does not move into solution or pilot design prematurely; and
- ends with a valid artifact decision: socialise, gather evidence, or stop.

### REFACTOR tests

Capture the agents' exact rationalisations for any violation, revise only the minimum instructions needed to close those loopholes, and rerun the affected scenarios. Validate the folder structure and frontmatter with the repository's available skill validator. If multiple target model families are available, forward-test at least one strong and one smaller model; otherwise record that model portability remains unverified.

## Failure and Edge Cases

- **No evidence is available:** mark claims unsupported and produce the smallest useful evidence assignment; do not manufacture a verdict.
- **Evidence conflicts:** preserve both observations, assess relevance and provenance, and ask what would distinguish the explanations.
- **Only one strategic customer is represented:** support only that account and workflow unless corroborating evidence broadens the scope.
- **The user supplies a feature request:** translate it into the underlying job, friction, or consequence before assessing the problem.
- **The user asks to proceed despite gaps:** preserve the evidence status; allow socialisation only as an explicitly labelled hypothesis.
- **The user wants prioritisation:** hand off the problem brief to the external prioritisation workflow without changing its evidence status.
- **The user wants solution validation:** hand off to `mindstorming`; do not import solution risk testing into this skill.

## Industry-Guidance Fit

This design deliberately incorporates:

- [GOV.UK discovery guidance](https://www.gov.uk/service-manual/agile-delivery/how-the-discovery-phase-works) and [user research guidance](https://www.gov.uk/service-manual/user-research/user-research-in-discovery) on clear discovery goals, current behaviour, whole-journey research, mixed evidence, problem sizing, and stopping as a valid outcome;
- [MITRE's Problem Framing Canvas](https://itk.mitre.org/wp-content/uploads/2021/01/Problem-Framing-Canvas-Color-Print.pdf) for premise, exclusion, status-quo beneficiary, and alternative-framing prompts;
- Strategyzer's [Test Card](https://www.strategyzer.com/library/validate-your-ideas-with-the-test-card) and [Learning Card](https://www.strategyzer.com/library/capture-customer-insights-and-actions-with-the-learning-card) for separating hypothesis, test, observation, learning, and action; and
- Product Talk's [Opportunity Solution Tree](https://www.producttalk.org/glossary-discovery-opportunity-solution-tree/) for outcome-to-opportunity separation.

[SVPG's value, usability, feasibility, and viability risks](https://www.svpg.com/four-big-risks/) remain out of this skill because they evaluate proposed solutions. They belong in the later Mindstorming and PRD design cycle.

## Implementation Boundary

This cycle is complete when:

- `skills/validating-problems/` exists and passes structural validation;
- GREEN scenarios demonstrate the interaction and evidence contract;
- the problem brief artifact is generated correctly in a dry run;
- `mindstorming` and `one-pager` can consume, but do not require, the brief; and
- the README describes the optional validation step without implying that prioritisation occurs inside Mindpowers.

Do not change the PRD template in this cycle. Begin B only after A has passed its tests and been reviewed independently.
