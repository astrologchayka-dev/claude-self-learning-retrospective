# Claude Self-Learning Retrospective

**A retrospective skill for Claude Code that turns every session's experience into durable mechanisms — so the agent gets smarter each session instead of starting from scratch.**

🇷🇺 [Русская версия / Russian README](README.md)

> Note: the skill itself (`skill/retrospective/`) is written in Russian; the method is language-agnostic. A translated skill is welcome via PR — see [Contributing](#contributing).

---

## Why

A memory-less LLM session only passes through a fixed set of chokepoints: the system prompt, auto-loaded `CLAUDE.md`, launch templates, skills (auto-triggered by their description), hooks on events, and the auto-loaded memory index (first ~200 lines). **A lesson living outside these points simply won't be read next session.** So "write the takeaway into a note" ≈ guaranteeing the mistake recurs.

This skill forces every lesson up from prose to a **mechanism** that fires inevitably, and refuses to call a lesson closed until the behavior change is *proven*.

## The core law

> A lesson is reliable exactly to the degree that the chokepoint it lives in is inevitable, **and** it's proven to have changed behavior. A note in memory is the lowest tier (~50% reliability; for rotating LLM sessions, nearly dead).

## The self-learning loop (8 steps)

Capture → Distill → Revise-gate → Route → Index-for-retrieval → **Verify behavior change** → Standardize (SDCA) → Check + spread (yokoten).

Grounded in the research on self-improving agents (Voyager's skill library, Reflexion, Case-Based Reasoning, MemGPT), postmortem engineering (Google SRE, just culture, hierarchy of controls), and lean (SDCA→PDCA, hansei, yokoten). Full write-up with sources: [research/self-learning-loop-for-claude.md](research/self-learning-loop-for-claude.md).

Also in this repo: [research/claude-code-context-efficiency.md](research/claude-code-context-efficiency.md) (in Russian) — Claude Code context economics: why saving tokens and raising quality are the same knob; memory / MCP / caching / subagents / skills with measured numbers, plus a budget-gate case study.

## Routing map — where to put a lesson (by descending reliability)

| Lesson type | Where | Why |
|---|---|---|
| "Always / never", block "done", block dangerous action | **Hook** | The harness runs it deterministically — the only real enforcement |
| Method "how to do X right" | **Skill** (+ duplicate into a template/DoD if mandatory) | Auto-triggered by its `description` |
| Stable fact / convention | **CLAUDE.md** | Auto-loaded, but advisory — keep it under 200 lines |
| Tied to a launch / handoff | **Launch template / DoD checklist** | Procedural entry point |
| Must be adversarially re-checked | **Critic subagent** paired with a gate | Clean context, not biased toward its own work |
| "Just remember it" | Memory index (first 200 lines) | Lowest tier — only as a pointer to a mechanism |

Full ranked table + Claude Code hook/memory mechanics: [skill/retrospective/reference/mechanics-and-basis.md](skill/retrospective/reference/mechanics-and-basis.md).

## Four failure modes of the loop (what kills "getting smarter")

1. **Reflection that doesn't change behavior** — prose without a mechanism → artifact + diff-verification.
2. **Retrieval failure** — the artifact exists but never loads/triggers → raise its rank or sharpen its `description`.
3. **Memory poisoning / drift** — stale or wrong entries get retrieved and mislead → Revise-gate before writing + periodic pruning.
4. **Hallucinated fix** — "wrote the service" but the data flow doesn't actually run → proof-gate (COUNT>0 / file exists / flow survives disk).

## Install

```bash
git clone https://github.com/astrologchayka-dev/claude-self-learning-retrospective.git
cp -r claude-self-learning-retrospective/skill/retrospective ~/.claude/skills/
# or: ./claude-self-learning-retrospective/install.sh
```

Claude Code will auto-load the skill by its description (end of session, after an incident/miss, "how do we stop this recurring", cross-session handoff). Invoke explicitly with `/retrospective`.

## Contributing

The skill is Russian by design (the author's whole setup is Russian). A faithful English translation of `skill/retrospective/` — kept in sync with the Russian canonical version — is a welcome PR. Keep the Russian version as the source of truth to avoid drift.

## License

MIT — see [LICENSE](LICENSE). Use it, fork it, adapt it.
