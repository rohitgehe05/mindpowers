# Mindpowers

**Your AI should ask better questions before it writes.**

Most AI writing tools turn ambiguity into polished prose. Mindpowers does the opposite: it validates the problem, challenges premises, explores credible alternatives, and locks the important decisions before drafting.

Use it to turn rough thinking into one-pagers people can align around, PRDs
engineering can build from without decisions left in side conversations,
business reviews that surface the real story, and everyday documents that hold
up under scrutiny.

![Demo: Mindpowers turns raw business-review data into a decision-ready story before drafting](docs/assets/demo.gif)

*The useful insight appears before the first paragraph.*

Mindpowers is a problem-first knowledge-work skillset for Claude Code, Cowork, Codex, ChatGPT desktop, Cursor, and other Agent Skills clients.

## Try it

- “Validate whether this customer problem is actually supported.”
- “Grill this idea until the problem and solution are clear.”
- “Turn this approved direction into a build-ready PRD.”
- “Review this document like a skeptical product leader.”

Mindpowers routes each ask into one connected loop while keeping you in control
of the important decisions.

## The loop

mindpowers does one loop: validate the problem when needed, then shape, draft,
review, and remember what you like. It keeps provisional work moving without
hiding the blockers that still matter.

| Skill | What it does |
|---|---|
| `validating-problems` | Tests and scopes a customer or business problem against available evidence, resuming only claims that still need work |
| `mindstorming` | Recommends the right deliverable when needed, asks contextual questions, and turns the result into a spec with honest readiness |
| `drafting` | Turns an approved spec into the deliverable while preserving provisional evidence, blockers, and review status |
| `reviewing-docs` | Red-teams a document, classifies each finding by root cause, and recommends the right next skill without switching automatically |
| `calibrating` | Compares a Mindpowers draft with the final human-edited version and records approved, stable preferences |

## Before / after

A cold-drafted business review usually opens like this:

> This quarter we shipped 14 features across three teams. Signups were up 8% month over month, and support tickets held roughly steady. The team continued to invest in onboarding improvements throughout the quarter.

A mindstorming-spec'd version front-loads the thing that matters:

> Growth is masking a retention problem: signups are up 8%, but week-4 retention slipped from 61% to 54%, the first drop in a year. Onboarding shipped 14 features this quarter; none of them targeted the drop.

- Same underlying facts, different order: insight and the lowlight lead, not buried three paragraphs in.
- The spec forces this before drafting starts: "insight before data" is the template's standard, decided at spec time, not fixed in editing later.

(Illustrative excerpt, not a real review.)

## Templates

Nine templates, plus a fallback for anything that doesn't fit one:

| Template | When it fires |
|---|---|
| [`business-review`](skills/mindstorming/references/business-review.md) | Weekly or quarterly product reviews |
| [`decision-doc`](skills/mindstorming/references/decision-doc.md) | Strategic arguments, OKR defence, build-vs-buy |
| [`one-pager`](skills/mindstorming/references/one-pager.md) | Pre-solution pitch for buy-in, before a PRD or a formal decision doc. Sometimes labeled BRD |
| [`prd`](skills/mindstorming/references/prd.md) | Adaptive product specs with evidence, traceable requirements, acceptance criteria, measurement, and honest build readiness |
| [`briefing-doc`](skills/mindstorming/references/briefing-doc.md) | Partner meetings, exec syncs, regulator prep |
| [`comms-draft`](skills/mindstorming/references/comms-draft.md) | Slack messages, team emails, announcements |
| [`framework`](skills/mindstorming/references/framework.md) | Methods, rubrics, playbooks |
| [`talking-points`](skills/mindstorming/references/talking-points.md) | OKR defence, Q&A prep, anything you'll say out loud |
| [`post-mortem`](skills/mindstorming/references/post-mortem.md) | Incident or project retros: what happened, root cause, what changes |
| `self-shape` | Anything else, Claude asks one question at a time |

Each template carries the lessons that make that kind of document good: lead with the insight (not the data) in a business review, put the recommendation first in a decision doc, and make PRD requirements traceable and verifiable without inventing missing product decisions.

## How it works

Before shaping, Mindpowers performs a lightweight premise check. When a central
customer or business claim is unsupported, it recommends
`validating-problems` and waits for confirmation before switching. You can
decline and continue provisionally: the claim keeps its honest evidence status
and any material blocker remains visible. Problem validation records
claim-level evidence statuses in
`docs/mindpowers/problems/YYYY-MM-DD-<slug>.md` and resumes only the claims that
remain unresolved. Prioritisation stays outside problem validation and the PRD.

Mindstorming, the "shape" step, runs a 10-step process:

1. Read the context you supplied, workspace material already in scope, recent specs, and `docs/mindpowers/preferences.md`. It does not broaden connected internal searches without your direction
2. Pick the matching template, or `self-shape` if nothing fits. When the format is ambiguous or high-stakes, recommend a deliverable and explain why
3. Offer a visual companion if the conversation looks like it needs sketches or diagrams
4. Ask contextual questions: reuse settled routine contracts, otherwise ask one independently answerable question at a time
5. Propose two or three approaches when the path isn't obvious
6. Walk through the plan and get your spoken approval. If you say the structure feels too generic, Claude researches the topic before trying again
7. Recommend conditional sections only when the answers reveal a relevant risk, and explain the readiness consequence if a material section is declined
8. Write and check the spec at `docs/mindpowers/specs/YYYY-MM-DD-<type>-<slug>.md`, naming any material blockers
9. You read the written spec and give final approval, which flips its status to `locked`
10. Hand off in a way that fits the document. `locked` approves the working brief; readiness and any required human approvals remain separate

From there, `drafting` preserves the spec's evidence qualifications, readiness,
blockers, and recorded external-review status. `reviewing-docs` routes weak
evidence, unresolved decisions, prose problems, verification needs, stable
preferences, and pending approvals differently. It explains the recommended
handoff and waits for your confirmation before each switch. `calibrating`
compares the Mindpowers draft with the final artifact and, with approval,
records reusable preferences for next time.

### Evidence that fits the next action

Mindpowers checks more than whether evidence exists. It asks whether the
evidence is strong enough for the document's stated scope and next action. For
an important conclusion, it gives a short explanation of its recommendation,
what it checked, the main reasons, what remains uncertain, and the next step.
It does not dump an internal scoring checklist.

- A one-pager can be ready for an early discussion with narrow evidence when
  the scope and uncertainty are clear. That does not prove the problem is
  widespread or approve a build.
- A PRD stays `not-ready` when weak evidence could change what gets built, how
  success is measured, or an important risk. Drafting can still continue
  provisionally with the blocker visible.
- A user may choose a target without strong evidence. Mindpowers records that
  honestly as a business decision, including the trade-off, rather than calling
  it an evidence-backed target.
- A small, reversible pilot can be ready for its limited scope when it tests a
  named assumption, has an observable result, and defines when to stop or
  change course. Expanding the scope requires a new readiness check; pilot
  readiness does not carry over to a full rollout.

PRDs use a compact core plus conditional modules. Every PRD covers evidence and baseline, users and scope, the selected solution and credible alternatives, stable `US-###` / `REQ-###` / `AC-###` contracts, measurement, risks, and open decisions. Telemetry, AI evaluations, decision rights, privacy, integration, operational, and rollout sections appear only when the product's actual risk triggers them. Small reversible changes stay small. If a build-critical choice is missing, the PRD says `needs-decision` instead of inventing a number, event, date, or owner.

## Install

### Claude Code

```bash
claude plugin marketplace add rohitgehe05/mindpowers && claude plugin install mindpowers@mindpowers
# Skill namespace: /mindpowers:mindstorming
```

### Cowork (Claude Desktop)

1. Download the `mindpowers-cowork-v*.zip` from the [latest release](https://github.com/rohitgehe05/mindpowers/releases/latest)
2. In Cowork: **Customize → Personal plugins → `+`**
3. Click "Upload local plugin", drag/select the zip, click **Upload**
4. Plugin appears in sidebar under Personal plugins. Trigger by asking for a brainstorm (e.g. "draft a PRD for X")

### Codex and ChatGPT desktop

Add the repository as a Codex plugin marketplace, then install Mindpowers:

```bash
codex plugin marketplace add rohitgehe05/mindpowers
codex plugin add mindpowers@mindpowers
```

Start a new Codex chat after installation. In ChatGPT desktop, the same plugin is available in Work mode under **Plugins** after the marketplace is added.

### Cursor

1. Open **Customize** in the sidebar
2. Go to **Rules** and click **Add Rule**
3. Select **Remote Rule (GitHub)**
4. Enter `https://github.com/rohitgehe05/mindpowers`
5. Review the imported skills under **Customize -> Skills**

[Cursor discovers Agent Skills](https://cursor.com/docs/skills) and invokes them when their descriptions match. You can also name a skill explicitly in your prompt.

### Other Agent Skills clients

Each directory under `skills/` follows the open [Agent Skills specification](https://agentskills.io/specification). Copy the skill directories you want into the user-level or project-level skills location documented by your client. Paths and plugin packaging vary by client, so use the native instructions above where available.

## Works alongside superpowers

`superpowers:brainstorming` fires for code and features. `mindpowers:mindstorming` fires for documents and comms. Writing a PRD belongs to mindpowers; building what the PRD describes belongs to superpowers. And where coworkpowers is a suite, mindpowers is the one loop that stops Claude from writing the wrong doc in the first place.

## Where files go

```
docs/mindpowers/problems/       evidence-assessed problem briefs
docs/mindpowers/specs/          locked intent, one file per document
docs/mindpowers/drafts/         the actual deliverables, same stem as their spec
docs/mindpowers/reviews/        red-team notes
docs/mindpowers/preferences.md  what you've liked, by template type
```

Specs often carry sensitive content (leadership comms, OKR politics, exec briefings): in a shared or public git repo, mindstorming warns you and suggests `.gitignore`-ing `docs/mindpowers/` or picking a private location.

## What's new

- **0.9**: Mindpowers now checks whether evidence is strong enough for the next
  action, explains important conclusions in plain language, keeps limited-pilot
  readiness tied to its scope, and separates business choices, content
  readiness, and human approval.
- **0.8**: PRDs become adaptive engineering contracts with scoped evidence, stable requirement and acceptance-criteria IDs, risk-triggered telemetry and AI evaluation modules, and honest `build-ready` / `needs-decision` status.
- **0.7.1**: Native Codex and ChatGPT desktop plugin packaging, a tested Codex install path, and Cursor's supported GitHub import flow.
- **0.7**: `validating-problems` adds an optional evidence step before Mindstorming, with claim-level statuses that carry into a one-pager without implying prioritisation.
- **0.6**: `one-pager` joins the templates, for pitching a direction and getting fast alignment before a full PRD or decision doc gets written. BRD is the same template at more weight, not a separate one.
- **0.5**: `calibrating` remembers what landed and what you changed, per template type, in `docs/mindpowers/preferences.md`. Mindstorming reads it at the start of every session, so your fourth business review starts smarter than your first.
- **0.4**: `drafting` and `reviewing-docs` complete the loop, and `post-mortem` joins the templates.

Full history in the [CHANGELOG](CHANGELOG.md).

## Philosophy

- **Two approvals beat one.** Talking it through misses things. Writing it down catches them.
- **Templates hold the lessons.** Standards you learned the hard way belong in a template, not your memory.
- **Cut ruthlessly.** Every section in a spec has to earn its place.
- **When nothing fits, slow down.** No template means one question at a time, which forces you to actually think.
- **No task is too small.** The spec for a Slack reply is short, but it still exists, except for short comms, which stay in chat unless you want a record.

## Credits

Built on:

- [obra/superpowers](https://github.com/obra/superpowers): the original skills framework and the brainstorming idea
- [nabeelhyatt/coworkpowers](https://github.com/nabeelhyatt/coworkpowers): the knowledge-work version that shaped the template approach

## License

MIT
