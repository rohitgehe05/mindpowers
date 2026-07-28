# Evidence Quality and Plain-Language Design

## Status

Approved for implementation on 2026-07-28.

This is a follow-up to:

- `docs/superpowers/specs/2026-07-27-contextual-readiness-and-skill-routing-design.md`;
- `docs/superpowers/plans/2026-07-27-contextual-readiness-and-skill-routing.md`; and
- the ten-item adversarial review of PR #6.

It strengthens the work already on PR #6. It does not replace the earlier
design or reopen decisions that were already implemented.

## Summary

Mindpowers should think carefully and explain itself simply.

The current workflow can tell whether required information is present. It needs
to become better at judging whether that information is strong enough for the
next action. It also needs a consistent plain-language standard across every
user-facing skill and document.

This design adds two shared behaviours:

1. check the quality and sufficiency of evidence, not only whether evidence was
   supplied; and
2. give users a short, clear explanation of the result, with examples when a
   rule could be misunderstood.

The evidence bar depends on the deliverable and its stated scope. A one-pager
may be ready to socialise while an important uncertainty is clearly labelled.
A PRD must not be build-ready when weak evidence could materially change what
gets built. A limited, reversible pilot may still be build-ready when its
purpose is to test the uncertain assumption safely.

## Why This Exists

The red-team review found ten possible loopholes. After checking each claim
against the current files, the findings were:

| Finding | Verdict | What this design does |
|---|---|---|
| An accepted threshold can become a rubber stamp | Valid | Require an understandable basis and label deliberate business trade-offs honestly |
| Evidence can be present but too weak | Valid | Add an evidence-sufficiency check tied to the next action |
| A precise AI or scoring cutoff can still be untested | Valid when product behaviour branches on the score | Require validation of the signal and cutoff for the stated use |
| An assumption may have no way to disprove it | Valid | Ask what would weaken or disprove important assumptions |
| One named assumption can hide other important assumptions | Valid | Track the material assumption set internally while asking one question at a time |
| An inherited premise may pass through unchallenged | Partly valid | Recheck load-bearing premises when current evidence contradicts them |
| Evidence questions may look only for support | Partly valid | Check counterevidence and plausible alternative explanations |
| Information can be present but insufficient | Valid | Judge relevance, recency, coverage, reliability, and limitations |
| Evidence type can be mistaken for evidence quality | Partly valid | Judge the quality of the actual evidence, not its label |
| Deferred questions may never return | Not a direct text loophole | Keep the existing field audit; strengthen internal tracking only if tests show a real failure |

The common problem is simple: **having an answer is not the same as having a
good enough answer**.

Example:

> “Three customers asked for this” is evidence. It may be enough to justify a
> small discovery test. It is usually not enough to claim that most customers
> need the feature or to justify a costly full rollout.

## Goals

- Use plain language in every user-facing response, skill, template, example,
  README section, error, handoff, and readiness explanation.
- Keep careful reasoning visible enough that users can understand and challenge
  the conclusion.
- Judge evidence against the next action and stated scope.
- Keep one-question-at-a-time interaction for exploratory work.
- Give examples when an abstract rule could be misunderstood.
- Preserve honest provisional continuation.
- Allow deliberate business decisions when their basis and uncertainty are
  labelled clearly.
- Allow limited, reversible pilots to learn safely.
- Keep the workflow useful for PRDs, one-pagers, and other deliverables.
- Keep the skillset useful to product managers, business leads, stakeholders,
  and other users.
- Keep all language and examples general-purpose and organization-neutral.

## Non-Goals

- Showing users the full internal evidence rubric by default.
- Requiring a universal sample size or one preferred research method.
- Turning every one-pager into a formal validation report.
- Requiring problem validation before any provisional work can continue.
- Treating user acceptance as proof that a claim is true.
- Treating content readiness as stakeholder approval.
- Adding a complex readiness schema such as `ready_for` and `not_ready_for`.
- Creating a new orchestrator skill.
- Creating a field-feedback form or product-evaluation system. That remains
  separate future work.
- Rewriting every file merely to make wording uniform.
- Adding company-specific terms, roles, systems, or approval rules.

## Terminology

Use **user** for the person interacting with Mindpowers.

Do not introduce `Owner` as an optional synonym. Different templates may still
name a decision maker, approver, reviewer, or accountable role when the
deliverable truly needs one.

## Plain-Language Contract

### Core rule

**Think precisely; respond plainly.**

User-facing language should:

- use common words and short sentences;
- explain an unavoidable technical term the first time it appears;
- ask one concrete question at a time during exploratory work;
- include a short example when a rule could have more than one reasonable
  interpretation;
- say what matters and why, instead of naming an internal framework; and
- explain the idea again from scratch when the user says it is unclear.

Do not replace careful thinking with a shallow answer. Do the full internal
check, then show a compact reasoning receipt.

### Reasoning receipt

For a material conclusion, use this order:

1. **Recommendation:** what Mindpowers recommends.
2. **What I checked:** a short description of the important checks.
3. **Main reasons:** the two or three reasons that drive the conclusion.
4. **Uncertainty:** what is still assumed, weak, missing, or disputed.
5. **Next step:** the most useful action or question.

Example:

> **Recommendation:** This one-pager is ready to share for early feedback, but
> not as proof that the problem is widespread.
>
> **What I checked:** The customer evidence is recent and directly relevant,
> but it covers only three enterprise accounts.
>
> **Uncertainty:** We do not yet know whether the same problem affects smaller
> customers.
>
> **Next step:** Share the one-pager with that limit stated, then test the claim
> with a broader customer group before committing to a full build.

The amount shown should match the stakes:

- a simple, reversible request gets a short answer;
- a costly, difficult-to-reverse, safety-sensitive, or high-uncertainty request
  gets a fuller explanation; and
- detailed internal assessment is shown when the user asks for it or when the
  detail is needed to prevent a serious misunderstanding.

## Internal Evidence Check

Mindpowers checks evidence internally across these dimensions:

| Check | Plain meaning |
|---|---|
| Relevance | Does this evidence actually address the claim or decision? |
| Recency | Is it current enough for the decision? |
| Coverage | Does it cover the people, situations, or cases the claim is about? |
| Reliability | Can the source, method, and result be trusted for this use? |
| Limitations | What can this evidence not tell us? |
| Counterevidence | What evidence points the other way or supports another explanation? |

These are judgment prompts, not a visible checklist and not a scoring formula.
There is no universal sample-size rule.

Evidence quality depends on the claim and action. A small set of interviews can
be strong evidence of how a specific workflow fails, but weak evidence of how
often the failure occurs across the full customer base.

### Default user-facing result

Keep the detailed assessment internal unless it is useful or requested. Show a
short plain-language result:

> The evidence is directly relevant, but too narrow to support a company-wide
> claim. It is enough for a small learning test, not a full rollout.

## Deliverable-Specific Evidence Bars

The same evidence can support one action and block another.

### One-pager

A one-pager may be `ready-to-socialise` with limited evidence when:

- its purpose is early discussion, feedback, or alignment;
- the uncertainty is stated clearly;
- the proposed next step fits the strength of the evidence; and
- the weak evidence does not make the document misleading for its audience.

Example:

> Ready to socialise as a proposal for discovery. Not evidence that the problem
> is widespread.

A central unsupported claim should still trigger a recommendation to use
`validating-problems`. The user may confirm the switch or continue
provisionally.

### PRD

A PRD must not be `build-ready` when weak evidence could materially change:

- the problem being solved;
- the selected direction;
- the people or situations in scope;
- important product behaviour;
- measurement or success criteria; or
- a material risk.

The user may still ask Mindpowers to continue drafting. The PRD remains
`not-ready` and names the blocker in simple terms.

Example:

> We can keep drafting, but this is not build-ready. The only evidence comes
> from two internal users, while the feature changes behaviour for all
> customers.

### Other deliverables

Use the same shared rule:

> Is the evidence strong enough for the next consequential action this
> deliverable is meant to support?

Template-specific language should name that action, such as ready to present,
ready to send, ready to apply, or ready to decide.

## Thresholds and Targets

A target or threshold needs an understandable basis. Acceptable bases include:

- a measured baseline;
- an external or internal benchmark;
- a customer expectation;
- research or test results;
- a financial or operational requirement; or
- a deliberate business trade-off.

The user may choose a number without strong evidence. That is allowed when
Mindpowers labels it honestly:

> This is a business decision, not an evidence-backed threshold. The team is
> accepting the trade-off because waiting would cost more than a small,
> reversible miss.

User acceptance proves that the user made the decision. It does not prove that
the number is valid or evidence-backed.

## AI and Scoring Cutoffs

This rule applies only when product behaviour branches on a model,
probabilistic score, or classifier. Examples include:

- a fraud score that blocks a payment;
- a routing score that sends a case to a specialist;
- an eligibility score that grants access;
- a moderation score that hides content; or
- a confidence score that triggers an automatic action.

A precise cutoff is not enough. For build readiness, the PRD should state how
the signal and chosen cutoff were tested for the stated use. The exact method
depends on the product, but it should cover meaningful success and failure
cases.

If the cutoff is intentionally provisional for a limited pilot, say so and
define how the pilot will test it.

## Important Assumptions

Mindpowers should track the full set of material, load-bearing assumptions
internally. It should not close the premise check after the user names only one.

For each material assumption, ask:

> What would we observe that would make us change direction?

Use plain language rather than requiring the user to know the word
“falsifier.”

Keep asking one contextual question at a time. The internal ledger prevents
important assumptions from disappearing while preserving a natural
conversation.

Recheck an inherited premise only when current evidence contradicts it or it is
still load-bearing for the present decision. Do not restart settled work
without a reason.

## Limited, Reversible Pilots

Weak evidence does not always block a build. A limited pilot may be build-ready
when:

- the stated scope is small and reversible;
- the purpose is to test a named assumption;
- success and failure can be observed;
- a stop, change, or rollback condition is defined; and
- the document clearly excludes a full rollout.

Example:

> `readiness: ready` for a 5% opt-in pilot that tests whether customers complete
> recovery more often. Full rollout is out of scope and requires a new readiness
> check.

The same evidence may be enough for the pilot and insufficient for the full
rollout.

## Scope-Bound Readiness

Keep the existing binary frontmatter:

```yaml
readiness: ready | not-ready
```

Readiness applies only to the scope stated in the artifact. A material scope
change triggers a new readiness check.

Do not add `ready_for` or `not_ready_for` fields. Explain scope in the document
body and blocker text.

Lifecycle status, content readiness, and external approval remain separate:

- `status` says whether the working spec is draft, locked, or superseded;
- `readiness` says whether its content supports the next stated action; and
- approval records say whether named people or groups explicitly approved it.

Mindpowers must not claim an approval that was not explicitly recorded.

## Reviewer Suggestions

Reviewer suggestions remain a non-blocking convenience.

Mindpowers may detect a material risk, suggest a relevant reviewer role, and ask
the user to confirm or change it. It should not require the user to name every
reviewer in advance and should not make its suggested reviewer a readiness
blocker unless an external policy explicitly requires that approval.

## Source Boundaries

The user decides where Mindpowers should search.

Mindpowers may use material the user supplies, sources the user identifies, and
workspace material already within the task's stated scope. If no useful
evidence or source is available, it may offer broader internet research. That
offer is non-blocking.

Declining research does not prevent provisional work. It leaves the evidence
status and any resulting readiness blocker visible.

## Skill Routing

When the evidence check finds a central unsupported or contradicted problem
claim:

1. explain the concern simply;
2. recommend `validating-problems`;
3. ask for confirmation before switching; and
4. offer provisional continuation.

`validating-problems` remains the strongest source of truth for detailed
problem-evidence assessment. Other skills should reuse its evidence dimensions
and hand off to it rather than creating a second validation framework.

Every skill switch requires confirmation. A recommendation is not an automatic
invocation.

## User-Facing Surface Audit

Audit the whole skillset, not only the PRD template:

- `skills/mindstorming/SKILL.md` and all of its references;
- `skills/validating-problems/SKILL.md` and its problem-brief reference;
- `skills/drafting/SKILL.md`;
- `skills/reviewing-docs/SKILL.md`;
- `skills/calibrating/SKILL.md`;
- examples, prompts, handoffs, readiness labels, and error messages;
- `README.md`;
- `CHANGELOG.md`;
- plugin and marketplace descriptions; and
- installation and usage guidance.

Do not rewrite every sentence mechanically. Use baseline tests and a focused
copy audit to change wording that is opaque, misleading, inconsistent, or
likely to make the agent answer users in jargon.

## General-Purpose Guardrail

No GoTo-specific or other organization-specific terminology may enter the
skills, templates, examples, tests, specs, plans, README, changelog, or plugin
metadata.

Use anonymized examples and reusable conditions. Surface any uncertain
organization-specific term before committing it.

## Documentation and Release Surface

PR #6 already prepares version `0.9.0` and has not been merged or released.
Keep that version. Extend the existing `0.9.0` changelog and README notes rather
than creating a second version or a separate release-notes file.

Update public metadata descriptions only when the shipped behaviour changes the
description. Keep plugin and marketplace descriptions synchronized.

Do not tag, publish, create a GitHub release, or merge the PR.

## Expected File Changes

Baseline tests decide the minimum final set. Likely files are:

- `skills/mindstorming/SKILL.md`;
- `skills/mindstorming/references/one-pager.md`;
- `skills/mindstorming/references/prd.md`;
- `skills/validating-problems/SKILL.md`;
- `skills/validating-problems/references/problem-brief.md` if output wording
  needs clarification;
- `skills/drafting/SKILL.md`;
- `skills/reviewing-docs/SKILL.md`;
- `skills/calibrating/SKILL.md` only if a baseline shows a real gap;
- other mindstorming references only where the copy audit finds a tested
  user-facing clarity problem;
- `README.md`;
- `CHANGELOG.md`;
- `.claude-plugin/plugin.json`; and
- `.claude-plugin/marketplace.json`.

Evaluation evidence remains temporary and must not be committed unless the
repository already has an established test-fixture location that the plan
explicitly adopts.

## Validation Strategy

Use Superpowers `writing-skills` with RED-GREEN-REFACTOR.

### RED

Run fresh-agent scenarios against the current branch before changing production
skills. At minimum cover:

1. a one-pager with relevant but narrow evidence;
2. a full-rollout PRD with the same weak evidence;
3. an accepted target with no stated basis;
4. a product whose behaviour branches on an untested score;
5. several important assumptions disclosed one at a time;
6. a confirmation-biased evidence prompt;
7. a limited, reversible learning pilot;
8. a material scope change after readiness;
9. a user asking for a simpler explanation; and
10. a cross-skill review of user-facing copy.

Capture exact failures and rationalizations. Do not edit a skill unless a
scenario or copy audit demonstrates a gap.

### GREEN

Make the smallest changes that fix the observed failures. Rerun the same
scenarios with the changed skill package.

### REFACTOR

Run adversarial variations that pressure the agent to:

- accept a number because a senior user approved it;
- treat direct customer evidence as automatically sufficient;
- call a pilot ready without a learning signal or stop condition;
- apply pilot readiness to a full rollout;
- dump the internal evidence rubric on the user;
- use jargon to appear rigorous;
- hide uncertainty to make the document sound decisive; or
- claim external approval from content readiness.

Close observed loopholes and rerun the affected cases.

## Acceptance Criteria

- Every user-facing skill explicitly requires simple language and concrete
  explanations.
- The agent does careful internal work and gives a compact reasoning receipt for
  material conclusions.
- A user who says an explanation is unclear receives a simpler explanation from
  scratch.
- Evidence is judged for relevance, recency, coverage, reliability,
  limitations, and counterevidence without a universal scoring formula.
- The default user-facing evidence result is short and in plain language.
- A one-pager can be ready to socialise with limited evidence when its
  uncertainty and purpose are clear.
- A PRD is not build-ready when weak evidence could materially change the build.
- A deliberate business threshold is allowed and labelled as a business
  decision rather than evidence-backed.
- A probabilistic product branch requires validation of its signal and cutoff,
  or an explicitly limited pilot that will test them.
- Important assumptions include a plain-language disconfirming condition.
- One-question-at-a-time interaction is preserved while the complete material
  assumption set is tracked internally.
- A limited, reversible pilot can be ready for its stated scope when it has a
  learning signal and stop or change condition.
- A material scope change triggers a new readiness check.
- `readiness: ready | not-ready` remains the only readiness frontmatter.
- Status, readiness, and explicit approval remain separate.
- `validating-problems` remains the detailed evidence-assessment source of
  truth.
- Skill switches still require user confirmation.
- README, changelog, plugin descriptions, examples, handoffs, and errors use
  clear, general-purpose language.
- No field-feedback system is added.
- No organization-specific terminology is committed.
- Version remains `0.9.0`; no tag, release, publication, merge, or extra release
  note is created.
