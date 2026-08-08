# Mindpowers

**Your AI should ask better questions before it writes.**

Most AI writing tools turn ambiguity into polished prose. Mindpowers does the
opposite: it checks the problem, challenges assumptions, explores credible
alternatives, and locks the important decisions before drafting.

Use it to turn rough thinking into one-pagers people can align around, PRDs
engineering can build from without decisions left in side conversations,
business reviews that surface the real story, and everyday documents that hold
up under scrutiny.

![Demo: Mindpowers turns raw business-review data into a decision-ready story before drafting](docs/assets/demo.gif)

*The useful insight appears before the first paragraph.*

Mindpowers is a problem-first knowledge-work skillset for Claude Code, Cowork,
Codex, ChatGPT desktop, Cursor, and other Agent Skills clients.

## Try it in one minute

Ask naturally:

- “Validate whether this customer problem is actually supported.”
- “Grill this idea until the problem and solution are clear.”
- “Turn this approved direction into a build-ready PRD.”
- “Review this document like a skeptical product leader.”
- “Fact-check this memo before I send it.”

Mindpowers will:

1. Recommend the right deliverable or skill when the next step is unclear.
2. Ask only the questions the context needs.
3. Write down the agreed direction, remaining uncertainty, and readiness.
4. Draft, review, or remember your preferences only after you confirm the handoff.

Natural requests trigger the skills. You can also name a skill explicitly, such
as `/mindpowers:mindstorming`, when your client supports slash commands.

## A real example

Imagine you ask Mindpowers to turn an approved idea into a build-ready PRD. The
idea says:

> Reduce handling time by 40%.

Mindpowers does not accept the number just because it is present. It asks:

> What makes 40% the right target?

If the answer is “leadership chose it” with no reason, the spec can still be
written, but it is not build-ready when that target affects the solution or how
success will be judged.

| What gets recorded | Result |
|---|---|
| Working direction | Reduce handling time by 40% |
| Spec status | `locked`, if you approve the written brief |
| Readiness | `not-ready` |
| Visible blocker | The 40% target has no understandable basis |
| Next step | Add a basis, or record the business trade-off behind the choice |

Now imagine the answer is:

> A reduction below 40% would not cover the cost of the investment. We accept
> the risk that the first release may miss it.

That is a usable basis. Mindpowers labels it as a **business decision**, records
the trade-off, and does not pretend that research proved the target. If the rest
of the PRD is ready, this target no longer blocks the build.

This is the difference between a polished document and an honest working
contract.

## The six-skill loop

Mindpowers uses one connected loop. It validates the problem when needed, then
shapes, drafts, reviews, fact-checks before shipping, and remembers what you like. It keeps provisional work
moving without hiding the blockers that still matter.

| Skill | What it does |
|---|---|
| `validating-problems` | Tests and scopes a customer or business problem against the available evidence |
| `mindstorming` | Recommends a deliverable, asks contextual questions, and turns the answers into a spec with honest readiness |
| `drafting` | Turns an approved spec into the deliverable while preserving uncertainty, blockers, and review status |
| `reviewing-docs` | Red-teams a document, explains each problem, and recommends the right next skill |
| `fact-checking` | Verifies a doc's claims against the user's sources with a quote-the-source rule and flags sensitive content before shipping |
| `calibrating` | Compares a Mindpowers draft with the final human-edited version and records approved, stable preferences |

Mindpowers explains a recommended handoff and asks for confirmation before
switching skills.

## Better reasoning produces better writing

A cold-drafted business review might open like this:

> This quarter we shipped 14 features across three teams. Signups were up 8%
> month over month, and support tickets held roughly steady.

A Mindpowers-shaped version leads with the decision-relevant insight:

> Growth is masking a retention problem: signups are up 8%, but week-4
> retention slipped from 61% to 54%, the first drop in a year. Onboarding
> shipped 14 features this quarter; none of them targeted the drop.

The facts did not change. Mindpowers decided the story and its standards before
drafting, so the important point did not need to be rescued during editing.

*Illustrative excerpt, not a real review.*

## Choose the right deliverable

You do not need to know the template name before starting.

| If you need to... | Start with... |
|---|---|
| Compare live options and make a choice | `decision-doc` |
| Explain a selected direction and get alignment | `one-pager` |
| Turn an approved direction into a build contract | `prd` |
| Check whether the underlying problem is real | `validating-problems` |
| Work out what you need | `mindstorming`, which will recommend a deliverable |

Mindpowers includes nine templates and a fallback:

| Template | Best fit |
|---|---|
| [`business-review`](skills/mindstorming/references/business-review.md) | Weekly or quarterly product reviews |
| [`decision-doc`](skills/mindstorming/references/decision-doc.md) | Strategic arguments, OKR defence, and build-vs-buy decisions |
| [`one-pager`](skills/mindstorming/references/one-pager.md) | A selected direction that needs alignment before a full PRD or decision doc |
| [`prd`](skills/mindstorming/references/prd.md) | An approved direction that needs traceable requirements, acceptance criteria, measurement, and honest build readiness |
| [`briefing-doc`](skills/mindstorming/references/briefing-doc.md) | Partner meetings, executive syncs, and regulator preparation |
| [`comms-draft`](skills/mindstorming/references/comms-draft.md) | Slack messages, team emails, and announcements |
| [`framework`](skills/mindstorming/references/framework.md) | Methods, rubrics, and playbooks |
| [`talking-points`](skills/mindstorming/references/talking-points.md) | OKR defence, Q&A preparation, and spoken communication |
| [`post-mortem`](skills/mindstorming/references/post-mortem.md) | Incident or project retrospectives |
| `self-shape` | Anything else, using one contextual question at a time |

Each template changes the language and depth shown to you. The basic system
underneath stays consistent: understand the purpose, surface important gaps,
record decisions, and judge readiness for the stated next action.

## Evidence, readiness, and approval

Mindpowers checks whether the available evidence is strong enough for what you
want to do next. It does the detailed assessment internally, then shows a short
plain-language conclusion, the main reason, the uncertainty, and the next step.

The standard changes with the action:

- A one-pager may be ready for an early discussion with limited evidence when
  the uncertainty and scope are clear.
- A PRD is not build-ready when weak evidence could materially change what gets
  built, how success is measured, or an important risk.
- A small, reversible pilot may be ready when it tests a named assumption,
  produces an observable result, and defines when to stop or change course.
- A full rollout needs a new readiness check. Pilot readiness does not carry
  over automatically.

Every material target or decision threshold also needs an understandable basis.
The basis might be a baseline, benchmark, customer expectation, test result,
financial constraint, operational requirement, or deliberate business
trade-off.

A business trade-off counts as a basis only when it is labelled as a business
decision and the reason is visible. Mindpowers does not call it
evidence-backed. If a material target has no basis, the work stays `not-ready`.

Three ideas remain separate:

| Term | What it means |
|---|---|
| Status | Whether you approved the written working brief, such as `locked` |
| Readiness | Whether the artifact is complete enough for its stated next action |
| Human approval | Whether the named stakeholders have actually signed off |

Mindpowers can judge the document. It never claims that stakeholders approved
it unless those approvals were explicitly recorded.

## What Mindpowers does not do

- It does not decide whether a validated problem should be prioritised.
- It does not guarantee that a claim, target, or chosen solution is correct.
- It does not treat a polished document as proof that the work is ready.
- It does not invent missing product choices, dates, numbers, or responsibilities.
- It does not claim stakeholder approval without a recorded sign-off.
- It does not confirm a claim it cannot quote a source for, and it does not run web research without asking.
- It does not search connected internal sources beyond the scope you provide.
- It cannot physically prevent a team from shipping.
- It does not create shared organisational memory across workspaces.

## Install

### Claude Code

```bash
claude plugin marketplace add rohitgehe05/mindpowers && claude plugin install mindpowers@mindpowers
# Skill namespace: /mindpowers:mindstorming
```

### Cowork (Claude Desktop)

1. Download `mindpowers-cowork-v*.zip` from the [latest release](https://github.com/rohitgehe05/mindpowers/releases/latest).
2. In Cowork, open **Customize → Personal plugins → `+`**.
3. Click **Upload local plugin**, select the zip, then click **Upload**.
4. Ask for the work you need, such as “Draft a PRD for X.”

### Codex and ChatGPT desktop

Add the repository as a Codex plugin marketplace, then install Mindpowers:

```bash
codex plugin marketplace add rohitgehe05/mindpowers
codex plugin add mindpowers@mindpowers
```

Start a new Codex chat after installation. In ChatGPT desktop, the same plugin
is available in Work mode under **Plugins** after the marketplace is added.

### Cursor

1. Open **Customize** in the sidebar.
2. Go to **Rules** and click **Add Rule**.
3. Select **Remote Rule (GitHub)**.
4. Enter `https://github.com/rohitgehe05/mindpowers`.
5. Review the imported skills under **Customize → Skills**.

[Cursor discovers Agent Skills](https://cursor.com/docs/skills) and invokes them
when their descriptions match. You can also name a skill explicitly.

### Other Agent Skills clients

Each directory under `skills/` follows the open
[Agent Skills specification](https://agentskills.io/specification). Copy the
skill directories you want into the user-level or project-level skills location
documented by your client. Paths and plugin packaging vary by client, so use the
native instructions above where available.

## Where files go and privacy

```text
docs/mindpowers/problems/       evidence-assessed problem briefs
docs/mindpowers/specs/          locked intent, one file per document
docs/mindpowers/drafts/         deliverables, using the same stem as their spec
docs/mindpowers/reviews/        red-team notes and fact-check claim ledgers
docs/mindpowers/preferences.md  approved preferences, grouped by template type
```

These files can contain sensitive material, including leadership communication,
strategy, and customer evidence. In a shared or public Git repository,
Mindpowers warns you and suggests adding `docs/mindpowers/` to `.gitignore` or
choosing a private location. The visual companion stores its rendered screens
under `.mindpowers/companion/` in the working folder; the same warning applies,
and the companion never fetches anything from the network.

Preferences and recent specs are workspace-local. They do not become a shared
company memory unless your organisation provides a separate shared system.

## Works alongside Superpowers

`superpowers:brainstorming` is for code and features.
`mindpowers:mindstorming` is for documents and communication. Writing a PRD
belongs to Mindpowers. Building what the PRD describes belongs to Superpowers.

Mindpowers is one connected loop for avoiding the wrong document, weak
reasoning, and invisible blockers before drafting begins.

## What’s new

- [**0.12.0**](https://github.com/rohitgehe05/mindpowers/releases/tag/v0.12.0):
  Fact-checking became the sixth skill. Every claim in a doc is verified
  against your sources — a verdict must quote its source line, or the claim
  lands on a "confirm this yourself" list — and a separate pass flags
  sensitive content before anything ships.
- [**0.11.0**](https://github.com/rohitgehe05/mindpowers/releases/tag/v0.11.0):
  Reviews now read your doc the way its real audience does: one to three
  fresh-context reviewer lenses, blind to the drafting conversation, with
  findings tracked by stable IDs across review rounds.
- [**0.10.0**](https://github.com/rohitgehe05/mindpowers/releases/tag/v0.10.0):
  A visual companion renders decision matrices, claim ledgers, and annotated
  findings in a browser tab while you work, with artifact and text fallbacks
  on clients without a shell.

See the [CHANGELOG](CHANGELOG.md) for the full release history.

## Philosophy

- **Two approvals beat one.** Talking it through misses things. Writing it down catches them.
- **Templates hold the lessons.** Standards you learned the hard way belong in a template, not your memory.
- **Cut ruthlessly.** Every section in a spec has to earn its place.
- **When nothing fits, slow down.** No template means one question at a time, which forces you to think.
- **No task is too small.** A short spec can still prevent a wrong turn. Short communication can stay in chat unless you want a record.

## Credits

Built on:

- [obra/superpowers](https://github.com/obra/superpowers): the original skills framework and the brainstorming idea
- [nabeelhyatt/coworkpowers](https://github.com/nabeelhyatt/coworkpowers): the knowledge-work version that shaped the template approach

## License

MIT
