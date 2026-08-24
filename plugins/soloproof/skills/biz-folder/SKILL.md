---
name: biz-folder
description: >
  Operate a one-person-business folder system (root: ~/biz) — set up the
  structure, file _inbox items into place, decide where any business file
  belongs, and migrate scattered or finished work into _archive. Use this
  skill WHENEVER the user mentions organizing business files or folders,
  "เก็บ inbox", "เก็บของเข้าที่", "จัดไฟล์", "จัดโฟลเดอร์", "ไฟล์นี้ไว้ไหน",
  "ย้ายเข้า archive", "migrate ไฟล์", "สร้างโปรเจกต์ใหม่", "setup ~/biz",
  or hands over files/documents and asks where to put them — even if they
  never say "biz" or "folder". ALSO consult it before saving any business
  deliverable (draft, invoice, research, script) to disk, so outputs land in
  the right place with the right name instead of wherever is convenient.
---

# biz-folder — ระบบโฟลเดอร์ธุรกิจคนเดียว (ฉบับผู้เรียน SOLO PROOF)

One person + AI runs this business, so the folder system is designed for
**retrieval by AI**, not for a human browsing: predictable names, shallow
depth, and written-down rules that any Claude session can enforce without
being told. Your job when this skill triggers is to keep the system true to
itself — every file in a place a future session would *guess* on the first
try.

The root is `~/biz` (ผู้เรียน SOLO PROOF ใช้โฟลเดอร์ `solo-proof` จาก Track 0 เป็นจุดเริ่มได้ แล้วโตเป็น `~/biz` เมื่อพร้อม) unless the user names a different path (tests and other
machines may use one — always honor an explicit path over the default).

## The canonical tree

```
biz/
├── CLAUDE.md            # the business's operating manual — read it FIRST, every time
├── _inbox/              # everything new lands here; nothing lives here long-term
├── 1-content/
│   ├── reels/           # EP-###-slug/ per episode (raw, subs, final) — reels-pipeline owns this
│   └── website/         # ร่าง guide/บทความ ก่อนเอาขึ้นเว็บของคุณ
├── 2-products/          # one product = one folder (courses, skill packs, templates)
├── 3-marketing/         # offers, keyword research, AAR notes, funnel docs
├── 4-admin/
│   └── finance/<YYYY>/  # invoices, receipts, tax, accountant exchanges — by year
├── templates/           # reusable briefs, script skeletons, standard docs
└── _archive/            # finished or dead work, moved wholesale; pre-2026/ holds the old-world dump
```

Code repositories (e.g. `reels-studio`) live under `~/dev`, NOT here.
The Obsidian vault is a separate personal knowledge layer — don't merge it
in. CLAUDE.md points to both.

## Ground rules

**Read `biz/CLAUDE.md` before touching anything.** It is the live source of
truth and may have drifted ahead of this skill (new folders, new rules). If
what you find on disk disagrees with CLAUDE.md, flag it; if CLAUDE.md
disagrees with this skill, CLAUDE.md wins — then offer to update it or this
skill so they agree again.

**Naming.** kebab-case, no spaces, ASCII filenames (Thai belongs inside
files, not in their names — it greps and globs far more reliably). Dates are
`YYYY-MM-DD` and go at the front of dated files (`2026-08-03-invoice-acme.pdf`).
Episodes are `EP-###`. Max ~3 levels deep below the root — if you feel the
need for a 4th level, the folder is probably trying to become a project of
its own.

**Never delete, never overwrite.** Wrong-place files get *moved*; dead work
goes to `_archive/`, not to trash. If a move would overwrite an existing
file, suffix the incoming one (`-2`) and mention it. On the device bridge
`rm` is impossible anyway — and genuinely unwanted files go to
`_to_delete/` for the user to empty themselves.

**Propose before moving.** Present a mapping table (current path → new path,
one line of reasoning) and get a yes before executing. When running
unattended or the user has said "just do it": move the unambiguous items,
state the assumptions you acted on, and leave anything genuinely ambiguous
in `_inbox/` with a `_needs-decision.md` note explaining the options —
a wrong guess filed confidently is worse than an honest leftover.

**Every active project folder carries a `notes.md`** — current status,
decisions made, what's pending — so any future session resumes without chat
history. When your work changes a project's state, update its `notes.md`
before you finish.

## Workflow A — First-time setup

1. Create the tree above (empty folders are fine; add `finance/<current year>/`).
2. Write `CLAUDE.md` at the root from `assets/CLAUDE-md-template.md`,
   filling in today's date and anything the user has customized.
3. Confirm what exists back to the user as a short tree, and tell them the
   one habit that keeps the system alive: new stuff goes in `_inbox/`,
   filing happens on request ("เก็บ inbox เข้าที่").

Setup is idempotent — if part of the tree already exists, create only the
missing pieces and never disturb existing content.

## Workflow B — Filing the inbox ("เก็บ inbox เข้าที่")

1. Read `CLAUDE.md`, then list `_inbox/` (and only `_inbox/`).
2. Classify each item by what it IS, not by its extension:
   - phone video / raw footage → `1-content/reels/` — but hand actual
     processing to the **reels-pipeline** skill; here you only park and name
   - guide/article drafts → `1-content/website/`
   - anything about a sellable product → that product's folder in `2-products/`
   - research, hooks, AAR, offer docs → `3-marketing/`
   - invoices, receipts, accountant files → `4-admin/finance/<year>/`
   - reusable skeletons → `templates/`
3. Normalize names to the rules while moving (record renames in the table).
4. Present the mapping table → on approval, move → report what moved and
   what stayed (and why it stayed).

An empty inbox is the success state. If the same *kind* of ambiguity keeps
recurring across sessions (per `_needs-decision.md` history), suggest a new
rule for CLAUDE.md instead of asking the same question forever.

## Workflow C — Migration & archive

For scattered pre-system files (Desktop, Downloads, old project folders),
the strategy is **move the living, entomb the rest** — do NOT sort history:

1. Scan the locations the user names. Split by a simple pulse check:
   modified in the last ~3 months or clearly part of an active project →
   *living*; everything else → *dead*.
2. Living files: map into the tree (Workflow B rules) — mapping table,
   approval, move.
3. Dead files: move **wholesale, unsorted** into `_archive/pre-2026/`
   keeping their original folder shapes. Resist the urge to organize them;
   they remain greppable, and "จัดตอนใช้" beats "จัดเผื่อใช้" every time.
4. Report counts (moved where, archived how many) and anything skipped.

The same workflow retires finished projects later: the whole project folder
moves into `_archive/<year>/` — never partial contents — with its `notes.md`
still inside telling future-you how it ended.

## Environment notes

- **Cowork cloud session + device bridge**: list with `device_list_dir`,
  move with `device_bash` `mv` (works; `rm` does not). Big batches: write
  one shell script of `mv` commands and run it in a single `device_bash`
  call rather than one call per file.
- **On-computer session / plain shell**: ordinary `mkdir -p` and `mv`.
- Either way: `mv`, never copy-then-delete, and never touch files outside
  the folders the user put in scope.
