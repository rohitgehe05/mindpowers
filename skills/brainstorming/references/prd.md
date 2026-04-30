# PRD Template

For product requirement documents. New feature specs, onboarding flows, platform changes, internal tools.

## Sections

| Section | What goes here |
|---|---|
| Problem | One paragraph. What user or business problem does this solve? Be concrete. Avoid feature-as-problem framing. |
| Users and use cases | Primary user, key use cases, frequency. Who hurts most without this? |
| Hypothesis or goal | What you believe will happen if this ships. Stated as a falsifiable claim where possible. |
| Proposed solution | Functional description. What does it do, not how it's built. Include user flow at high level. |
| Success criteria | Measurable. How will you know this worked? Lead with the metric, not the activity. |
| Scope and non-goals | What is explicitly in. What is explicitly out. |
| Risks and dependencies | Technical, operational, regulatory, partner-side. |
| Open questions | What's still unresolved. |

## Elicitation prompts

When self-shaping, one at a time:

1. Who is the primary user, and what's the specific pain you're solving?
2. What's your hypothesis? "If we ship X, then Y will happen because Z."
3. What's the simplest version that tests the hypothesis? (YAGNI everything else.)
4. What's the success metric, and what's the threshold for "this worked"?
5. What's explicitly out of scope?
6. What's the biggest risk that could kill this?

When a template match is suspected (user said "PRD" or "spec for X"), batched:

> "To frame the PRD: who's the primary user, what's the specific pain, what would success look like in numbers, and what's explicitly out of scope?"

## Standards baked in

- **Problem before solution.** No "feature as problem" framing.
- **Falsifiable hypothesis.** "If X then Y because Z," not "we think this is good."
- **Measurable success criteria.** Lead with the metric, not the activity.
- **YAGNI scope.** Smallest version that tests the hypothesis. Cut everything else.
- **Non-goals matter.** Explicit out-of-scope prevents drift.
- **Source attribution where applicable.** If the design draws on jobs-to-be-done, design patterns, or competitor analysis, cite. Adds rigour and traceability.

## Anti-patterns

- Solution-shaped problem statements ("users need a button to do X")
- Vague success criteria ("improved engagement")
- Feature creep dressed up as scope ("nice-to-haves")
- Skipping non-goals because they feel obvious
- Hiding risks in a single line at the bottom
