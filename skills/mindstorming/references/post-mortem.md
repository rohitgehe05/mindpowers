# Post-Mortem Template

For incident reviews, launch retrospectives, and "what happened" write-ups after something broke or went sideways. Encodes the standard: blameless framing, contributing factors instead of a single root cause, and every action item owned and dated.

**Spec type: spec-is-the-deliverable.** The post-mortem spec itself is the artefact. There's no separate downstream deliverable to draft from it. The handoff is type-aware (see SKILL.md handoff section).

## Sections

| Section | What goes here |
|---|---|
| Summary | 2-3 sentences: what happened, who or what it affected, how it was resolved. Written so someone who wasn't there understands the shape of the incident immediately. |
| Timeline | Chronological, timestamped where possible. Detection, escalation, mitigation, resolution. Stated plainly, no smoothing over gaps or slow responses. |
| Impact | Concrete and scoped: users affected, duration, revenue, trust, downstream systems. Numbers over adjectives. |
| What went well | What limited the damage or sped up the resolution. Worth naming so it's repeated. |
| Contributing factors | Plural, always. The conditions that let this happen, not a single culprit. Technical, process, and organizational factors all belong here. |
| Action items | Each one has an owner and a date. No exceptions. |
| What we'd do differently | Forward-looking. What changes given everything above. |

## Elicitation prompts

When self-shaping, one at a time:

1. In 2-3 sentences, what happened and who or what did it affect?
2. Walk me through the timeline. When was it detected, escalated, mitigated, resolved?
3. What was the impact, concretely? Users, duration, revenue, downstream effects.
4. What went well? What limited the damage or sped things up?
5. What were the contributing factors? (Push past the first answer, there's rarely just one.)
6. What are the action items? For each: who owns it, and by when?
7. What would you do differently, given all of this?

When a template match is suspected (user said "post-mortem", "incident review", "retro on the outage"), batched only if routine for this user:

> "To shape the post-mortem: what happened and what was the impact, what's the timeline, what contributing factors led here, and what actions (with owners and dates) come out of it?"

If the incident is sensitive, high-profile, or still being assigned blame informally, revert to one-question-at-a-time even though the template matches. See SKILL.md "Adaptive Elicitation."

## Standards baked in

- **Blameless framing.** Describe what happened to systems and processes, not what a person did wrong. Names appear as owners of actions, not as causes.
- **Contributing factors, not root cause.** Reject single-root-cause framing. Ask "what else had to be true" until at least two or three factors surface, spanning technical, process, and organizational layers.
- **Every action item owned and dated.** An action item with no owner or no date is not an action item, it's a wish. Push for both before the spec locks.
- **Lowlights stated plainly.** Slow detection, a missed alert, a skipped step: name it directly. No softening into "opportunities for improvement."
- **Impact in numbers, not adjectives.** "Significant impact" is not impact. Duration, user count, dollar figure.

## Anti-patterns

- Blame language, naming who screwed up rather than what conditions allowed it
- Single root cause when the honest answer is several contributing factors
- Action items with no owner, no date, or both
- Glossing over the timeline, skipping the slow or embarrassing parts
- Softening lowlights into vague "areas for improvement"
- Impact described in adjectives instead of numbers
