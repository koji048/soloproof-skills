# IMPROVE — the output is a better version of something

One question decides this family, and getting it wrong is the single most
expensive mistake in this skill:

**Where does the feedback come from — outside the model, or inside it?**

Iteration driven by an external signal is one of the strongest patterns
available. Iteration driven by a model's own opinion of its work reliably makes
the work *worse*, round over round, while feeling productive the whole time.

| | Pattern |
|---|---|
| A test, compiler, linter, schema, or API says pass/fail | **12. Evaluator–Optimizer** |
| A human or the user says what is wrong | **12. Evaluator–Optimizer** (they are the evaluator) |
| Only "have another look at it" | **13. Self-Review Loop** — the trap; do not build it |

---

## 12. Evaluator–Optimizer (with a real signal)

Generate, evaluate, feed the *actual* failure back, regenerate.

Use when: the domain hands you a verdict — tests, a build, a schema validation,
a type checker, an API rejection, a numeric target, a human reviewer.

Shape:

```
loop (bounded, 3-5 rounds):
  produce candidate
  run the real evaluator
  pass -> done
  fail -> feed the evaluator's *verbatim output* back in, regenerate
```

Two things that determine whether this works:

- **Pass the raw error text.** Not a summary of it, not your interpretation of
  it. The exact compiler message, the failing assertion, the user's actual
  words. The specificity of the signal is what makes the next attempt better,
  and summarizing is where that specificity dies.
- **Bound the loop and report where it stopped.** If it has not converged in
  three to five rounds, more rounds will not fix it — the task specification is
  wrong, and the honest output is the best candidate plus a clear statement of
  what is still failing.

An unhelpful variation to avoid: running the evaluator as an agent that merely
*reads* the code and opines. If the tests exist, run the tests. A model reading
code and a model writing code share the same blind spots, so this only appears
to add a check.

---

## 13. Self-Review Loop — the trap

Asking the model to review and revise its own work with **no external signal**.
It carries a number because it is the most common thing people actually build in
this family, and a named anti-pattern is one you can catch yourself reaching
for — an unnamed one just feels like diligence.

Do not build it. This is the finding that surprises people most, so it is
worth being precise about it: self-review degrades performance measurably —
strong models lose several points on reasoning tasks by going over their answer
again, and some tasks collapse much further. The mechanism is straightforward: the model has no new information on
round two, so revision is driven by a bias toward finding *something* to change.
And once its own earlier output is in context, later reasoning gets anchored to
it, so errors get reinforced rather than caught.

What to do instead, in order of preference:

1. **Find a real signal.** Very often one exists and was not being used — run
   the code, validate the schema, check the arithmetic in a script, look the
   fact up. Even a partial checker beats introspection.
2. **Generate fresh in parallel, then choose.** Sample several *independent*
   attempts that cannot see each other, and pick with a verifier or a judge
   panel — **5. Isolated Voting** or **6. Verifier Gate** (see `decide.md`).
   Independent samples explore genuinely different
   solutions; sequential revisions of one answer tend to be near-copies of each
   other, which is why re-drafting explores so much less than re-sampling.
3. **Use a genuinely different lens.** A critic given a *specific, different*
   question ("does this satisfy the constraint stated in the brief?", "what would
   a security reviewer object to?") contributes something. A critic asked
   "is this good?" does not.
4. **Ask the user.** For subjective work, the user is the only real evaluator,
   and one round with them beats five rounds of self-review.

---

## Prompt skeletons

**Optimizer round n:**

```
Your previous attempt is at <path>. It failed:

<verbatim evaluator output — full error text, unedited>

Fix that specific failure. Do not restructure anything that was already passing.
Return the corrected artifact and a one-line note on what the cause was.
```

**A critic that actually adds something** — note that it is given a specific
question and forbidden from generic praise:

```
Check <artifact> against exactly this: <one specific, checkable criterion>.

Return JSON: { violations: [{location, what_is_wrong, why_it_matters}] }
If it satisfies the criterion, return an empty array. Do not report style
preferences, and do not report anything you cannot point to a specific location for.
```

The empty-array instruction matters more than it looks: without an explicit,
legitimate way to say "nothing wrong here", a critic will manufacture findings,
and manufactured findings are how self-review makes things worse.
