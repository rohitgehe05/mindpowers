# Mindpowers

**Brainstorming superpowers for knowledge workers.**

Mindpowers is a Cowork and Claude Code plugin that gives Claude a disciplined brainstorming workflow for non-coding deliverables. It refines rough ideas into locked specs through Socratic dialogue, with templates for the seven knowledge-work shapes you actually produce.

A knowledge-work counterpart to [obra/superpowers](https://github.com/obra/superpowers). Sibling to [coworkpowers](https://github.com/nabeelhyatt/coworkpowers), but focused narrowly on the brainstorming pattern rather than the full compound loop.

## Why

Most AI-assisted writing fails at the start, not the end. Claude rushes to produce output before the intent is clear. The result is plausible prose that misses the point, or worse, that reflects unexamined assumptions back at you with confidence.

Mindpowers fixes this by enforcing two approval gates before any drafting happens:

1. **Verbal approval.** Section-by-section dialogue surfaces gaps, contradictions, and unstated assumptions.
2. **Written approval.** A locked spec on disk forces precision that conversation lets slide.

Drafting only begins after both gates clear. The discipline is contagious: once your specs are crisp, your drafts are too.

## What you get

One skill: `brainstorming`. Seven templates plus a self-shape fallback.

| Template | When it fires |
|---|---|
| `business-review` | Weekly or quarterly product BRs |
| `decision-doc` | Strategic arguments, OKR defence, build-vs-buy |
| `prd` | Product specs |
| `briefing-doc` | Partner meetings, exec syncs, regulator prep |
| `comms-draft` | Slack messages, team emails, internal announcements |
| `framework` | Methodologies, rubrics, playbooks |
| `talking-points` | OKR defence prep, Q&A prep, podium moments |
| `self-shape` | Anything else, with one-question-at-a-time elicitation |

Each template encodes earned standards (insight before data for BRs, recommendation up front for decision-docs, falsifiable hypotheses for PRDs).

## How it works

When invoked, the skill follows a 10-step process:

1. Explore context (recent specs, conversation history)
2. Detect template match (or self-shape if novel). Classify topic as routine or exploratory.
3. Offer visual companion when the dialogue heads into visually-shaped territory (deferred from session start)
4. Adaptive elicitation: batched only when template match AND topic is routine for the user; otherwise one-question-at-a-time
5. Propose 2-3 approaches when self-shaping or when the route is open
6. Present design sections, get verbal approval. If structure is rejected as "too generic," invoke research-as-recovery before re-proposing.
7. Write spec to `docs/brainstorm/<type>/YYYY-MM-DD-<slug>.md` with YAML frontmatter
8. Self-review and report inline: surface checklist results so the user can see what was checked
9. User reviews written spec on disk, gives final approval
10. Type-aware handoff: brief-style specs ("draft, hand back, or stop?") versus spec-is-the-deliverable specs like frameworks ("stop, draft a derivative, or pause?")

## What's in v0.2

- Adaptive elicitation now classifies routine versus exploratory topics, not just template-match status
- Research-as-recovery is a named recovery path when structure feedback is "too generic"
- Source attribution is a standard across framework, decision-doc, and PRD templates
- Framework template explicitly covers personal and life frameworks alongside professional ones
- Structure guidance now requires connections between elements, not just placement
- Type-aware handoff distinguishes brief-style specs from spec-is-the-deliverable specs
- Self-review results surfaced inline rather than implicit

## Installation

### Cowork (Claude Desktop)

1. Download `mindpowers.zip` (or clone this repo and zip the folder)
2. In Cowork, go to Customize > Plugins > Upload Local Plugin
3. Upload the zip

### Claude Code

```bash
# Clone and install locally
git clone https://github.com/<your-org>/mindpowers.git
claude --plugin-dir ./mindpowers
```

## Quick start

Once installed, the skill triggers automatically on substantive deliverable requests. You can also invoke it explicitly:

```
"Help me draft the Q1 product business review"
"I need a decision doc on whether to extend the partnership"
"Brainstorm a PRD for the new onboarding flow"
"What should I say in the OKR defence next week?"
```

The skill handles the rest: detects the template, elicits the spec, locks it on disk, and asks how you want to proceed.

## Philosophy

- **Two gates beat one.** Verbal approval misses things. Written approval catches them.
- **Templates encode learning.** Earned standards belong in templates, not in your head.
- **YAGNI ruthlessly.** Every section in a spec must justify its presence.
- **Self-shape for novel work.** When no template fits, one-question-at-a-time elicitation forces reflection.
- **No task is too simple.** The spec for a Slack reply is short, but it exists.

## Credits

Inspired by:

- [obra/superpowers](https://github.com/obra/superpowers): the original skills framework and brainstorming pattern
- [nabeelhyatt/coworkpowers](https://github.com/nabeelhyatt/coworkpowers): knowledge-work adaptation that informed the template approach

## License

MIT
