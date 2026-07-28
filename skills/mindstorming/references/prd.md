# PRD template

Use after a direction has been selected for specification. Prioritisation
happens elsewhere. A PRD defines the product decisions and observable contract
needed to build and evaluate the selected direction.

**Not one-pager:** a one-pager earns alignment on a direction and stops before
build-ready detail. A PRD carries the selected direction into user behaviour,
requirements, acceptance criteria, measurement, and risk handling.

**Not decision-doc:** a decision-doc weighs live alternatives. If the team is
still choosing between directions, route there instead of disguising an open
choice as a PRD.

## Optional upstream inputs

A PRD remains independently usable. Never require a problem brief, one-pager,
or a new validation exercise before proceeding.

When a relevant problem brief exists, read it before elicitation. Preserve its
scope, `as_of` date, evidence statuses, limitations, conflicts, and unsupported
claims. Link it in frontmatter:

```yaml
problem: docs/mindpowers/problems/YYYY-MM-DD-<slug>.md
```

When an approved one-pager exists, carry forward its selected direction,
constraints, and unresolved product questions. Link it in frontmatter:

```yaml
one_pager: docs/mindpowers/specs/YYYY-MM-DD-one-pager-<slug>.md
```

Neither input implies prioritisation, approval to ship, or strong problem
evidence. When evidence is incomplete, proceed with the PRD if the direction
was selected elsewhere, keep the claim provisional, and make the evidence gap
an explicit risk. Leadership urgency and engineering readiness may influence
an upstream prioritisation decision, but they do not substantiate the customer
or business problem. Record the supplied prioritisation decision as context;
do not infer or revisit it inside the PRD.

## Evidence bar for build readiness

A PRD may be drafted provisionally with incomplete evidence. Build readiness is
a separate judgment: ask whether the evidence is strong enough for this
product, audience, scope, and release action. Evidence is not sufficient merely
because it exists, is direct, or was accepted by a senior user. Consider its
relevance, recency, coverage, reliability, limitations, and any evidence that
points the other way.

Weak evidence blocks build readiness only when the gap could materially change
the purpose, direction, audience or scope, product behaviour, measurement, or
risk. Keep provisional drafting available, mark the PRD `needs-decision`, and
name the evidence blocker in common words. Do not turn an evidence gap into an
`OD-###` unless a product or measurement choice is also unresolved.

For example, three recent enterprise interviews may support an
enterprise-scoped problem claim. They do not support an irreversible rollout
to all customers when smaller customers have not been studied.

## Adaptive rule

Use the core contract for every PRD. Combine adjacent sections when the change
is small, but keep every core field visible. Add a conditional module only when
its observable predicate is true.

A reversible single-team change can fit in four short sections with one user
story and a few requirements. AI, regulated, multi-team, migration-heavy, or
high-impact work needs the additional contracts its risks trigger.

## Core contract

Write these concepts in order. Adjacent concepts may share a heading in a
small PRD.

### 1. TL;DR and ownership

- State the user, problem, selected direction, intended outcome, and current
  readiness in one short paragraph.
- Name the product owner or PIC. Name a separate decision owner only when one
  exists.
- State `Readiness: build-ready` or `Readiness: needs-decision`.

### 2. Problem, evidence, and baseline

- State the solution-free problem and affected workflow.
- Record current behaviour or the closest honest baseline, plus source, scope,
  and recency.
- Clarify an ambiguous denominator, population, aggregation, or time window
  before repeating the baseline as fact.
- Separate observed or reported evidence from interpretation.
- Preserve qualifications from a problem brief. Without a brief, state which
  claims are direct or behavioural evidence and which remain assumptions.
- If no numeric baseline exists, describe the current workflow or failure mode.
  Do not invent a number.

### 3. Users, use cases, goals, and non-goals

- Name the primary user and the highest-frequency or highest-consequence use
  cases.
- State the desired outcome and, when useful, a testable prediction plus the
  result that would show it is wrong.
- Define what is in scope and explicitly out of scope.

### 4. Selected solution and premise check

- Describe required product behaviour and the primary user flow, including
  material empty, error, permission, and recovery states.
- Record at least one credible alternative and why the selected direction fits
  better. Include a non-product alternative when one is plausible.
- Keep the full set of load-bearing assumptions that could make the selected
  solution fail to address the problem.
- For each load-bearing assumption, record one plain observation that would
  weaken it or cause the team to change direction. Gather these one assumption
  and one observation at a time in exploratory conversation.
- If an upstream document already assessed alternatives, link it and summarize
  the selected rationale instead of reopening prioritisation.

### 5. Engineering contract

Use stable identifiers. Keep each row atomic so humans and agents can trace the
contract.

**User stories**

| ID | User, job, and value |
|---|---|
| `US-001` | As a specific user, I want a specific capability so that I receive a specific outcome. |

**Requirements**

| ID | Story | Required product behaviour |
|---|---|---|
| `REQ-001` | `US-001` | State observable required behaviour without prescribing an implementation task. |

**Acceptance criteria**

| ID | Requirement | Verifiable condition |
|---|---|---|
| `AC-001` | `REQ-001` | State the observable condition that proves the requirement is satisfied. Use Given/When/Then only when sequence matters. |

Attach edge cases and failure states to the affected `REQ-###` and `AC-###`.
Every requirement needs at least one linked acceptance criterion. Preserve IDs
unchanged through drafting and review.

### 6. Measurement contract

Record:

- outcome metric or qualitative decision rule;
- current baseline when available;
- target or decision threshold and its understandable basis;
- measurement method and source; and
- guardrails that prevent a local improvement from hiding wider harm.

A target or threshold needs at least one recorded basis: a baseline, benchmark,
customer expectation, research or test, financial or operational requirement,
or deliberate business trade-off. User acceptance records who has authority to
choose the number; it does not show that the number is valid. A deliberate
trade-off is allowed, but label it as a `business decision`, state what is being
traded, and do not present it as evidence-backed.

Never invent a threshold, window, sample size, confidence method, or owner. If
the value itself is unresolved, create an `OD-###` entry. If a chosen value has
no adequate basis, name that basis blocker without pretending the choice is
still open. In either case, mark the PRD `needs-decision` when the gap could
change the product or how success is judged.

### 7. Risks, dependencies, and open decisions

Record only risks and dependencies that could change product behaviour, scope,
measurement, safety, or delivery confidence. Add mitigation and ownership when
known.

Use this open-decision contract:

| ID | Decision | Why it matters | Owner | Blocking? |
|---|---|---|---|---|
| `OD-001` | Name the unresolved choice. | State what changes based on it. | Named owner or `unassigned`. | yes or no |

If any blocking open decision remains, readiness is `needs-decision`.

## Conditional modules

| Observable predicate | Required module |
|---|---|
| More than one team, approver, or operating owner must act | **Stakeholders and decision rights:** driver, approver, contributors, informed groups, and the decision each owns. Do not force a full DARCI table on a single-team change. |
| Success cannot be observed with existing measurement | **Telemetry contract:** exact event name, trigger, required properties, sensitive fields excluded, metric served, consumer or dashboard, and analytics owner or sign-off. |
| Product behaviour depends on model output or another probabilistic system | **Evaluation contract:** task, cases and source that reflect the intended users and situations, grader or rubric, threshold, evidence that the signal and threshold work for the stated use, failure classes, human fallback, safety checks, and production monitoring. |
| Release failure could materially harm users, revenue, data, or operations | **Rollout and rollback:** stages, entry and exit signals, monitoring, rollback trigger, and accountable owner. |
| The change handles sensitive data, permissions, abuse, or regulated activity | **Privacy, security, and compliance:** data handled, access, retention, consent, misuse cases, and required review. |
| The change migrates data or depends on complex integrations or state | **Integration and state contract:** upstream and downstream dependencies, states, errors, compatibility, migration, and recovery. |
| The change creates customer-support or operating work | **Operational readiness:** support flow, alerts, documentation, escalation, and operating owner. |

If a predicate is false, omit the module. If applicability is unknown and could
change scope or safety, ask the one question most likely to change that scope
or safety judgment.

Labels such as `acceptable risk`, `low confidence`, `uncertain`, or `high
risk` do not by themselves define an evaluation boundary. If product behaviour
branches on a probabilistic assessment, record the supplied or explicitly
accepted rule or threshold that selects each branch. When that boundary is
missing, keep it as a blocking open decision and mark the PRD
`needs-decision`; do not describe the PRD as build-ready.

A supplied or accepted probabilistic cutoff records the decision; it does not
show that the signal or cutoff works. Before build readiness, use cases that
reflect the stated users and situations to show what the system gets right and
wrong around the cutoff. The acceptable trade-off depends on the use and risk;
do not prescribe one universal statistical method.

Conditional-module fields are internal coverage, not one conversational
target. In exploratory work, ask about only the single field whose answer is
most likely to change the module's need or content; gather other independently
answerable fields in later turns.

## Elicitation prompts

These are a coverage guide, not a questionnaire. Inspect supplied documents,
analytics, research, designs, support material, and existing behaviour before
asking. Do not re-ask what an upstream artifact already settles.

For an exploratory PRD, ask exactly one highest-value question per turn. Route
to the unknown most likely to change scope, user-visible behaviour,
measurement, or launch safety:

1. Which part of the PRD's decision boundary remains unresolved?
2. What direct customer or behavioural evidence supports the problem?
3. Who is the primary user?
4. Which user-visible failure state has the highest consequence?
5. Which load-bearing assumption should we test next?
6. What observable result would weaken that assumption or change the direction?
7. Which single outcome threshold defines success?
8. What is the basis for that threshold?
9. Which one unresolved decision most affects launch safety?

Each example above is one information target. Treat related baseline,
denominator, job, primary-flow, guardrail, and recovery details as separate
later targets when they remain material.

Avoid umbrella prompts such as "What is the operating context?", "What must
happen on the failure branch?", and "What recovery behavior should the
customer see?" Context dimensions such as device state, timing, location, and
connectivity are separate targets. Branch or recovery dimensions such as
retained state, next state, user-facing message, retry trigger, retry action,
failed-retry fallback, owner, response time, and data-access rule are also
separate targets. Ask only the one dimension most likely to change the next
decision. Product ownership, approval, operations, rollout authority, and
rollback authority are separate targets; do not collect multiple
responsibilities with one "who owns..." question.

For a routine PRD with prior locked specs or recorded preferences, batch only
the genuinely unresolved fields. A useful maximum is three to five short
questions, not the entire template.

When the user explicitly reuses a prior locked PRD and supplies every stated
delta, proceed to the written spec without presenting inherited or
just-supplied content for another design-section approval. Still require the
separate final review and approval of the written spec before locking it.

When offering choices, lead with a recommendation and its trade-off. Never use
"reasonable assumptions" as permission to fabricate product decisions,
metrics, events, owners, dates, or rollout values.

## Build-ready test

Mark `Readiness: build-ready` only when:

- the selected direction, users, scope, and non-goals are explicit;
- evidence is strong enough for the stated product, audience, scope, and
  release action; claims remain scoped and counterevidence stays visible;
- every load-bearing assumption has an observation that would weaken it or
  change the direction;
- every `REQ-###` has at least one linked, verifiable `AC-###`;
- material failure states and edge cases are resolved;
- success and guardrails have a baseline, target or decision rule, and
  measurement method;
- every triggered conditional module is complete; and
- no open decision can still change scope, product behaviour, measurement, or
  launch safety.

Otherwise mark `Readiness: needs-decision` and list the exact blocking
evidence gaps and `OD-###` entries. Readiness is not prioritisation or
permission to ship.

A limited, reversible pilot may be build-ready for its stated learning scope
when it tests a named assumption, success and failure can be observed, a stop,
change, or rollback condition exists, and full rollout is explicitly out of
scope. Readiness belongs only to that scope. A material scope change, including
expansion toward full rollout, requires a new build-readiness check; pilot
readiness never carries over automatically.

## Standards baked in

- **Evidence before assertion.** Direct customer and behavioural evidence is
  the strongest default, not automatic proof. Judge it against the stated
  action and preserve scope, recency, limitations, and conflicts.
- **Problem before solution.** No feature-as-problem framing.
- **Premise challenged.** A selected direction still faces credible
  alternatives and disconfirming assumptions without reopening prioritisation.
- **Traceable requirements.** Stories, requirements, acceptance criteria, and
  open decisions use stable IDs and explicit links.
- **Verifiable handoff.** Requirements describe observable product behaviour;
  acceptance criteria define how to prove it.
- **Honest measurement.** Baselines, targets, methods, and guardrails are
  explicit. Missing values stay open rather than being invented.
- **Risk-adaptive depth.** Conditional modules appear because their predicates
  are true, not because a heavyweight template demands them.
- **No side-channel readiness.** Build-critical decisions are resolved in the
  PRD or named as blockers.
- **YAGNI scope.** Specify the smallest coherent solution that can achieve and
  measure the intended outcome.

## Anti-patterns

- Treating urgency, stakeholder belief, a feature request, or engineering
  availability as problem evidence
- Treating evidence presence, evidence type, seniority, or user acceptance as
  proof that evidence or a target is good enough for the stated action
- Inferring or revisiting prioritisation instead of recording the supplied
  upstream decision, or silently choosing a denominator, population,
  aggregation, or time window for ambiguous evidence
- Inventing thresholds, windows, samples, event names, rollout values, dates,
  or owners to make the PRD look complete
- Calling a PRD build-ready while exact requirements, acceptance criteria,
  measurement, or safety decisions remain in a future ticket or conversation
- Generic edge-case lists that are not linked to affected requirements
- Requirements written as implementation tasks or acceptance criteria that
  cannot be observed or tested
- A universal stakeholder, telemetry, rollout, or launch-plan section with no
  triggering need
- Reprioritising the initiative inside the PRD
- Carrying limited-pilot readiness into a wider rollout without a new check
- Hiding unresolved decisions in prose instead of `OD-###` entries

## Sources

- [NASA software requirements analysis](https://swehb.nasa.gov/spaces/SWEHBVD/pages/102695426/SWE-051%2B-%2BSoftware%2BRequirements%2BAnalysis?desktop=true&macroName=set-data)
- [Atlassian user stories](https://www.atlassian.com/agile/project-management/user-stories)
- [Atlassian acceptance criteria](https://www.atlassian.com/work-management/project-management/acceptance-criteria)
- [GOV.UK service measurement](https://www.gov.uk/service-manual/service-standard/point-10-define-success-publish-performance-data)
- [Basecamp risks and rabbit holes](https://basecamp.com/shapeup/1.4-chapter-05)
- [OpenAI eval-driven system design](https://developers.openai.com/cookbook/examples/partners/eval_driven_system_design/receipt_inspection)
