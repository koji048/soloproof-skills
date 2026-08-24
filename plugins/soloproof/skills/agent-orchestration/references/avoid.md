# Patterns to avoid, and what to use instead

These four are deliberately left unnumbered — the numbers are a menu you pick
from, and these are not on the menu. They are popular, intuitive, and poorly
supported. Read this before
declining one so the pushback names a concrete replacement — "debate is
overrated" is not useful to anyone; "isolated voting will be more accurate and
about a fifth the cost, want me to run that?" is.

If the user insists after hearing the alternative, run what they asked for.
They may have context you do not, and this file is a prior, not a rule.

---

## Multi-agent debate

**What it is:** agents see each other's answers and argue across several rounds
until they converge.

**Why it underperforms:** three separate problems compound.

*It cannot add correctness.* There is a formal result here: debate leaves
expected correctness unchanged, while independent majority voting improves
with the number of voters. Debate reshuffles confidence; it does not add
information.

*Agents conform instead of reasoning.* Once an agent sees peers' answers it
adopts the majority at very high rates, abandoning its own reasoning — including
when its own reasoning was right. Correct→incorrect flips outnumber
incorrect→correct in essentially every configuration measured.

*It is sequential and quadratic.* Every round every agent reads every other
agent's full history as input. Debate runs 15–100× the tokens of a single pass;
isolated voting runs n× on output only and finishes in one round.

The one place it holds up: weak base models on tasks where the correct answer
is counter-intuitive. The benefit shrinks as models get stronger and is roughly
zero at current frontier scale — but the conformity cost does not shrink.

**Instead:** 5. Isolated Voting (`decide.md`). Same parallelism, cheaper, better
measured accuracy. If the value you wanted was *adversarial pressure* rather
than consensus, get it from 7. Judgement Panel with genuinely different rubric
dimensions, or from a critic given one specific question — both preserve the
independence that debate destroys.

---

## Mixture-of-Agents / model blending

**What it is:** several different models answer, an aggregator writes a blended
response, sometimes in layers.

**Why it underperforms:** the central claim — that mixing model families helps —
did not survive controlled replication. Sampling the single *best* model
repeatedly and aggregating those beats mixing in weaker models, by a clear
margin. Aggregation is far more sensitive to candidate quality than to candidate
diversity, and adding a weaker model mechanically lowers mean quality.

The deeper issue is *synthetic* aggregation: an LLM writing a blended answer
tends to produce a hedged union of the candidates. That reads well to another
LLM judging it, which is exactly what most of the supporting evidence measured,
and it scores badly wherever an answer is checkably right or wrong.

**Instead:** pick the best model for the task and sample it several times, then
aggregate **selectively** — 5. Isolated Voting, 6. Verifier Gate, or 7. Judgement Panel picking a
winner. Select among candidates; do not blend them.

---

## Free-form swarm / mesh / group chat

**What it is:** no orchestrator; agents hand off to each other as they see fit.

**Why it underperforms:** errors amplify roughly four times faster in mesh
topologies than under centralized coordination, because a wrong output from one
agent becomes trusted input to every agent downstream and nothing in the system
is positioned to catch it. One bad or compromised node can take the whole run
with it. It has largely disappeared from production for this reason.

It is also close to undebuggable. Attribution of which agent caused a failure —
even with good tooling — is poor, and gets worse as traces get longer. Free-form
handoffs produce exactly the long, tangled traces where attribution is worst.

**Instead:** 3. Orchestrator–Worker (`gather.md`). One agent decides, delegates,
and validates every result before it is used. You keep the parallelism and get
a single point where errors can be caught.

---

## Learned topology search

**What it is:** search over graph structures to find the optimal agent wiring
for a task distribution.

**Why it rarely applies:** it buys *cost*, not accuracy — the accuracy gains
over hand-designed pipelines are usually small, sometimes within noise. And the
search itself costs real money per task domain, so it only pays back at high,
stable volume. Several such systems have also been observed quietly collapsing
into single trivial calls on most inputs while still being billed as
multi-agent.

**Instead:** hand-design the pipeline using the families in this skill and
measure it. Revisit only if you are running the same task shape thousands of
times and cost is the binding constraint.

---

## A general note on the evidence

Most published multi-agent results compare a multi-agent system against a
*single call* to the same model — not against the same token budget spent on one
agent. Once budgets are matched, the majority of reported gains shrink, vanish,
or reverse. Multi-agent results also look consistently better on benchmarks
scored by an LLM judge than on benchmarks with checkable answers.

The practical read: be more skeptical of a pattern the more its supporting
evidence relies on LLM-judged open-ended output, and always ask what the same
tokens would have bought on one agent. `evidence.md` has the specific numbers.
