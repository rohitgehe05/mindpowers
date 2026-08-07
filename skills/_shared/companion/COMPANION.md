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
