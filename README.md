# Mindpowers

**Brainstorming superpowers for knowledge workers.**

Mindpowers is a plugin for Cowork and Claude Code. It gives Claude a careful way to brainstorm documents that aren't code — memos, reviews, PRDs, and the like. Instead of jumping straight to a draft, Claude asks you questions until the rough idea becomes a clear, written spec.

It's the knowledge-work version of [obra/superpowers](https://github.com/obra/superpowers), and a cousin of [coworkpowers](https://github.com/nabeelhyatt/coworkpowers) — but it sticks to one thing: brainstorming.

## Why

Most AI writing goes wrong at the start, not the end. Claude rushes to produce something before it knows what you actually want. You get prose that sounds fine but misses the point — or worse, confidently repeats back assumptions you never checked.

Mindpowers fixes this with two approvals before any drafting happens:

1. **Approve the thinking.** Claude walks through the plan with you, section by section, so you catch the gaps and bad assumptions out loud.
2. **Approve the spec.** Claude writes the agreed plan to a file. Putting it in writing forces the precision a conversation lets slide.

Drafting starts only after both pass. Tight specs make tight drafts.

## What you get

One skill: `brainstorming`. Seven templates, plus a fallback for anything that doesn't fit one.

| Template | When it fires |
|---|---|
| `business-review` | Weekly or quarterly product reviews |
| `decision-doc` | Strategic arguments, OKR defence, build-vs-buy |
| `prd` | Product specs |
| `briefing-doc` | Partner meetings, exec syncs, regulator prep |
| `comms-draft` | Slack messages, team emails, announcements |
| `framework` | Methods, rubrics, playbooks |
| `talking-points` | OKR defence, Q&A prep, anything you'll say out loud |
| `self-shape` | Anything else — Claude asks one question at a time |

Each template carries the lessons that make that kind of document good: lead with the insight (not the data) in a business review, put the recommendation first in a decision doc, write hypotheses you can actually prove or disprove in a PRD.

## How it works

When the skill runs, it goes through ten steps:

1. Read the context — recent specs, what you've been talking about
2. Pick the matching template, or use `self-shape` if nothing fits. Decide whether the topic is routine for you or new ground.
3. Offer a visual companion if the conversation looks like it needs sketches or diagrams
4. Ask questions — one at a time, or a few at once when the task is routine and a template fits
5. Suggest two or three approaches when the path isn't obvious
6. Walk through the plan and get your spoken approval. If you say the structure feels too generic, Claude researches the topic before trying again.
7. Write the spec to `docs/brainstorm/<type>/YYYY-MM-DD-<slug>.md`
8. Check its own work and show you what it checked
9. You read the written spec and give final approval
10. Hand off in a way that fits the document. A briefing doc ends with "draft it, hand it back, or stop?" A framework — where the spec is the deliverable — ends with "stop, draft something from it, or pause?"

## What's in v0.2

- Claude now judges whether a topic is routine or new for you, not just whether a template matches
- When you say a structure feels too generic, Claude researches before trying again
- Frameworks, decision docs, and PRDs now cite their sources
- The framework template covers personal and life frameworks, not only work ones
- Structure advice now asks how the pieces connect, not just where they sit
- The handoff at the end depends on the kind of document
- Claude shows you its self-review instead of doing it silently

## Installation

### Cowork (Claude Desktop)

1. Download `mindpowers-cowork-v0.2.0.zip` from the [latest release](https://github.com/rohitgehe05/mindpowers/releases/latest)
2. In Cowork: **Customize → Personal plugins → `+`**
3. Click "Upload local plugin", drag/select the zip, click **Upload**
4. Plugin appears in sidebar under Personal plugins. Trigger by asking for a brainstorm (e.g. "draft a PRD for X")

### Claude Code

```bash
git clone https://github.com/rohitgehe05/mindpowers.git
claude --plugin-dir ./mindpowers
# Skill namespace: /mindpowers:brainstorming
```

### Notes

- Repo uses standard Claude Code plugin layout (`skills/<name>/SKILL.md` nested). Cowork zip is built from the same source via `scripts/build-cowork-zip.sh` and attached automatically to each release tag.
- Don't zip the repo directly — the release zip strips dev files (CHANGELOG, CONTRIBUTING, .github, scripts, dist) for a clean install bundle.

## Quick start

Once it's installed, the skill kicks in on its own when you ask for a real document. You can also call it directly:

```
"Help me draft the Q1 product business review"
"I need a decision doc on whether to extend the partnership"
"Brainstorm a PRD for the new onboarding flow"
"What should I say in the OKR defence next week?"
```

From there Claude picks the template, asks for the details, saves the spec to a file, and asks how you want to continue.

## Philosophy

- **Two approvals beat one.** Talking it through misses things. Writing it down catches them.
- **Templates hold the lessons.** Standards you learned the hard way belong in a template, not your memory.
- **Cut ruthlessly.** Every section in a spec has to earn its place.
- **When nothing fits, slow down.** No template means one question at a time — which forces you to actually think.
- **No task is too small.** The spec for a Slack reply is short, but it still exists.

## Credits

Built on:

- [obra/superpowers](https://github.com/obra/superpowers) — the original skills framework and the brainstorming idea
- [nabeelhyatt/coworkpowers](https://github.com/nabeelhyatt/coworkpowers) — the knowledge-work version that shaped the template approach

## License

MIT
