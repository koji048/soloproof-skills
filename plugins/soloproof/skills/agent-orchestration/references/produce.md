# PRODUCE — the output is an artifact

This is the family where fanning out most often makes things worse. Writing
produces *commitments*, and commitments that conflict cannot be reconciled the
way findings can. Two agents that each made a reasonable unstated choice —
about style, naming, interface shape, structure — produce two halves that do
not fit, and merging them is frequently harder than writing the whole thing
once.

So the default here is **one writer**, and every other pattern needs to earn its
way past that default.

| | Pattern |
|---|---|
| Coherence across the artifact is the point | **8. Single Thread** ← default |
| Genuinely separable deliverables, disjoint files | **9. Partition Writing** |
| Clean stage boundaries with a checkable gate between each | **10. Chaining** |
| Several partitions, each big enough to need its own sub-decomposition | **11. Hierarchical** |

Note what is *not* here: gathering material for the artifact. That is GATHER,
it parallelizes beautifully, and it should be a separate phase that finishes
before writing starts.

---

## 8. Single Thread — the default

One agent, one context, start to finish.

Use when: writing code, prose, a document, a design — anything where the reader
will experience it as one thing. Coherence is not a property you can assemble
from parts; it lives in one context or it does not exist.

It fails on exactly one thing: running out of context. When that happens, the
fix is not to split the writing across agents — it is to move state out of
context. Write decisions and progress to a file, compact, and continue in the
same single thread. Splitting to solve a context problem trades a solvable
problem for an unsolvable one.

---

## 9. Partition Writing

Several agents write concurrently, each owning a disjoint slice.

Only valid when **all** of these hold:

- The partition is by *file or artifact*, not by aspect. "You write the model,
  I write the view" is a partition. "You handle performance, I handle
  readability, in the same file" is a merge conflict with extra steps.
- No two agents can touch the same file. Enforce it mechanically — separate
  worktrees, separate directories, separate output paths — not by asking
  nicely in the prompt.
- **The shared conventions are written down before the fan-out.** This is the
  step people skip and the reason the pattern fails. Interfaces, naming, error
  handling, formatting, the shape of the thing — put it in a spec file that
  every agent reads. Every convention you leave implicit becomes a decision each
  agent makes differently.

Shape:

```
1. write /work/conventions.md — interfaces, naming, style, structure
2. partition by file; assign one owner per file, no overlaps
3. spawn writers, each in an isolated worktree, each reading conventions.md
4. integrate: one agent, reading all the diffs, resolving the seams
5. run the actual build/tests
```

Step 4 is mandatory and is not a formality. Even with a good spec, the seams
between independently written pieces are where the defects live, and only one
agent looking at all of them can see them.

If you find yourself writing "and coordinate with each other" into these
prompts, the partition is wrong. Go back to 8. Single Thread.

---

## 10. Chaining

Stages in sequence, each producing an artifact the next consumes.

Use when: the work has real stage boundaries — outline → draft → edit,
extract → transform → load, spec → implement → test — and you can **check the
output of each stage before the next one starts**.

That check is the entire value. Without it, chaining just compounds error:
five stages at 95% each end up around 77% end-to-end, and the failure is
usually silent, because a misread at stage 2 quietly corrupts everything
downstream while every stage still produces confident, well-formatted output.

Shape:

```
stage 1 -> gate: does it satisfy <checkable condition>?
             pass -> stage 2  |  fail -> retry stage 1 with the failure text
stage 2 -> gate: ...
```

Retrying at each gate is cheap and it is what makes long chains survivable —
one retry per stage takes a five-stage chain from around 77% to near 99%.

Keep chains short. If you are past about five stages, ask whether the middle
ones are doing anything: a stage that reformats or restates upstream output
without adding information is strictly negative — it costs tokens and loses
detail at the handoff.

---

## 11. Hierarchical

An orchestrator of orchestrators: each sub-orchestrator owns a partition and
decomposes it further.

Use when: 9. Partition Writing is right, but individual partitions are
themselves large enough to need their own decomposition. Genuinely rare.

It only works when the partitions are **fully independent deliverables** with
their own acceptance criteria — separate services, separate documents, separate
reports. Every layer adds a lossy boundary and coordination overhead grows
faster than the work does; past roughly five coordinating agents, latency and
reconciliation cost start to dominate.

Before reaching for this, check whether the partitions are independent enough to
just be **separate tasks run separately**. Usually they are, and separate tasks
have none of the coordination cost.

---

## Prompt skeleton — parallel writer

```
You own exactly these files: <explicit list>. Do not create or modify anything else.

Read /work/conventions.md first and follow it exactly. Where it is silent and you
must make a choice, record that choice in /work/decisions/<your-name>.md so the
integration step can see it — do not silently invent a convention.

Build: <what this slice must do>
Done when: <the build/test command> passes.

Return JSON: { files_changed: [...], decisions_made: [...], assumptions: [...],
               blocked_on: [...] }
```

`decisions_made` and `assumptions` are what make the integration step possible.
They convert the implicit choices — the exact thing that breaks parallel writing
— into something the integrator can actually see and reconcile.
