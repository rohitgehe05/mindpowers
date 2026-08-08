# Visual Companion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Vendor superpowers' visual companion server into mindpowers and wire it into mindstorming, validating-problems, and reviewing-docs, per `docs/superpowers/specs/2026-08-07-visual-companion-design.md`.

**Architecture:** Copy the 5 upstream server files into `skills/_shared/companion/scripts/`, rebrand via targeted string replacements (env prefix, paths, cookie/storage keys, brand block, version lookup), and add one shared agent guide (`COMPANION.md`) that all three SKILL.md files reference. No behavioral changes to the server.

**Tech Stack:** Node.js stdlib only (no npm packages), bash, markdown skill files.

## Global Constraints

- Upstream source: `/Users/gehe/.claude/plugins/cache/claude-plugins-official/superpowers/6.2.0/skills/brainstorming/scripts/` (superpowers v6.2.0, MIT © 2025 Jesse Vincent)
- No npm dependencies, no build step, no external network fetches anywhere (logo fetch must be removed, not gated)
- Env var prefix: `MINDPOWERS_` (replaces `BRAINSTORM_`)
- Session path: `<project>/.mindpowers/companion/<session-id>/` (replaces `.superpowers/brainstorm/`); tmp fallback `/tmp/mindpowers-companion-<session-id>`
- Companion rules live ONLY in `skills/_shared/companion/COMPANION.md`; SKILL.md files get at most ~10 new lines each and a pointer
- Every vendored file keeps a header comment: `Vendored from obra/superpowers v6.2.0 (MIT, (c) 2025 Jesse Vincent) with mindpowers rebranding.`
- Attribution file: `skills/_shared/companion/LICENSE-superpowers` (verbatim copy of upstream LICENSE)
- Plugin version bumps 0.9.0 → 0.10.0 in the final task

---

### Task 1: Vendor and rebrand the server files

**Files:**
- Create: `skills/_shared/companion/scripts/server.cjs`
- Create: `skills/_shared/companion/scripts/start-server.sh`
- Create: `skills/_shared/companion/scripts/stop-server.sh`
- Create: `skills/_shared/companion/scripts/frame-template.html`
- Create: `skills/_shared/companion/scripts/helper.js`
- Create: `skills/_shared/companion/LICENSE-superpowers`

**Interfaces:**
- Produces: `start-server.sh [--project-dir <path>] [--open] [--foreground] [--host H] [--url-host U] [--idle-timeout-minutes N]` → prints one JSON line `{"type":"server-started","port":N,"url":"http://localhost:N/?key=…","screen_dir":"…/content","state_dir":"…/state"}`; `stop-server.sh <session_dir>`. Task 2 tests these; Task 3 documents them.

- [ ] **Step 1: Copy files**

```bash
UP=/Users/gehe/.claude/plugins/cache/claude-plugins-official/superpowers/6.2.0/skills/brainstorming
mkdir -p skills/_shared/companion/scripts
cp "$UP"/scripts/{server.cjs,start-server.sh,stop-server.sh,frame-template.html,helper.js} skills/_shared/companion/scripts/
cp "$UP"/../../LICENSE skills/_shared/companion/LICENSE-superpowers
```

(Upstream LICENSE lives at the superpowers plugin root, two levels above `skills/brainstorming`.)

- [ ] **Step 2: Mechanical renames (all 5 files)**

```bash
cd skills/_shared/companion/scripts
LC_ALL=C sed -i '' \
  -e 's/BRAINSTORM_/MINDPOWERS_/g' \
  -e 's/brainstorm-server-id/mindpowers-server-id/g' \
  -e 's/brainstorm-key-/mindpowers-key-/g' \
  -e 's/brainstorm-session-key/mindpowers-session-key/g' \
  -e 's|\.superpowers/brainstorm|.mindpowers/companion|g' \
  -e 's|/tmp/brainstorm|/tmp/mindpowers-companion|g' \
  -e 's/window\.brainstorm/window.mindpowers/g' \
  server.cjs start-server.sh stop-server.sh frame-template.html helper.js
```

- [ ] **Step 3: Replace the brand/version block in server.cjs**

In `server.cjs`, delete these upstream declarations (post-sed they sit near the top constants, upstream lines 105–112): `SUPERPOWERS_VERSION`, `SUPERPOWERS_BRAND_IMAGE_URL`, `TELEMETRY_DISABLE_ENV_VARS`, `SUPERPOWERS_TELEMETRY_DISABLED`, and replace with:

```js
const MINDPOWERS_VERSION = readMindpowersVersion();
```

Replace the whole `readSuperpowersVersion()` function (upstream lines 208–226) with:

```js
function readMindpowersVersion() {
  // scripts/ -> companion/ -> _shared/ -> skills/ -> plugin root
  const manifest = path.join(__dirname, '../../../..', '.claude-plugin/plugin.json');
  try {
    const data = JSON.parse(fs.readFileSync(manifest, 'utf-8'));
    if (data.version) return String(data.version);
  } catch (e) { /* packaged layouts may differ; brand line shows 'unknown' */ }
  return 'unknown';
}
```

Replace the body of the brand-HTML helper (upstream lines 243–251, the function returning the `<div class="brand">…` string) with a text-only, offline version:

```js
  const version = escapeHtmlText(MINDPOWERS_VERSION);
  return '<div class="brand"><a href="https://github.com/rohitgehe05/mindpowers">' +
    '<span class="brand-copy">Mindpowers Companion v' + version + '</span></a></div>';
```

Verify no references to the deleted constants remain: `grep -n 'SUPERPOWERS\|primeradiant\|TELEMETRY' server.cjs` → no output.

- [ ] **Step 4: Retitle the frame and stopped-overlay copy**

- `frame-template.html`: `<title>Superpowers Brainstorming</title>` → `<title>Mindpowers Companion</title>`; header comment `BRAINSTORM COMPANION FRAME TEMPLATE` → `MINDPOWERS COMPANION FRAME TEMPLATE`.
- `helper.js`: `'This brainstorm companion has stopped. '` → `'This companion has stopped. '`.
- Sweep the shell scripts' comments: in `start-server.sh` and `stop-server.sh` replace remaining prose occurrences of "brainstorm server" with "companion server" (comments only; the sed in Step 2 already handled all functional strings). `grep -in brainstorm skills/_shared/companion/scripts/*` → no output.

- [ ] **Step 5: Add attribution headers**

Add as line 2 (after shebang / after `<!doctype` respectively) in each of the 5 files, using each file's comment syntax:

```
Vendored from obra/superpowers v6.2.0 (MIT, (c) 2025 Jesse Vincent) with mindpowers rebranding. See ../LICENSE-superpowers.
```

- [ ] **Step 6: Syntax-check and commit**

```bash
node --check skills/_shared/companion/scripts/server.cjs
bash -n skills/_shared/companion/scripts/start-server.sh skills/_shared/companion/scripts/stop-server.sh
git add skills/_shared/companion
git commit -m "feat: vendor visual companion server from superpowers (MIT)"
```

Expected: both checks silent, commit succeeds.

---

### Task 2: Smoke test

**Files:**
- Create: `skills/_shared/companion/scripts/smoke-test.sh`

**Interfaces:**
- Consumes: `start-server.sh` / `stop-server.sh` from Task 1.
- Produces: `smoke-test.sh` (no args, exit 0 = pass) — the repo's runnable check for the vendored server.

- [ ] **Step 1: Write the test**

```bash
#!/usr/bin/env bash
# Smoke test: start companion, push a screen, fetch it with/without key, stop.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"
SESSION_DIR=""
cleanup() {
  [ -n "$SESSION_DIR" ] && bash "$DIR/stop-server.sh" "$SESSION_DIR" >/dev/null 2>&1 || true
  rm -rf "$TMP"
}
trap cleanup EXIT

OUT="$("$DIR/start-server.sh" --project-dir "$TMP")"
URL="$(printf '%s' "$OUT" | node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>console.log(JSON.parse(s).url))')"
SCREEN_DIR="$(printf '%s' "$OUT" | node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>console.log(JSON.parse(s).screen_dir))')"
SESSION_DIR="$(dirname "$SCREEN_DIR")"

printf '<h2>SMOKE-MARKER-42</h2>' > "$SCREEN_DIR/smoke.html"
sleep 1

BODY="$(curl -sf "$URL")"
echo "$BODY" | grep -q 'SMOKE-MARKER-42' || { echo "FAIL: screen not served"; exit 1; }
echo "$BODY" | grep -q 'Mindpowers Companion' || { echo "FAIL: brand missing"; exit 1; }
echo "$BODY" | grep -qi 'superpowers' && { echo "FAIL: upstream branding leaked"; exit 1; }

BARE="${URL%%\?*}"
CODE="$(curl -s -o /dev/null -w '%{http_code}' "$BARE")"
[ "$CODE" != "200" ] || { echo "FAIL: keyless request served"; exit 1; }

bash "$DIR/stop-server.sh" "$SESSION_DIR" >/dev/null
[ -f "$SESSION_DIR/state/server-stopped" ] || { echo "FAIL: no server-stopped marker"; exit 1; }
SESSION_DIR=""
echo PASS
```

`chmod +x skills/_shared/companion/scripts/smoke-test.sh`

- [ ] **Step 2: Run it**

Run: `skills/_shared/companion/scripts/smoke-test.sh`
Expected: `PASS`. If the brand grep fails, revisit Task 1 Step 3; if keyless returns 200, the sed broke key auth — diff against upstream.

- [ ] **Step 3: Commit**

```bash
git add skills/_shared/companion/scripts/smoke-test.sh
git commit -m "test: companion smoke test"
```

---

### Task 3: Write the shared companion guide (COMPANION.md)

**Files:**
- Create: `skills/_shared/companion/COMPANION.md`

**Interfaces:**
- Consumes: script paths from Task 1.
- Produces: the doc that Tasks 4–6 point to as `skills/_shared/companion/COMPANION.md`.

- [ ] **Step 1: Write the guide**

Adapt upstream `visual-companion.md` to mindpowers. Full required content:

````markdown
# Mindpowers Companion Guide

Browser-based visual companion for elicitation and review. Vendored from
obra/superpowers (MIT); see LICENSE-superpowers.

## Mode detection and fallback ladder

Detect ONCE, at offer time, never mid-flow. The offer message names the mode.

1. `bash` + `node` available and a local browser plausible (CLI harness on the
   user's machine) → **browser companion** (this guide).
2. No shell, but the client renders artifacts/canvas (Cowork, claude.ai) →
   render the SAME HTML fragments as artifacts; choices come back in chat.
3. Neither → text tables in chat.

## Rules (all modes)

- The board is the chooser; a blocking question in chat is the wait mechanism.
  Never ask "which option?" in chat while the same options are on screen.
- A typed reply always wins over a browser click.
- Per-question judgment: render only content that is visual (matrices, flows,
  diagrams, side-by-side structures). Text-shaped questions stay in chat.
- When dialogue leaves visual territory, push a waiting screen
  (`<div class="section"><p class="subtitle">Continuing in chat...</p></div>`)
  so stale choices aren't left on screen.
- Before every push: check `$STATE_DIR/server-info` exists and
  `$STATE_DIR/server-stopped` does not. If stopped, restart with the same
  `--project-dir` — same port, the open tab reconnects itself.
- Session screens may contain sensitive doc content. When starting a session in
  a shared or public repo, remind the user to add `.mindpowers/` to `.gitignore`.

## Starting a session (browser mode)

Run AFTER the user accepts the offer:

```bash
<plugin-root>/skills/_shared/companion/scripts/start-server.sh \
  --project-dir <working-folder> --open
```

Returns one JSON line: `{"type":"server-started","port":…,"url":"http://localhost:PORT/?key=…","screen_dir":"…/content","state_dir":"…/state"}`.
Save `screen_dir`/`state_dir`. Always share the FULL url (the `?key=` is the
session auth; never strip it). If stdout was lost, read `$STATE_DIR/server-info`.
Windows/Codex: the script auto-foregrounds — launch with your harness's
background mechanism (`run_in_background: true`) and read `server-info` next turn.
Stop with `stop-server.sh <session_dir>`; auto-stops after 4h idle.

## The loop

1. Write an HTML fragment to a NEW file in `screen_dir` (semantic names:
   `structure-options.html`, `claim-ledger.html`; iterations get `-v2`). Never
   reuse filenames; never use heredoc — use your file tool. Server serves the
   newest file and wraps fragments in the themed frame automatically.
2. Tell the user what's on screen, remind them of the URL, ask them to reply in
   chat (clicking is optional). End your turn.
3. Next turn: read `$STATE_DIR/events` (JSONL:
   `{"type":"click","choice":"a","text":"…","timestamp":…}`). Merge with the
   chat reply; chat is primary. File absent = no browser interaction. The click
   path (multiple clicks before settling) can reveal hesitation worth asking about.
4. Iterate on the same question with a new versioned file, or advance.

## Fragment vocabulary (frame provides all CSS)

- Options: `<div class="options"><div class="option" data-choice="a" onclick="toggleSelect(this)"><div class="letter">A</div><div class="content"><h3>…</h3><p>…</p></div></div></div>` (add `data-multiselect` to the container for multi-select)
- Cards: `.cards > .card[data-choice] > .card-image + .card-body`
- Side-by-side: `.split`; pros/cons: `.pros-cons > .pros + .cons`
- Mockups: `.mockup > .mockup-header + .mockup-body`; wireframe bits:
  `.mock-nav .mock-sidebar .mock-content .mock-button .mock-input .placeholder`
- Typography: `h2` title, `h3` heading, `.subtitle`, `.section`, `.label`
- 2–4 options max per screen; state the question on the page itself.
- Inline SVG works inside fragments — use it for flows and connection diagrams
  (arrows and dependencies, never loose boxes).

## Named screens per skill

- **mindstorming**: 2x2 matrices, scoring grids, swimlane flows, comparison
  tables, wireframes, and structure options (render genuinely different
  architectures — if two variants differ only in headline, they're too similar).
- **validating-problems — claim ledger**: one table, re-pushed as statuses
  change (`claim-ledger.html`, `claim-ledger-v2.html`, …):

  ```html
  <h2>Claim ledger</h2>
  <p class="subtitle">Status as of this conversation</p>
  <table>
    <tr><th>Claim</th><th>Status</th><th>as_of</th></tr>
    <tr><td>Existence: …</td><td>supported</td><td>2026-08-07</td></tr>
    <tr><td>Audience: …</td><td>partially-supported</td><td>2026-08-07</td></tr>
    <tr><td>Materiality: …</td><td>unsupported</td><td>—</td></tr>
    <tr><td>Mechanism: …</td><td>unsupported</td><td>—</td></tr>
  </table>
  ```

- **reviewing-docs — annotated view** (`annotated-findings.html`): for each
  finding, a `.section` quoting the anchored line followed by the finding,
  severity-labelled with `.label` (BLOCKER / WEAKENS / POLISH) and its stable
  finding ID. Read-only — findings discussion stays in chat.
````

- [ ] **Step 2: Verify internal consistency**

`grep -n 'superpowers' skills/_shared/companion/COMPANION.md` → only the attribution line. Confirm the two paths it references exist: `scripts/start-server.sh`, `LICENSE-superpowers`.

- [ ] **Step 3: Commit**

```bash
git add skills/_shared/companion/COMPANION.md
git commit -m "docs: shared companion guide"
```

---

### Task 4: Wire mindstorming

**Files:**
- Modify: `skills/mindstorming/SKILL.md` (Visual Companion section, ~lines 326–346)

**Interfaces:**
- Consumes: `skills/_shared/companion/COMPANION.md` (Task 3).

- [ ] **Step 1: Replace the offer quote and add the mechanism pointer**

Replace the offer blockquote (the paragraph ending `They render inline as artefacts."`):

```markdown
> "Some of what we're working on might be easier to see. I can render decision
> matrices, flows, comparison tables, or simple diagrams alongside our chat —
> [in a browser tab that opens for you | as inline artifacts | as tables in
> chat, pick per the fallback ladder]. Want me to use visuals where they help?"
```

Immediately after the "If the user accepts…" list, add:

```markdown
On acceptance, follow `skills/_shared/companion/COMPANION.md` for the
mechanism: mode detection and fallback ladder, server lifecycle, screen
pushing, reading browser events, and the shared rules (board is the chooser;
a typed reply always wins over a click).
```

- [ ] **Step 2: Verify and commit**

`grep -n 'render inline as artefacts' skills/mindstorming/SKILL.md` → no output; `grep -n 'COMPANION.md' skills/mindstorming/SKILL.md` → one hit.

```bash
git add skills/mindstorming/SKILL.md
git commit -m "feat: mindstorming uses the companion mechanism"
```

---

### Task 5: Wire validating-problems

**Files:**
- Modify: `skills/validating-problems/SKILL.md` (insert new section before `## Hard rules`, line 185)

**Interfaces:**
- Consumes: `skills/_shared/companion/COMPANION.md`.

- [ ] **Step 1: Insert the section**

```markdown
## Visual companion (optional)

When the claim discussion has enough moving parts that a table beats prose
(usually once two or more claims have different statuses), offer the visual
companion in its own message, naming the mode per the fallback ladder in
`skills/_shared/companion/COMPANION.md`:

> "Want a live claim ledger alongside our chat? It shows each claim's status
> and as-of date, updating as we go."

If accepted, follow COMPANION.md. Push the `claim-ledger` screen there and
re-push it (versioned filename) whenever a claim's status or as_of changes.
Everything else — questions, evidence discussion, the brief — stays in chat.
Never offer during the first bound-the-decision exchange.
```

- [ ] **Step 2: Verify and commit**

`grep -n 'COMPANION.md' skills/validating-problems/SKILL.md` → one hit; section sits directly above `## Hard rules`.

```bash
git add skills/validating-problems/SKILL.md
git commit -m "feat: claim-ledger companion screen in validating-problems"
```

---

### Task 6: Wire reviewing-docs

**Files:**
- Modify: `skills/reviewing-docs/SKILL.md` (insert new section after `## Output`, before `## Root-cause routing`, line 124)

**Interfaces:**
- Consumes: `skills/_shared/companion/COMPANION.md`.

- [ ] **Step 1: Insert the section**

```markdown
## Visual companion (optional)

After findings are assembled, when there are 3+ line-anchored findings, offer
the annotated view in its own message, naming the mode per the fallback ladder
in `skills/_shared/companion/COMPANION.md`:

> "Want the findings as an annotated view alongside our chat? Each finding
> appears under the exact line it's anchored to, severity-labelled."

If accepted, follow COMPANION.md and push the `annotated-findings` screen: one
`.section` per finding — quoted line, then the finding with its severity
(`.label`: BLOCKER / WEAKENS / POLISH) and ID. The view is read-only;
discussion and routing decisions stay in chat. The saved review file remains
the artifact of record.
```

- [ ] **Step 2: Verify and commit**

`grep -n 'COMPANION.md' skills/reviewing-docs/SKILL.md` → one hit.

```bash
git add skills/reviewing-docs/SKILL.md
git commit -m "feat: annotated-findings companion screen in reviewing-docs"
```

---

### Task 7: Repo hygiene and release metadata

**Files:**
- Modify: `.gitignore` (add ignore for local companion sessions)
- Modify: `CHANGELOG.md` (new 0.10.0 entry at top)
- Modify: `.claude-plugin/plugin.json` (version 0.9.0 → 0.10.0)

- [ ] **Step 1: Ignore companion sessions**

In `.gitignore`, directly under the existing `/.superpowers/` line, add:

```
/.mindpowers/
```

- [ ] **Step 2: Changelog + version**

Add at the top of `CHANGELOG.md` (match the file's existing entry format):

```markdown
## 0.10.0 - 2026-08-07

- Visual companion: vendored the superpowers companion server (MIT, attributed)
  as `skills/_shared/companion/`; browser screens during elicitation with
  artifact and text fallbacks.
- mindstorming renders its existing visual-companion offer for real;
  validating-problems gains a live claim ledger; reviewing-docs gains an
  annotated findings view.
```

Set `"version": "0.10.0"` in `.claude-plugin/plugin.json`. Check whether other manifests carry the version (`grep -rn '0\.9\.0' .claude-plugin .codex-plugin .agents 2>/dev/null`) and bump every hit.

- [ ] **Step 3: Final verification and commit**

```bash
skills/_shared/companion/scripts/smoke-test.sh   # PASS
grep -rn 'primeradiant\|SUPERPOWERS_' skills/_shared/companion/scripts/  # no output
git add .gitignore CHANGELOG.md .claude-plugin/plugin.json
git commit -m "chore: 0.10.0 release metadata for visual companion"
```

---

## Self-review notes

- Spec coverage: architecture/rebrand → Task 1; behavior preserved + auth verified → Task 2; shared-rules-in-one-doc + fallback ladder + named screens → Task 3; three touchpoints → Tasks 4–6; gitignore warning encoded in COMPANION.md rules; feedback→calibrating needs no code (clicks land in specs via mindstorming's normal decision recording, per spec §4).
- Out-of-scope items from spec §5: no task touches them.
- Path consistency: `skills/_shared/companion/` used identically in Tasks 1, 3, 4, 5, 6; version lookup depth (4 levels) matches that layout.
