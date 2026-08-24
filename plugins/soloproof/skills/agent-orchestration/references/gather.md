# GATHER — the output is knowledge

This is where subagents genuinely earn their cost. Reading parallelizes safely
because findings that conflict are *reconcilable* — a synthesizer can weigh,
discard, or hold both. Nothing downstream is corrupted by one agent reading
badly; you lose that agent's tokens and nothing else.

Pick with one question: **do you know the shape of the work before you start?**

| | Pattern |
|---|---|
| The task has distinct *types* and each goes to exactly one specialist | **1. Routing** |
| You can list the independent pieces up front | **2. Fan-out** |
| You cannot — the pieces depend on what you find | **3. Orchestrator–Worker** |
| Agents need to see each other's progress without seeing each other's context | **4. Blackboard** |

---

## 1. Routing

One cheap classifier reads the task and dispatches it to exactly one downstream
specialist. Not really parallel — it is *selection*. Cheap, well-supported,
and underused.

Use when: incoming work has recognizable categories that want genuinely
different handling — a support queue, a mixed inbox, a triage step, "figure out
which subsystem this bug lives in, then hand it to the right reviewer."

Shape:

```
classify(task) -> one of {A, B, C}
  -> spawn exactly one specialist agent with that specialty's prompt
```

Keep the classifier's output a closed set with an explicit `unknown` branch.
Open-ended classifiers invent categories, and an invented category has no
specialist behind it. Route `unknown` to the most general handler rather than
to whichever specialist scored highest — a confident wrong specialty is worse
than a generalist.

Cost: ~1.1×. If routing is not clearly saving something, drop it and let one
capable agent handle everything.

---

## 2. Fan-out (Sectioning)

Cut the work into **non-overlapping** pieces, run them concurrently, merge once.
The workhorse pattern.

Use when: multiple sources, multiple files, multiple dimensions of the same
review, multiple regions/products/time-periods — anything you can enumerate
before starting.

Shape:

```
sections = [explicit, non-overlapping, enumerated pieces]
results  = spawn one agent per section, all in a single message
synthesis = one agent, one call, over the merged results
```

**Spawn them in one message.** Sequential spawning serializes what should be
concurrent and is the most common way this pattern silently degrades into a
slow chain.

The partition is the whole ballgame. Two failure shapes:

- *Overlapping sections* → agents duplicate work and you pay twice for one
  finding. Fix by naming the boundary explicitly in each prompt, including
  what the neighbouring agent is covering so this one can skip it.
- *Sections that are not actually independent* → agent 3 needed something agent
  1 found. If you spot this while partitioning, you are in 3. Orchestrator–Worker
  territory, or the task belongs in one thread.

Dimensions make better sections than volume does when the material is the same:
reviewing one document for *correctness*, *risk*, and *cost* in parallel gives
three genuinely different reads. Splitting the same document into three page
ranges just gives three agents that each lack context.

Cost: n×, latency ≈ your slowest agent.

---

## 3. Orchestrator–Worker

You decide the decomposition **while working**, spawn workers as the shape
becomes clear, and keep control of when to stop. The pattern behind large
research systems, and the one with the strongest measured win over a single
agent on breadth-first work.

Use when: the task is open-ended enough that you cannot list the pieces in
advance — competitive landscapes, "find everything about X", audits where the
scope emerges from the first pass, investigations.

Shape:

```
round 1: 3-5 broad scouts  -> read results yourself
         decide what is thin, what is missing, what looks wrong
round 2: targeted workers on the gaps
         repeat while rounds keep returning new material
synthesis: one agent, one call
```

Scale effort to the question. A question with one obvious answer gets one
worker; a landscape survey gets five plus a second round. Over-delegating on
simple queries is the characteristic failure here, and it is expensive.

Stop when a round returns nothing new. Two consecutive empty rounds is a solid
termination rule for open-ended discovery — plain counters ("find 10 things")
miss the tail and also keep running past the point of diminishing returns.

Cost: 10–15×. Worth it on genuinely broad work; badly wasted on anything a
single pass would have covered.

---

## 4. Blackboard

Agents coordinate through **shared external state** — a file, a task list, a
directory — instead of through each other's context. Not an alternative to the
patterns above; a mechanism you layer onto them.

Use when: several agents are working long enough that they need to know what
the others have already claimed or found, but passing that through prompts
would bloat everyone's context.

Shape:

```
orchestrator writes: /work/claims.json, /work/findings/
each agent: read claims -> claim a piece -> write findings to its own file
orchestrator: read the directory, synthesize
```

Two properties make this work where message-passing does not: state survives
any individual agent dying, and each agent pays context only for the slice it
reads. It is also the cleanest fix for "the orchestrator's context is
overflowing at merge time" — findings live on disk, and synthesis reads what it
needs.

Give each agent its **own** output file. Shared-file writes race, and the
resulting corruption is silent.

---

## Prompt skeleton

```
Investigate: <one narrow question>

Scope: <exactly what is in bounds>
Out of scope: <what a neighbouring agent is covering — skip it>

Return JSON: { findings: [{ claim, evidence, source, confidence }], gaps: [...] }
Every claim needs a source: URL + the quoted sentence, or file:line.
If you cannot verify something, put it in `gaps` — do not guess into `findings`.

Done when: <N sources / every listed item covered / the question is answered>.
Return a distillation. Do not return raw page or file contents.
```

The `gaps` field earns its place: it converts "the agent found nothing" into a
routable signal for round two, and it gives the agent a legitimate place to put
uncertainty instead of manufacturing a confident finding.
