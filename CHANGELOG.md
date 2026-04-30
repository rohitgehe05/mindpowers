# Changelog

All notable changes to mindpowers will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-04-30

### Added
- Research-as-Recovery as a named recovery path when the user rejects a proposed structure as "too generic." Includes when-to-invoke, how-to-invoke (5-step procedure), and the anti-pattern of using research as a stalling tactic.
- Routine vs exploratory classification in adaptive elicitation. Batched questions are now used only when there's a template match AND the topic is routine for the user.
- Type-aware handoff. Brief-style specs (BR, decision-doc, PRD, etc.) get the standard "draft, hand back, or stop?" prompt. Spec-is-the-deliverable specs (frameworks, post-mortems, retros) get a different handoff: "stop, draft a derivative, or pause?".
- Source attribution as a standard across framework, decision-doc, and PRD templates. When principles map to existing thinkers, cite them.
- Personal and life frameworks explicitly in scope for the framework template, alongside professional frameworks.
- Connections requirement in framework structure: placement alone is not enough; show how elements relate.
- Self-review reporting standard. Checklist results are surfaced inline when handing the spec to the user.
- Visual companion timing made explicit. Common offer points listed; for text-only sessions the offer may never happen.
- "When NOT to use" and "Sources" sections in the framework template.

### Changed
- 10-step process flow updated to reflect routine/exploratory classification, research-as-recovery branch, and type-aware handoff.
- Process flow digraph updated to match.
- Plugin description expanded to mention adaptive elicitation, research-as-recovery, source attribution, and type-aware handoffs.

### Removed
- Em dashes throughout, replaced with full stops, colons, or rephrased prose.

## [0.1.0] - 2026-04-30

### Added
- Initial release.
- One skill: `brainstorming`.
- Seven templates: business-review, decision-doc, prd, briefing-doc, comms-draft, framework, talking-points.
- Plus self-shape fallback for novel tasks.
- Two approval gates: verbal (during dialogue) and written (locked spec on disk).
- Adaptive elicitation: batched for template matches, one-question-at-a-time for self-shape.
- Visual companion offer pattern.
- Spec file format: markdown with YAML frontmatter, saved to `docs/brainstorm/<type>/YYYY-MM-DD-<slug>.md`.
- Confirm-then-draft handoff.
