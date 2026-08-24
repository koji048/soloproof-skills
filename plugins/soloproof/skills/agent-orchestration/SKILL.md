---
name: agent-orchestration
description: Pick and execute the right subagent orchestration pattern for a task — routing, fan-out/sectioning, orchestrator-worker, isolated voting, verifier-gated best-of-N, judge panels, evaluator-optimizer loops, blackboard state, partitioned parallel writes — and refuse to fan out when a single agent would do better. Use this skill whenever a task is big or multi-part enough that spinning subagents is on the table, whenever the user says "spin subagents", "fan out", "run agents in parallel", "use a panel", "orchestrate this", "หลาย agent", "แตก agent", "ขนานกัน", "ให้หลายตัวช่วยดู", or asks which orchestration pattern to use — and also when the user just hands over a broad research, audit, review, comparison, or multi-file task without mentioning agents at all, since choosing the topology is exactly the decision they're implicitly delegating. Trigger even for tasks that turn out NOT to need subagents; deciding not to fan out is a result this skill produces.
---

# Agent Orchestration

Choosing how to wire subagents matters more than how many you spawn. The
evidence is lopsided: fanning out on **read-heavy, decomposable** work beats a
single agent by a wide margin, while fanning out on **sequentially dependent or
write-heavy** work loses badly — often worse than never having split at all.
This skill makes that choice deliberately instead of by reflex.

Two things this skill is trying to prevent, in order of how often they happen:

1. **Reflexive fan-out.** Delegation is the salient action, so models over-delegate.
   Splitting work that a single agent handles fine costs ~15× the tokens and
   *reduces* accuracy, because every agent boundary is a lossy channel.
2. **Right instinct, wrong topology.** Reaching for a debate when isolated voting
   is cheaper and more accurate; using one judge when a 3-model jury costs an
   eighth and correlates better with humans; running a critic loop with no
   external verifier, which degrades the answer every round.

## How to run this

The router is a decision procedure you run **inline** — do not spawn an agent to
choose the pattern. A classifier subagent would add an agent boundary before any
work starts, and boundaries destroy information; the routing decision needs the
full task context, which is exactly what a handoff strips. The *execution* stage
spawns real subagents. Route in your own head, then fan out for real.

Work through the gates in order. Stop at the first one that fires.

---

## Gate 0 — Should this be subagents at all?

Answer yes to any of these and the answer is **one agent, one thread**. Say so
and move on; this is a legitimate outcome, not a failure to orchestrate.

- Subtasks depend on each other in sequence — a later step needs state an
  earlier step changes.
- Every subagent would need substantially the **same context** to do its job.
- The work is **deep and narrow** (writing code, long-form prose, refactoring)
  rather than **wide and shallow**. Coherence across the whole artifact is the
  thing being produced, and coherence does not survive being split.
- Two or more agents would **write to the same file or artifact**.
- The subtasks depend on shared conventions — naming, style, interfaces,
  architecture — that are not written down anywhere yet.
- The extra agent would contribute **no new information**: it rephrases,
  relays, or re-reviews what an upstream agent already produced.
- The task is small enough that the orchestration overhead exceeds the work.

A useful sanity check when you are unsure: if a competent single agent would
already get this roughly right most of the time, splitting it usually makes it
worse, not better. The gains from fanning out come from covering ground one
context cannot hold — not from making an already-solvable task more correct.

## Gate 1 — What kind of job is it?

Classify by **what the task produces**, not by how it is phrased. Most
mis-routing comes from classifying on surface features ("they said compare, so
panel") instead of on the output.

| The task produces… | Family | Patterns | Read |
|---|---|---|---|
| Findings, evidence, a map of something — the output is *knowledge* | **GATHER** | 1 Routing · 2 Fan-out · 3 Orchestrator–Worker · 4 Blackboard | `references/gather.md` |
| One selected answer, ranking, score, or verdict — the output is a *choice* | **DECIDE** | 5 Isolated Voting · 6 Verifier Gate · 7 Judgement Panel | `references/decide.md` |
| A file, document, codebase change — the output is an *artifact* | **PRODUCE** | 8 Single Thread · 9 Partition Writing · 10 Chaining · 11 Hierarchical | `references/produce.md` |
| A better version of something that already exists, iterated to a bar | **IMPROVE** | 12 Evaluator–Optimizer · 13 Self-Review Loop (trap) | `references/improve.md` |

The numbers are stable identifiers — always name a pattern as `<N>. <Name>` when
you recommend it, never by paraphrase. A reader who has seen the taxonomy once
can then look any recommendation straight back up, and "use 5. Isolated Voting"
survives being quoted out of context in a way that "just sample it a few times"
does not. The four avoid-patterns are deliberately unnumbered; see
`references/avoid.md`.

Mixed tasks are common and decompose cleanly: "research the options and write
the migration plan" is GATHER then PRODUCE. Run them as separate phases with a
synthesis point between — never as one blended fan-out, because the phases have
opposite parallelism rules.

If the user has explicitly named a pattern you believe is wrong for the job
(debate, mixture-of-agents, and free-form agent swarms are the usual ones),
read `references/avoid.md` before pushing back so the objection is specific
about what to use instead rather than a flat refusal.

## Gate 2 — Read the family file and pick the pattern

Each family file contains the sub-decision, the exact shape of the fan-out, and
worked prompt skeletons. Read only the one you need — that is why they are
separate files.

`references/evidence.md` holds the empirical backing for every routing rule
here. Read it when the user asks why a pattern was chosen or challenges a
recommendation; do not load it as part of normal routing.

---

## Writing the subagent prompts

Task-description quality dominates topology quality — optimized prompts on a
mediocre topology beat a clever topology with vague prompts. This is the
highest-leverage part of the whole skill, so do not rush it.

Every subagent prompt carries five things. Missing any one of them maps to a
failure mode that shows up in real traces at double-digit rates:

**1. One objective, stated narrowly enough to be unambiguous.**
"Research the semiconductor shortage" is thin enough that two agents given it
will produce overlapping, unusable work. "Find supply-chain causes of the
2024–2026 semiconductor shortage, fab-capacity side only" is a task.

**2. An output contract.** Specify the shape — ideally a schema. Structured
returns let you merge results deterministically instead of spending orchestrator
context re-reading prose. Where the harness supports schema-forced output, use
it; the validation happens below the model, so mismatches get retried for free.

**3. Explicit boundaries, including what not to touch.** Without them, parallel
agents duplicate each other's work — the single most common failure in
multi-agent traces. Say which files, which sources, which scope, and name the
adjacent thing they should leave alone.

**4. A stopping condition.** Without one, agents keep "improving" finished work
until the budget runs out. Make it checkable: tests pass, N sources found,
every row populated.

**5. Mandatory evidence.** Require `file:line`, a URL plus the quoted sentence,
or a command's actual output. Subagents left unconstrained will infer from
filenames and variable names and report it with full confidence — asking for
citations is what makes that visible instead of invisible.

Two rules about what crosses the boundary:

- **Send paths, not contents.** The point of a subagent is that its reading
  happens in someone else's context. Pasting file contents into the prompt pays
  the token cost twice and defeats the split.
- **Ask for distillations, never raw dumps.** If a subagent's output is about
  as large as its input, the split accomplished nothing. "Return the full
  contents of what you found" is the anti-pattern; the orchestrator can read
  targeted files itself if it truly needs them.

## Fan-in

Synthesis happens **once, in one agent, in one call**. This is the one stage
that must not be parallelized: it is the only place the full picture exists, and
splitting it produces exactly the incoherence the fan-out was supposed to avoid.

Do the mechanical work — dedupe, filter, sort, merge — in plain code or in your
own reasoning before synthesis, not by spawning another agent for it. An agent
that only reorganizes upstream output adds a lossy boundary and no information.

When results conflict, say so in the output rather than averaging them.
Averaging an expert view with a non-expert view is a documented way to end up
worse than either.

## Report the decision

After routing, tell the user what you picked in about three lines, before or
alongside the work:

```
Pattern: <N>. <Name> · <count> agents · <read-only | partitioned writes>
Why: <the gate that decided it, in one clause>
Instead of: <the pattern someone would reach for reflexively, and why not>
```

This exists so the user can override you cheaply. They often know something
about the task's structure that is not visible from the prompt, and a one-line
disagreement is much cheaper than a wrong fan-out that runs to completion.

## Scale

Returns from parallel agents flatten somewhere around 8–16 units without a
strong verifier in the loop, and coordination overhead starts dominating past
about 5 agents when they share state. Start at the low end. If a round comes
back thin, run another round — that is cheaper and more controllable than
opening with twenty agents.

If you bound coverage in any way — top-N only, no retries, sampled instead of
exhaustive — say so explicitly in the output. Silent truncation reads to the
user as complete coverage, which is worse than admitting the limit.

## หมายเหตุฉบับผู้เรียน SOLO PROOF — เมื่อรัน subagent ไม่ได้

skill นี้ออกแบบให้ใช้หลาย agent ช่วยกัน ถ้าสภาพแวดล้อมของคุณไม่มีเครื่องมือ spawn agent
(เช่น ใช้แชท Claude ธรรมดา ไม่ใช่ Cowork/Claude Code) **อย่ายกเลิกงาน** — ให้ทำแบบเรียงคิวแทน:
เล่นทีละบทบาทในแชทเดียว จบบทบาทหนึ่งค่อยขึ้นบทบาทถัดไป แล้วสังเคราะห์ตอนท้ายเหมือนเดิม
ผลลัพธ์ช้ากว่าแต่คุณภาพใกล้เคียงกัน และบอกผู้ใช้ตรง ๆ ว่ากำลังใช้โหมดเรียงคิว
