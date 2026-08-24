# Evidence behind the routing rules

Read this when a recommendation is challenged, when the user asks why, or when
you need to weigh a case the decision tree does not cleanly cover. It is not
part of normal routing.

Everything here was current as of mid-2026. Numbers move; the structural
findings have held up across independent replications, which is why the routing
rules lean on those rather than on any single headline figure.

---

## The three findings that drive the whole skill

**1. Read parallelizes, write does not.**
An orchestrator–worker research system measured ~90% better than a single strong
agent on breadth-first research. A controlled study holding prompts, tools, and
token budgets constant across 180 experiments found multi-agent up to +81% on
parallel tasks (financial analysis) and **−39% to −70% on sequentially dependent
tasks** (planning). Same architecture, opposite sign, decided by task structure.

The mechanism is asymmetry of consequence: a wrong *finding* is reconcilable at
synthesis, a wrong *commitment* corrupts the artifact and has to be merged with
its incompatible sibling.

**2. There is a capability threshold.**
Once a single agent already solves more than roughly 45% of a task correctly,
multi-agent coordination shows negative expected returns. That threshold
predicted the sign of the effect in about 94% of held-out configurations. As
models improve, the region where fanning out helps gets *narrower*, not wider.

**3. Coordination costs are not marginal.**
Multi-agent systems run around 15× the tokens of a single chat interaction. Tool
schemas alone cost 10k–60k tokens **per agent** before any work happens. Latency
is the p99 of your slowest agent, not the average. In production systems,
coordination overhead tends to dominate past about five agents that share state.

---

## Why isolated voting beats debate

| Comparison | Result |
|---|---|
| GSM8K at matched call count | self-consistency @6 = 85.3% · debate @6 = 83.2% |
| Standardized re-eval, 5 debate frameworks × 9 benchmarks × 4 models | debate beat plain chain-of-thought in ~14% of scenarios; lost in ~42% |
| Token budget matched | voting converts extra tokens into accuracy monotonically; debate flatlines |
| Theory | debate is a martingale — expected correctness unchanged; majority voting improves exponentially in n |
| Conformity rate | agents adopt the majority answer at rates up to ~85% once they see peers |
| Cost | debate 15–100× vs voting n× on output only |

Debate's benefit decays with base model capability (measurable on 1.5B models,
approximately zero by 32B) while its harms do not. A separate consistent finding:
plurality voting sometimes discards a correct answer that was already in the
candidate pool — gaps up to ~32 points — which argues for verifier-based
selection over voting wherever a verifier exists.

---

## Why self-review without an external signal fails

Intrinsic self-correction degrades monotonically:

| Model | 1 call | after 2 rounds |
|---|---|---|
| GPT-4 / GSM8K | 95.5% | 89.0% |
| GPT-4 / HotpotQA | 49.0% | 43.0% |
| GPT-3.5 / CommonSenseQA | 75.8% | 41.8% |

Earlier positive results generally used an oracle label to decide when to stop
revising — which is not self-correction, it is verifier-gated revision, and that
does work.

A separate result explains why re-drafting explores so little: sequential
revision exhibits "laziness" — near-identical solutions across iterations,
driven by induction heads copying prior output. Parallel sampling outperforms
sequential refinement even though sequential has strictly more representational
power, because independent samples actually explore.

What does work: tool-grounded critique, trained critics, RL-trained
self-correction, and any real external checker.

---

## Why juries beat single judges

A three-model panel from disjoint families beat a single large judge on
agreement with humans (Cohen's κ: 0.76 vs 0.63 on single-hop QA; 0.91 vs 0.84 on
TriviaQA) at roughly **one eighth** the cost.

Judge biases, quantified:

- **Position:** ~1 verdict in 5 flips on reordering, for frontier judges.
  Repetition stability is 0.96–1.00, so this is systematic, not noise. It is
  worst exactly when candidates are close in quality.
- **Self-preference:** models score their own generations higher, and this
  correlates causally with their ability to recognize their own output.
- **Verbosity/style:** a null model emitting a fixed, instruction-irrelevant
  response reached 86.5% win rate on a major automated benchmark — including its
  length-controlled variant.

The load-bearing conclusion: a panel dilutes *idiosyncratic* bias but cannot
remove bias shared across frontier models. Rubrics and program-checkable
sub-criteria are what actually help.

---

## Why mixing models loses

Self-MoA — sampling the single best model repeatedly instead of mixing families —
beat mixed configurations by +6.6 points on a leading open-ended benchmark and
+3.8% average across reasoning benchmarks. On a math benchmark, *every* mixed
configuration scored below the best single model used alone; aggregation could
not recover what mixing destroyed.

Aggregation quality tracks candidate quality far more strongly than candidate
diversity, so adding a weaker model usually costs more than the diversity gains.

---

## Failure mode frequencies

From ~1,600 annotated multi-agent traces across seven frameworks (κ = 0.88
inter-annotator agreement). Observed failure rates for the systems studied ran
41%–87%.

| Failure | Share | The prompt element that prevents it |
|---|---|---|
| Step repetition / duplicated work | 17.1% | explicit non-overlapping boundaries |
| Reasoning–action mismatch | 14.0% | mandatory evidence citations |
| Proceeding on wrong assumptions | 11.7% | detailed task description + a place to record gaps |
| Ignoring stated task requirements | 11.0% | machine-checkable success criteria |
| No stopping condition | 9.8% | explicit done-condition |
| Premature termination | 7.8% | barrier before synthesis |
| Task derailment | 7.2% | narrow objective, named scope |

Categories: specification issues ~42%, inter-agent misalignment ~37%, weak
verification ~21%. Roughly four fifths of failures are specification and
coordination — not model capability. That is why prompt contracts get more space
in this skill than topology does, and it is consistent with a separate finding
that optimizing prompts beats optimizing topology.

Targeted fixes helped but did not close the gap: better verification bought
about +16 points of task success, better role specification about +9.

---

## Error compounding and topology

End-to-end success = per-step reliability ^ number of steps.

| Chain length | @95%/step | @99%/step |
|---|---|---|
| 3 | 85.7% | 97.0% |
| 5 | 77.4% | 95.1% |
| 10 | 59.9% | 90.4% |
| 20 | 35.8% | ~82% |

One retry per step at 95% lifts that step to ~99.75%, taking a five-stage
pipeline from 77% to ~99%. Retries are the cheapest reliability intervention
available, which is why the chaining pattern insists on gates.

Error amplification by topology, relative to a single agent: independent/mesh
~17×, decentralized ~8×, hybrid ~5×, **centralized with supervised aggregation
~4×**. Architectures with a verification step achieved ~23% mean error
*reduction*; those without amplified errors. Verification bottlenecks, not agent
count, are what make multi-agent systems work.

---

## Where returns flatten

Independent lines of work converge on roughly **8–16 effective parallel units**
before returns go flat without a strong verifier: voting saturates around 10,
collaborative scaling laws inflect near 16, iterative methods plateau after ~5
rounds, and resampling against an imperfect verifier often stops paying under 10
attempts.

---

## Two counter-considerations worth holding

**Decomposition helps on noisy input.** Where context was degraded — masked,
noisy, or adversarial — multi-agent became competitive again, because structured
decomposition filters corruption that would derail a single trajectory. If the
input is unreliable rather than merely large, that is a genuine argument for
fanning out.

**Simple fixed pipelines often beat agentic systems entirely.** On a
software-engineering benchmark, a fixed three-phase pipeline with no tool use
and no agentic decision-making beat agent frameworks by ~14 points at 28% of the
cost. Before choosing between orchestration patterns, it is worth asking whether
the task needs *any* agentic decision-making, or just a well-designed pipeline.
