# DECIDE — the output is a choice

One question splits this family, and it is the highest-leverage question in the
whole skill:

**Can something other than an LLM's opinion tell you the answer is right?**

| | Pattern |
|---|---|
| There is one right answer and you can check agreement | **5. Isolated Voting** |
| A real verifier exists — tests, compiler, schema, arithmetic, an API | **6. Verifier Gate** |
| Quality is a judgment call with no ground truth | **7. Judgement Panel** |

All three generate several candidates. They differ only in **what does the
selecting** — which is why naming them after the selector, rather than after the
sampling, is what makes the choice obvious:

| Pattern | Selects by |
|---|---|
| **5. Isolated Voting** | candidates agreeing with each other |
| **6. Verifier Gate** | something outside the model saying pass/fail |
| **7. Judgement Panel** | scores against a written rubric |

Note what this framing kills: "how many candidates" is a tuning knob in all
three and never the thing that decides which one you want. The old name
"Best-of-N" put the knob in the title and sent people to argue about N when the
question was always whether a real verifier exists.

The failure mode across all three is the same: letting the candidates see each
other before they commit. Generate in isolation, aggregate at the end.

---

## 5. Isolated Voting

Give the **same** task to n agents that cannot see each other, take the
majority answer.

Use when: the answer is discrete and comparable — a number, a category, a
yes/no, an extracted field, a ranked pick. Also good for decisions where you
want to know whether the answer is *stable*, not just what it is.

Shape:

```
spawn n identical agents (n ≈ 5-10), same prompt, no shared context
tally the answers
report: the winner AND the spread
```

Two things to insist on:

- **Identical prompts, no personas.** Assigning different roles to get "diverse
  perspectives" on a task with one right answer adds noise, not signal. Save
  personas for **7. Judgement Panel**, where the dimensions really are different.
- **Report the spread, not just the winner.** 5/5 agreement and 3/5 agreement
  mean very different things, and the caller usually needs to know which they
  got. A close split is itself the finding: it says the task is underspecified
  or genuinely hard, and that is worth surfacing rather than papering over with
  a confident-sounding majority.

If the split is close, escalate to 6. Verifier Gate if a verifier exists,
or hand the tie back to the user with both candidates. Do not run another round
of voting — correlated models tend to converge on the same wrong answer, so
more votes buy less than they appear to.

Cost: n× output tokens only, latency ≈ 1× since they run concurrently. The best
accuracy-per-token in this file.

---

## 6. Verifier Gate

Generate n candidates, then let something **outside the model** decide.

Use when: the domain has a checker — unit tests, a compiler, a JSON schema, a
linter, a database constraint, recomputed arithmetic, an API that accepts or
rejects. This is the strongest pattern in this document when it applies, because
the verifier is doing work the models cannot do for themselves.

Shape:

```
n candidates, generated independently
run the verifier on each — a real one, not an LLM
keep what passes; if several pass, prefer the simplest
if none pass: feed the verifier's actual error text back and regenerate
```

The verifier must be **executable or deterministic**. The moment you replace it
with "another agent checks the work", you have left this pattern and entered
7. Judgement Panel — with weaker guarantees, because a model checking a model
shares its blind spots.

Do not scale n indefinitely. When the verifier is imperfect, resampling stops
paying off well before you expect — usually under ten attempts. If ten
candidates all fail, the problem is the task specification, not the sample size.

---

## 7. Judgement Panel

Several judges score against an explicit rubric; aggregate their scores.

Use when: the output is open-ended and there is nothing to check against —
writing quality, design options, strategy, "which of these three is better."

Shape:

```
3 judges, ideally different models or genuinely different rubric dimensions
each scores every candidate against a written rubric
present each pair in both orders, or score candidates blind and independently
aggregate; report per-dimension scores, not just a total
```

Four things that materially change the result:

- **Write the rubric first, before seeing the candidates.** A rubric written
  after the fact rationalizes the answer you already liked.
- **Swap positions.** Roughly one verdict in five flips when you reorder the
  candidates, and it flips most exactly when candidates are close — which is
  when you actually needed the judgment. Present both orders and only trust
  verdicts that survive.
- **Three diverse judges beat one big one.** A small panel from different model
  families correlates better with human judgment than a single strong judge, at
  a fraction of the cost. Diversity of *family* is the point; three instances
  of the same model share the same blind spots.
- **Hand any checkable sub-criterion to code.** "Under 500 words", "cites at
  least 3 sources", "every section present" — check these with a script and let
  the judges spend their attention on the parts that need judgment. Decomposing
  a vague quality score into checkable items is what makes this pattern reliable.

Known limits worth stating in the output: judges prefer longer answers, judges
prefer their own model's output, and a panel *dilutes* individual bias but
cannot remove bias that all frontier models share. Treat panel scores as a
ranking signal, not a measurement.

Cost: roughly an eighth of a single large judge for better correlation, which
makes this the best value in the file — but only against a written rubric.
Without one, you are averaging vibes.

---

## Prompt skeletons

**Voting agent** — the point is that this prompt is *identical* across agents:

```
<the task>

Answer with JSON: { answer: <the value>, reasoning: <2-3 sentences> }
Answer independently. Do not hedge across multiple options — commit to one.
```

**Judge** — one per dimension, or one per model family:

```
Score each candidate on <dimension> using this rubric:
  5 = <concrete description>  3 = <concrete>  1 = <concrete>

Candidates are labelled A/B/C in randomized order and you are not told which is
which. Judge only <dimension>; ignore length, formatting, and confidence of tone.

Return JSON: { scores: [{label, score, one_line_justification}] }
```
