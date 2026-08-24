---
name: strength-interview
description: Interview a solo business owner to surface 10-15 concrete, evidence-backed strengths they can actually sell — by asking for real incidents instead of self-assessment. Use this skill whenever the user asks to be interviewed about themselves, asks what they are good at, what they should sell, what makes them different, or says "สัมภาษณ์ฉัน", "ขุดจุดแข็ง", "ฉันเก่งอะไร", "ฉันทำอะไรได้ดีกว่าคนอื่น", "ไม่รู้จะขายอะไร", "หาจุดต่าง" — even if they only say "ช่วยหาจุดแข็งให้หน่อย". Also use before any exercise that requires the user to pick what to sell.
---

# Strength Interview (หลักฐาน ไม่ใช่คำชม)

Purpose: produce a list of 10–15 strengths where **every single item points to a real incident** the user can retell. This list is raw material for deciding what to sell — an adjective cannot be sold, an incident can.

Core principle: **คนตอบคำถาม "คุณเก่งอะไร" ไม่ได้.** Ask about traits and you get "ขยัน / ละเอียด / ชอบช่วยคน" — true, useless, and identical for everyone. Ask about incidents and the same person produces something no one else could have said.

## Hard rules — violating any of these fails the interview

1. **ถามทีละคำถามเสมอ** — one question, wait for the answer, then decide the next one. Never send a numbered list of questions.
2. **ห้ามชม** — no "เยี่ยมมาก", no "นั่นคือจุดแข็งที่ดีมาก". Praise turns the interview into a comfort session and the user starts performing instead of remembering.
3. **ห้ามสรุประหว่างทาง** — do not say "แสดงว่าคุณเก่งเรื่อง X" until the end. Naming a strength early makes the user agree with your frame and stop digging.
4. **ห้ามถามเรื่องนิสัย** — never ask "คุณเป็นคนแบบไหน" or "คุณถนัดอะไร". Ask "เล่าครั้งล่าสุดที่…" instead.
5. **อย่าหยุดเร็ว** — the useful material almost never appears in the first 8 answers. Keep going until the minimum bar in Step 4 is met.

## Workflow

### Step 1 — Set expectations, then start immediately
Tell the user in one or two lines: this takes ~30 minutes, you will be asked one question at a time, answer with events not summaries, and short honest answers beat polished ones. Then ask the first question. Do not wait for permission.

Open with the **outside-evidence track** (below) — it is the easiest to answer truthfully and warms up recall.

### Step 2 — Rotate through four tracks
Draw questions from `references/question-bank.md`. Cover all four; do not stay in one.

| Track | What it surfaces | Opening probe |
|---|---|---|
| หลักฐานจากคนอื่น | Strengths visible to others but invisible to self | "ช่วงปีที่ผ่านมา คนมักทักมาถามคุณเรื่องอะไร" |
| เรื่องที่แก้ได้คนเดียว | Rare capability | "เล่าเรื่องที่คุณแก้ได้ แต่คนรอบตัวแก้ไม่ได้" |
| เรื่องที่คุณทำแล้วง่าย คนอื่นทำแล้วยาก | Unnoticed advantage | "มีอะไรที่คุณทำจนชิน แต่เห็นคนอื่นทำแล้วดูลำบาก" |
| เรื่องที่พลาด | Hard-won knowledge, usually the strongest item | "เคยลงแรงกับอะไรแล้วไม่สำเร็จ แล้วได้รู้อะไรจากรอบนั้น" |

### Step 3 — Ladder on every answer before moving on
When you get an answer, **do not go to the next track**. Dig 2–3 levels first:

- ขอเหตุการณ์ให้ชี้ตัวได้ — "ครั้งล่าสุดคือเมื่อไหร่ ใครเกี่ยวข้องบ้าง"
- ขอตัวเลข — "ใช้เวลาเท่าไหร่ กี่ครั้ง ผลออกมาเท่าไหร่"
- หาส่วนที่คนอื่นทำไม่ได้ — "ตรงไหนที่คุณคิดว่าคนอื่นทำแทนไม่ได้"

Stop laddering when you have an incident with a time, a specific detail, and something countable. Then move to another track.

### Step 4 — Minimum bar before summarizing
Do not produce the list until you have **at least 12 distinct incidents**, with **all four tracks represented** and **at least one failure**. If the user tries to stop early, say plainly how many you have and what is still missing, then offer to continue or to summarize with the gap noted.

### Step 5 — Write the list, then filter it
Produce 10–15 items. **Every item must name what happened, not what the user is like.**

Then run each item through this test and delete or rewrite anything that fails:

| Test | Fails |
|---|---|
| จะเขียนแบบนี้ในเรซูเม่ใครก็ได้ไหม | "ละเอียดรอบคอบ" · "ชอบเรียนรู้" |
| มีเหตุการณ์รองรับไหม | "เข้าใจลูกค้าดี" (ไม่มีเรื่องประกอบ) |
| มีอะไรวัดได้ไหม | "ทำคลิปเก่ง" → "ตัดคลิปเองมา 2 ปี รู้ว่าขั้นไหนกินเวลาที่สุด" |

State how many items were cut and why. A shorter honest list beats a padded one.

### Step 6 — Save the file
Write the result as a markdown file in the user's working folder — do not leave it only in the chat. Filename: `จุดแข็ง-<ชื่อโปรเจกต์>.md`. Include the raw incidents below the list so the user can reread the source later.

## Output format

```
# จุดแข็งของ <ชื่อ> — <วันที่>

1. <สิ่งที่ทำได้> — <เหตุการณ์จริงที่รองรับ ในบรรทัดเดียว>
...

## เรื่องที่เล่าไว้ระหว่างสัมภาษณ์
- <incident ดิบ ไว้กลับมาอ่าน>
```

## When the user is stuck

- "นึกไม่ออกเลย" → drop to last week: "เจ็ดวันที่ผ่านมาทำอะไรไปบ้าง" then ladder from whatever they list.
- "รู้สึกเหมือนคุยโม้" → say once that this is a stock-check, not a pitch, and no one else reads it. Do not repeat the reassurance.
- "ก็แค่เรื่องธรรมดา" → this is the highest-value signal. What feels ordinary to them is usually the thing others cannot do. Ladder harder here.
