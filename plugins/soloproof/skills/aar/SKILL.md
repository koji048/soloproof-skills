---
name: aar
description: >-
  Run an After Action Review (AAR) on any completed piece of work to turn it into a
  reusable lesson. Use this skill whenever the user finishes, posts, or reviews something
  with a result to learn from — a content clip/Reel/EP, a launch, an experiment, a
  campaign, a sales call, a sprint — or says things like "ถอดบทเรียน", "lesson learned",
  "review คลิปนี้", "คราวหน้าทำยังไงดี", "ทำไมมันไม่เวิร์ค", "after action", "retro",
  "post-mortem", "อันนี้ได้ผลไหม". Trigger even when the user doesn't say "AAR" — if they
  just finished a thing and want to know what to change next time, this applies. The output
  is always the 4 AAR questions answered from real evidence, PLUS (for content) an explicit
  "what does the audience get" check, ending in ONE concrete action for next time.
---

# After Action Review (AAR)

## Why this exists

Most reflection dies as a diary entry: "that went okay, moving on." Nothing changes next time
because no *decision* was extracted. The After Action Review — a method the US Army runs after
every mission — fixes this by forcing four questions that end in a change of behavior, not a feeling.

The whole point is the last question. If a review doesn't end with "here is the one thing I will do
differently next time," it failed. Everything before it just exists to make that one change honest
and specific instead of vague ("try harder", "post more").

## The core: four questions, in order

Run these in sequence. Each one feeds the next — don't skip ahead, and don't let the user answer
question 3 or 4 before 1 and 2 are pinned to real facts.

1. **What was supposed to happen?** — the intended outcome, stated *before* you saw the result.
   If the user never set an expectation, that itself is a finding (you can't judge a shot you
   never aimed). Pin a number or a concrete outcome, not a vibe.

2. **What actually happened?** — the real result, in evidence. Numbers, quotes, screenshots,
   observable facts. Resist adjectives. "5,700 views vs 47,000 on the previous one" beats
   "it did worse."

3. **Why was there a difference?** — the honest gap analysis. Push past the first answer, which
   is usually a symptom ("the algorithm"). Ask "and why did that happen?" until you hit something
   *the user controls*. A cause you can't act on is not yet the real cause.

4. **What do we do differently next time?** — ONE specific, testable change. Not a list of five
   good intentions. If the user offers five, make them pick the one with the highest leverage and
   park the rest. The change must be concrete enough that next time you can check whether they
   actually did it.

## The rules that keep an AAR honest

- **Evidence over feelings.** Every claim in questions 1–2 should point at something checkable.
  If the user says "engagement was bad," ask "bad compared to what number?"
- **Blameless, but not toothless.** The goal is a better next attempt, not comfort and not
  self-flagellation. Name what went wrong plainly, then move straight to the fix.
- **Cause must be actionable.** "People weren't interested" is a dead end. "I opened with jargon
  only sellers understand, so viewers bounced in the first second" is a cause you can act on.
- **Exactly one next-time action.** Leverage comes from doing one thing differently and actually
  doing it, not from a wish list nobody executes.

## Content mode (clips, Reels, posts, videos)

When the work under review is a piece of content, add one question the standard military AAR
doesn't have, because for content the result depends entirely on it:

> **What did the audience get to keep?** — After watching, what can the viewer *use, save, or
> repeat*? If the honest answer is "they watched me talk about my situation," that's a diary, and
> diaries don't get saved or shared. The strongest content hands the viewer a tool, a framework, a
> number, or a line they'll repeat.

Check this against the real signal: saves and shares measure "I want this later / others need this,"
which is exactly the takeaway working. Likes and views don't — they measure "I noticed," not "I got
something." So when you have the data, judge the takeaway by saves/shares, not by view count.

Place this question between #3 and #4: once you know *why* it landed or didn't, decide what the
viewer should get next time, then commit to the one change.

## Output format

Keep it short — an AAR that takes longer to read than the work took to do is procrastination in
disguise. Use this shape:

```
## AAR: [what you're reviewing] — [date]

1. ตั้งใจให้เกิดอะไร: [expected outcome, with the number/target set beforehand]
2. เกิดอะไรจริง: [actual result, in evidence]
3. ทำไมมันต่าง: [root cause the user controls — dig past the first answer]
[content only] 3.5 คนดูได้อะไรกลับไป: [what the viewer can use/save/repeat — or "นี่คือปัญหา" if nothing]
4. คราวหน้าทำอะไรต่าง: [ONE specific, checkable change]
```

If the user wants it saved (a build-in-public log, a team retro doc), append a one-line
**Lesson** they could say out loud or put on screen: the compressed "what I learned + what I'll do"
in a single sentence. That line is what makes the lesson portable — it's the thing worth teaching
to someone else.

## A worked example

**Input:** "My Day-3 clip about finding your first customer got 5,700 views. My Day-0 clip about
how I use AI on myself got 47,000. Same series, a few days apart."

**Output:**
```
## AAR: Day-3 clip (หาลูกค้าคนแรก) — [date]

1. ตั้งใจให้เกิดอะไร: คลิปสายขายของ (product journey) น่าจะดึงคนกลุ่มที่จะซื้อจริง ตั้งเป้าเกาะ ~2,000+ วิวเหมือนคลิปก่อนๆ
2. เกิดอะไรจริง: 5,700 วิว (IG) แต่คลิป Day-0 สายพัฒนาตัวเอง = 47,000 — ต่างกัน 8 เท่า, saves ดิ่งจาก 158 → 26
3. ทำไมมันต่าง: ไม่ใช่ "อัลกอริทึม" — คลิป Day-0 แจก prompt คนเอาไปใช้ได้จริง (เลยเซฟ), Day-3 เอาแต่เล่าปัญหาตัวเอง + ใช้ศัพท์คนขาย (offer/painpoint) ที่คนทั่วไปไม่ใช้
3.5 คนดูได้อะไรกลับไป: Day-3 = แทบไม่มี (ดูจบแล้วไม่มีของติดมือ) นี่คือรากปัญหา
4. คราวหน้าทำอะไรต่าง: ทุกคลิปต้องจบด้วยของที่คนดูเอาไปใช้ได้ 1 อย่าง (framework/prompt/checklist) + พูดภาษาคนดู ไม่ใช่ภาษาคนขาย

Lesson: คอนเทนต์ที่ไม่มีของให้คนเอากลับบ้าน = ไดอารี่ — คราวหน้าจบทุกคลิปด้วย takeaway ที่เซฟได้
```

Notice the review didn't stop at "it did worse." It dug to a cause the creator controls (jargon +
no takeaway), then turned it into one testable rule for the next clip.
