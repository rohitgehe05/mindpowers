# Contributing to Mindpowers

Mindpowers is a small skills package and contributions are welcome. The project values precision over completeness, so changes should sharpen what's there rather than expand surface area.

## What kinds of contributions land

**Likely to land:**

- New templates that capture distinct knowledge-work shapes (e.g., post-mortem, retro, RFC) following the existing template structure (sections, elicitation prompts, standards baked in, anti-patterns, sources)
- Refinements to existing templates that encode learned standards (a pattern that consistently works, an anti-pattern someone falls into)
- Fixes to the SKILL.md flow when real-world use surfaces gaps (the v0.2 changes are a good example: each refinement came from an observed gap)
- Better elicitation prompts in existing templates (sharper, less leading, better multiple-choice scaffolds)
- Documentation improvements

**Less likely to land:**

- Adding more templates without clear use-case differentiation from existing ones (e.g., "executive summary" overlaps with decision-doc; argue why it's distinct)
- Adding heavy automation or tooling (mindpowers is intentionally markdown-first)
- Renaming things without strong justification (stable naming reduces friction across the *-powers ecosystem)

## How to propose a change

1. Open an issue first if the change is non-trivial. Describe the gap you're trying to close and the proposed approach.
2. For refinements: small PRs with clear before/after context land fastest.
3. For new templates: include the use case you've validated against (real work you've done where the existing templates didn't fit).

## Style guide

- Sentence case throughout (not Title Case).
- No em dashes. Use full stops, colons, or rephrase.
- One idea per bullet. No compound bullets.
- Insight before data. If you have a recommendation, lead with it.
- Source attribution where it adds rigour, not as decoration.

## Spec discipline

The skill itself enforces a brainstorming workflow. When proposing structural changes to the SKILL.md or templates, please run a brainstorm session against your own change first and submit the resulting spec alongside the PR. Yes, the project eats its own dog food.
