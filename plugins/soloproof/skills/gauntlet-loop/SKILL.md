---
name: gauntlet-loop
description: Run a Gauntlet Loop on any goal — set an external quality bar the agent can't talk its way around, let a lead agent split the work, give every piece its own builder and a fresh-context blind critic, and keep looping until the output beats the bar or the human stops the run. Works for code, games, websites, decks, writing, research, content, and product design. Use this skill whenever the user wants output at "AAA quality", wants work compared side-by-side against the best real-world equivalent, says "gauntlet", "gauntlet loop", "loop until perfect", "keep improving until it beats X", "harsh critic", "blind A/B", "อยากได้ระดับเทพ", "วนจนกว่าจะเทียบเท่าของจริง", "เทียบกับของจริง", "ให้ critic โหดๆ ตรวจ" — or hands over an ambitious build with an unusually high quality demand, even if they never say the word gauntlet. Also use when the user asks how to set a quality bar for agent work.
---

# Gauntlet Loop

Split, build, judge, repeat — against a bar that is not the builder's opinion.

The method (from Matt Shumer's "Claude of Duty" run): a lead agent gets a goal
and a **real example of what great looks like**. It splits the goal into the
smallest pieces that can be improved separately. Each piece gets a builder and
a **separate critic with fresh context**. The critic compares the actual
artifact against the reference — blind, side by side — and if the reference
wins, names the biggest remaining gap and sends the work back. There is no
fixed round count; the human is the stop button.

Why it works: models are far better at *comparison* than at absolute judgment,
and a builder asked to grade its own work will defend its decisions instead of
finding gaps. The external bar converts "is this good?" (unanswerable) into
"which of these two is better?" (answerable), and separation of builder and
critic removes the defense lawyer from the jury.

This skill complements `agent-orchestration`: that skill chooses the topology;
this one is the execution method for its IMPROVE family (12. Evaluator–
Optimizer with a hard external verifier). Run `agent-orchestration` Gate 0
first — a gauntlet on a task one agent already gets right is pure waste.

## Step 0 — Check the environment, honestly

The full gauntlet needs an agentic harness: Claude Code (or similar) where the
model can run code, render output, inspect screenshots, and spawn subagents in
clean context windows. In Claude Code, use subagents for critics and turn on
maximum effort (`/effort` → ultracode) for serious runs; use `/loop` for the
repetition.

In a plain chat with no subagents, do NOT pretend. Say so, then run the
**degraded mode**: build, then write the critique as a separate pass that
re-reads only two things — the artifact and the bar — and answers, in order:
which is better, what is the single biggest gap, what evidence shows it.
Do not re-read or cite your build reasoning during the pass. It is weaker
than a fresh-context critic — the human review compensates. Never claim a
blind comparison happened when it didn't.

## Step 1 — Set the bar before anything is built

The bar is the most important decision in the entire run. Get it wrong and
everything downstream is motion without a finish line.

A real bar passes four tests:

1. **External.** It exists outside the builder's head. Screenshots of the real
   product, a competitor's actual page, a published paragraph, a test suite, a
   latency number. "Make it amazing" and "production-ready" fail this test.
2. **Inspectable.** The critic can put the artifact and the bar side by side
   and look at the actual thing — real pixels, running code, finished prose.
   Never a summary the builder wrote about its own work.
3. **Comparable.** "Which one is better?" has an answer. If the honest answer
   is "they're not the same kind of thing", the bar is wrong.
4. **Hard.** The bar does not need to be reachable. An unreachable bar is a
   feature: it removes the stopping condition "good enough for AI" and gives
   the loop a direction. Shumer's game never beat Call of Duty — the point was
   that it kept improving until the human stopped it.

Bars by artifact type:

| Artifact | Bar |
|---|---|
| Game / visual app | Screenshots or video of the best real product in the category |
| Website / landing page | 2–3 of the best real sites in the category, at the same viewport |
| Writing | Published paragraphs with the clarity and compression you want |
| Code / backend | Test suite, latency target, failure-injection test, reference implementation |
| Deck / report | A real deck from the org or industry that the room considered excellent |
| Short-form content | The user's own best-performing piece, or the category benchmark piece |

If no bar is supplied, **finding one is the first subtask** — spawn an agent
to propose a concrete comp and justify it in one sentence, and get the human
to confirm it before the build starts. Do not let the lead agent silently
decide what "good" means; that reintroduces self-grading one level up.

Use **several bars, not one metric**. A single metric is gameable — an agent
can win a Lighthouse score while making the page worse. Pair the primary
comparison with 1–2 guardrail checks (it still works, it still passes tests,
it still says the true thing) that must hold on every round.

## Step 2 — Give the goal, not the implementation

Write the lead-agent prompt short. State the goal, the bar, the loop rule, and
the boundaries — and stop. Do not prescribe the architecture, the workstreams,
the tech stack (unless a constraint genuinely exists), or a round count.
Prescribing the route replaces the model's judgment with yours, and on large
goals the model's decomposition is usually better than a human's guess made
before any work exists.

What the short prompt MUST still contain — the viral version omits these and
burns money for it:

- **A budget boundary.** Time, token, or cost ceiling. An unreachable bar plus
  no budget is an infinite loop by construction. "Stop and report when you hit
  N hours / your context budget" is one line.
- **Hard boundaries.** What must not be touched: production systems, schemas,
  paid dependencies, unrelated refactors, real send/publish actions.
- **A reporting duty.** On stop — whether by bar, budget, or human — report
  the remaining gaps with evidence, not a victory summary.

## Step 3 — Let the lead agent split the work

The lead agent divides the goal into the smallest pieces that can be improved
and judged **separately**. "Make the whole thing better" is too large to
attack; "make this one element beat that element in the reference" is a
problem the loop can hit repeatedly.

Two constraints on the split, from `agent-orchestration`:

- Tightly coupled pieces keep one owner. Splitting work that shares unwritten
  conventions produces individually-good, jointly-incoherent parts.
- Pieces that write to the same file do not run in parallel.

## Step 4 — Builder and critic are never the same agent

Spawn the critic **fresh**, with: the goal, the bar, the guardrail checks, and
the artifact itself. Give it none of the builder's history, reasoning, or
explanations — the builder's story is a defense brief, and a critic who reads
it grades the brief instead of the work.

The critic's protocol, every round:

1. Inspect the real artifact — render it, run it, read it. Never a summary.
2. Blind A/B against the bar: both items, unlabeled, "which is better?"
3. If the bar wins: name the **single biggest** remaining gap, with evidence
   (screenshot, failing case, quoted passage). One gap, not a laundry list —
   the builder needs a target, not a backlog.
4. Check the guardrails. A round that wins the A/B but breaks a guardrail is
   a failed round.

Send the gap back to the builder. Build, judge, repeat.

## Step 5 — Keep looping, and know the three stops

No arbitrary final round. The loop ends only when:

1. **The bar is beaten** on the blind comparison with guardrails intact, or
2. **The budget is spent** — report gaps and stop, or
3. **The human stops it** — which is the normal ending, and fine.

And one abort condition that overrides all three: **spinning**. If a builder
attempts the same fix for the same gap twice and the critic reports the same
evidence, the loop is repeating, not learning. Do not run round three of the
same move — change the approach, re-split the piece, or escalate to the human
with the evidence. Loops that can't adapt burn the whole budget on one gap.

## Step 6 — Smoothing pass and live progress

After each major wave of parallel improvement, spawn one fresh agent to
inspect the **complete** result and reconcile the pieces — fix conflicts, make
it feel like one thing. Its mandate is coherence, not redesign.

For runs longer than ~30 minutes, have the lead agent maintain a simple live
progress page (HTML or markdown, updated as it works) showing the artifact
evolving — screenshots, drafts, test results, whatever fits. The human checks
it from a phone instead of interrupting the run. Don't over-specify the page.

## Report the run setup

Before the first round, tell the human the shape of the run in three lines —
same reason `agent-orchestration` reports its routing: a one-line disagreement
now is cheaper than a wrong run that completes.

```
Bar: <the concrete reference, one line> · Guardrails: <the checks>
Split: <the pieces the lead agent chose>
Budget: <ceiling> · Boundaries: <what won't be touched>
```

Get the bar confirmed here if the human didn't supply it. Then start the loop
and stay out of the way.

## Prompt skeleton

Fill the brackets, keep it this short:

```
Build [GOAL].

The bar: [CONCRETE REFERENCE — files/URLs/screenshots/tests]. Guardrails that
must hold every round: [1–2 CHECKS].

Split the goal into the smallest pieces that can be improved and judged
independently — you decide the split. For each important piece, fan out a
builder and a separate critic with fresh context. The critic inspects the real
output, compares it blind side-by-side with the bar, and if ours loses, names
the single biggest gap with evidence and sends it back. Keep looping — no
fixed round count.

If the same fix fails twice on the same evidence, change approach instead of
repeating. After each major wave, run one smoothing agent over the whole
result for coherence. Maintain a simple live progress page as you work.

Boundaries: [WHAT NOT TO TOUCH]. Budget: stop and report remaining gaps with
evidence at [CEILING].

Use subagents and ultracode.
```

## When NOT to gauntlet

- The task is small or a competent single pass already gets it right —
  `agent-orchestration` Gate 0. A gauntlet here costs ~15× for a worse result.
- No inspectable bar exists and none can be found — taste-only judgments
  ("make it feel more like me") need the human in the loop, not a critic
  agent pretending to have taste.
- The artifact is mostly *decisions*, not craft — a strategy choice needs
  `panel-critique` (multiple perspectives, scored options), not a build loop.
- The output must not be iterated in public: anything with real side effects
  per round (sending, publishing, spending) — loop on a draft or staging copy
  only.

## หมายเหตุฉบับผู้เรียน SOLO PROOF — เมื่อรัน subagent ไม่ได้

skill นี้ออกแบบให้ใช้หลาย agent ช่วยกัน ถ้าสภาพแวดล้อมของคุณไม่มีเครื่องมือ spawn agent
(เช่น ใช้แชท Claude ธรรมดา ไม่ใช่ Cowork/Claude Code) **อย่ายกเลิกงาน** — ให้ทำแบบเรียงคิวแทน:
เล่นทีละบทบาทในแชทเดียว จบบทบาทหนึ่งค่อยขึ้นบทบาทถัดไป แล้วสังเคราะห์ตอนท้ายเหมือนเดิม
ผลลัพธ์ช้ากว่าแต่คุณภาพใกล้เคียงกัน และบอกผู้ใช้ตรง ๆ ว่ากำลังใช้โหมดเรียงคิว
