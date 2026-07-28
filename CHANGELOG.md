# Changelog

All notable changes to mindpowers will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.9.0] - 2026-07-27

### Added
- Shared readiness states with template-specific user-facing labels and named
  material blockers.
- Root-cause routes from document review to problem validation, mindstorming,
  drafting, verification, or calibration.
- Plain-language explanations for important conclusions: the recommendation,
  what was checked, the main reasons, uncertainty, and the next step.
- Scope-bound build readiness for small, reversible pilots with a named
  learning goal, observable result, and stop or change condition.

### Changed
- Mindstorming recommends validating-problems when a central problem claim is
  unsupported while allowing explicitly provisional continuation.
- PRD conditional modules are recommended through contextual questions rather
  than silently omitted or presented as a template checklist.
- Drafting preserves provisional evidence, readiness, blockers, and recorded
  external-review status.
- One-pagers and PRDs now judge evidence against different actions: narrow
  evidence may support early discussion but can still block a wider build.
- PRD targets require an understandable basis. A deliberate unsupported target
  is labelled as a business decision and records its trade-off.
- PRD premise checks keep the full set of important assumptions and record what
  observation would weaken each one or change direction.

### Fixed
- Connected internal sources are no longer broadened beyond the user's stated
  scope merely because a connector is available.
- Content readiness no longer implies that an external approval was received.
- Skill switches require user confirmation and carry the exact finding forward.
- Direct evidence and senior-user acceptance are no longer treated as automatic
  proof that evidence or a target is good enough for the stated action.
- Pilot readiness no longer carries into a wider rollout without another
  readiness check.

## [0.8.0] - 2026-07-21

### Added
- The PRD template now uses stable `US-###`, `REQ-###`, `AC-###`, and `OD-###` identifiers for traceable user stories, requirements, acceptance criteria, and open decisions.
- Risk-triggered PRD modules cover stakeholders and decision rights, telemetry, AI evaluations, rollout and rollback, privacy and security, integrations and state, and operational readiness.
- PRDs explicitly report `build-ready` or `needs-decision` and list any blocking product decisions.

### Changed
- PRD depth now adapts to observable risk. Small reversible changes keep a compact core; high-impact, probabilistic, regulated, multi-team, or integration-heavy changes add only the contracts they need.
- PRDs may consume an optional problem brief or approved one-pager while preserving evidence scope and keeping prioritisation external.
- Drafting preserves PRD identifiers and evidence qualifications. Reviewing-docs treats false build-readiness and side-channel dependencies as blockers.

### Fixed
- PRD elicitation separates leadership urgency and engineering readiness from problem evidence while treating prioritisation as supplied upstream context.
- Ambiguous evidence denominators and time windows must be clarified before they are repeated as baselines.
- Missing metrics, thresholds, event names, rollout values, dates, and owners remain explicit open decisions instead of being invented to make a PRD look complete.

## [0.7.1] - 2026-07-21

### Added
- Native Codex plugin metadata and a repository marketplace for Codex and ChatGPT desktop installation.
- Cursor installation instructions using its documented GitHub skill import flow.
- Portable installation guidance for other clients that implement the Agent Skills specification.

### Changed
- Installation documentation now distinguishes Claude Code, Cowork, Codex and ChatGPT desktop, and Cursor.
- The release workflow creates a GitHub release when a version tag is pushed without one.

## [0.7.0] - 2026-07-21

### Added
- New skill: `validating-problems`. It tests and scopes a customer or business problem against available evidence before a direction is pitched.
- Problem briefs record supported, partially-supported, unsupported, or contradicted status for each claim.

### Changed
- Mindstorming can optionally consume a relevant problem brief while preserving its scope, limitations, claim statuses, and `as_of` date.
- A one-pager can socialise a supported problem or an explicitly provisional problem while prioritisation remains external to problem validation.

### Fixed
- The calibrating skill now lists all nine template types, including `one-pager`.

## [0.6.0] - 2026-07-15

### Added
- New template: `one-pager`, alongside the existing eight. For pitching one direction and getting fast alignment before investing in a full spec (new initiatives, cross-team asks, "should we even do this" buy-in). BRD is treated as a heavier weight-tier of the same template (optional stakeholders and rough-milestones sections), not a separate one: research across external one-pager/PR-FAQ standards and sampled internal org documents found no organization drawing a hard line between the two, only a difference in how much business-case detail the ask needs. Explicitly distinguished in the template itself from `decision-doc` (weighs live options; one-pager already has its direction) and `prd` (specs how to build; one-pager stops at direction).

### Changed
- `prd` template: optional one-line pitch allowed as a lead sentence in Problem (the elevator-pitch job now belongs upstream to `one-pager`); added a strategic-fit prompt to Hypothesis/goal; added an assumptions-check elicitation prompt to Open questions. Kept intentionally close to its prior shape otherwise: DARCI-style stakeholder tables, sign-off gates, features-and-flow tables, and launch-plan mechanics found in heavier real-world PRD templates were evaluated and left out as org-specific process or downstream execution detail, not brainstorming-stage spec content.

## [0.5.1] - 2026-07-07

### Changed
- All four skill descriptions now state only their triggering conditions, per skill-authoring best practice: a description that summarizes the workflow tempts the agent to follow the summary instead of reading the skill. Routing behavior verified unchanged with an A/B test (30 simulations) before the edit; approval-gate compliance verified under time pressure.
- README "What's new" now covers 0.3 through 0.5 and links the changelog.

## [0.5.0] - 2026-07-07

### Added
- New skill: `calibrating`. After a deliverable ships or gets human edits, it asks at most three questions (what landed, what got cut or rewritten, what should change next time) and records the answers in `docs/mindpowers/preferences.md`, keyed by template type. Entries are pruned on write; contradictions replace older notes instead of piling up.
- Mindstorming now reads `docs/mindpowers/preferences.md` at the start of every session, and the routine-vs-exploratory call is made from specs and preferences on disk instead of guessing from conversation history, which doesn't persist across sessions.

## [0.4.0] - 2026-07-07

### Added
- New skill: `drafting`. Turns a locked spec from `docs/mindpowers/specs/` into the finished deliverable, holding it to the matched template's standards, with its own self-review checklist. Saves to `docs/mindpowers/drafts/` with frontmatter cross-links to the spec. Short comms stay in chat unless you want a record.
- New skill: `reviewing-docs`. Pressure-tests any finished doc (mindpowers-drafted or not) against its spec and the template's standards, through a persona chosen by document type: exec-skeptic, regulator, distracted-skimmer, first-time-implementer, or adversarial-interviewer. Can reverse-engineer a spec when none exists. Findings ranked by severity and saved to `docs/mindpowers/reviews/`.
- New template: post-mortem, alongside the existing seven. Blameless framing, contributing factors over a single root cause, actions owned and dated.

## [0.3.0] - 2026-07-07

### Renamed
- The `brainstorming` skill is now `mindstorming`, to end a three-way name collision with `superpowers:brainstorming` and Anthropic's own "brainstorming" product feature. Invoke it as `/mindpowers:mindstorming` (the old `/mindpowers:brainstorming` no longer resolves).

### Changed
- Output paths moved from `docs/brainstorm/<type>/YYYY-MM-DD-<slug>.md` to flat `docs/mindpowers/specs/YYYY-MM-DD-<type>-<slug>.md`. Type now lives in the filename, not a subdirectory, and specs and drafts share a stem so pairs sort together. Legacy `docs/brainstorm/` is still read if present; nothing is migrated automatically.
- Drafts now have a defined home (`docs/mindpowers/drafts/`) instead of being handed back in chat only.
- Cowork/no-filesystem sessions: if there's no writable folder, the spec is shown in full in chat (or as an artifact), marked as not saved to disk, and still requires explicit written approval before drafting proceeds.
- Mindstorming now warns before writing a spec into a shared or public git repo, since specs often carry sensitive content (leadership comms, OKR politics, exec briefings), and suggests `.gitignore`-ing `docs/mindpowers/` or picking a private location.

### Fixed
- Repo hygiene: the built Cowork zip and `.DS_Store` are no longer tracked in git; plugin metadata (`homepage`, `repository`, `license`, author email) is now complete in `plugin.json`.

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
