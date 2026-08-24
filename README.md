# soloproof-skills

Skill library ประกอบคอร์ส SOLO PROOF — ติดตั้งครั้งเดียวได้ครบชุด กด update รับของใหม่ได้ตลอด

มี 2 วิธีติดตั้ง เลือกตามเครื่องมือที่ใช้:

| ใช้อะไรอยู่ | วิธีติดตั้ง |
|---|---|
| แอป Claude (Desktop / claude.ai) | **วิธีที่ 1: ดาวน์โหลด zip แล้วอัปโหลด** |
| Claude Code (terminal) | **วิธีที่ 2: ติดตั้งจาก terminal** — ได้ครบ 13 ตัวในคำสั่งเดียว |

---

## วิธีที่ 1 — แอป Claude: ดาวน์โหลด zip แล้วอัปโหลด

1. โหลดไฟล์ zip ของ skill ที่ต้องการจากหน้า **[Releases](https://github.com/koji048/soloproof-skills/releases/latest)** (มีครบทั้ง 13 ตัว แยกไฟล์ให้แล้ว)
2. เปิดแอป Claude → **Settings → Capabilities** → เปิด **Code execution and file creation**
3. ไปที่ **Skills** → กดปุ่ม **+** → **Upload a skill** → เลือกไฟล์ zip
4. ทำซ้ำทีละตัวตามที่ต้องใช้ (ไม่ต้องลงครบทุกตัวก็ได้ — ดูตารางด้านล่างว่าตัวไหนใช้ช่วงไหน)

skill ที่เปิดในแอปจะ sync ลง Claude Code อัตโนมัติด้วย

ลิงก์ตรงรายตัว (คลิกโหลดได้เลย):

| skill | ดาวน์โหลด |
|---|---|
| biz-folder | [biz-folder.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/biz-folder.zip) |
| strength-interview | [strength-interview.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/strength-interview.zip) |
| million-dollar-weekend | [million-dollar-weekend.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/million-dollar-weekend.zip) |
| market-validation | [market-validation.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/market-validation.zip) |
| offer-design | [offer-design.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/offer-design.zip) |
| grand-slam-offer | [grand-slam-offer.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/grand-slam-offer.zip) |
| sales-page-builder | [sales-page-builder.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/sales-page-builder.zip) |
| my-brand-style | [my-brand-style.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/my-brand-style.zip) |
| keyword-hook-research | [keyword-hook-research.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/keyword-hook-research.zip) |
| launch-7-days | [launch-7-days.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/launch-7-days.zip) |
| aar | [aar.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/aar.zip) |
| agent-orchestration | [agent-orchestration.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/agent-orchestration.zip) |
| gauntlet-loop | [gauntlet-loop.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/gauntlet-loop.zip) |

หรือโหลดรวมทุกตัวไฟล์เดียว: [soloproof-all-skills.zip](https://github.com/koji048/soloproof-skills/releases/latest/download/soloproof-all-skills.zip) (แตก zip แล้วอัปโหลดทีละโฟลเดอร์)

---

## วิธีที่ 2 — Claude Code: ติดตั้งจาก terminal

เปิด Claude Code แล้วพิมพ์ 2 บรรทัดนี้:

```
/plugin marketplace add koji048/soloproof-skills
/plugin install soloproof@soloproof-skills
```

เสร็จแล้วพิมพ์ `/reload-plugins` หนึ่งครั้ง แล้วเช็คด้วย `/plugin` — ต้องเห็น skill ครบทั้ง 13 ตัว

รับของเวอร์ชันใหม่ภายหลัง:

```
/plugin marketplace update soloproof-skills
```

---

## skill ทั้ง 13 ตัว — ใช้ช่วงไหนของคอร์ส

| skill | ช่วงที่ใช้ | หน้าที่ |
|---|---|---|
| biz-folder | Track 0.1 | ตั้งโฟลเดอร์ solo-proof / ระบบไฟล์ธุรกิจ |
| strength-interview | Track 0.4-0.5 | ขุดจุดแข็ง+ปัญหาสำหรับคนคิดไม่ออก |
| million-dollar-weekend | Module 1 | หาไอเดีย ฝึกกล้าถาม ไปให้ถึงบาทแรก |
| market-validation | Module 1.3-1.4 | พิสูจน์ว่าไอเดียมีคนต้องการจริง |
| offer-design | Module 2.1-2.3 | ปั้นข้อเสนอ + ตั้งราคา |
| grand-slam-offer | Module 2.4-2.5 | audit ข้อเสนอก่อนส่งจริง (panel) |
| sales-page-builder | Module 3.1 | หน้าขาย HTML หน้าเดียวจาก offer.md |
| my-brand-style | Module 3.2 | สไตล์ภาพประจำแบรนด์ (กรอกแบรนด์ตัวเองครั้งเดียว) |
| keyword-hook-research | Module 3.4 | หา keyword + hook ก่อนโพสต์ |
| launch-7-days | Module 3.5 + หลังคอร์ส | แผน 7 วันแรก + ชุดตอบแชท |
| aar | กลุ่ม 30 วัน | ถอดบทเรียนหลังโพสต์/หลังขาย |
| agent-orchestration | ขั้นสูง (เลนต่อยอด) | เลือกวิธีแตกงานให้หลาย agent |
| gauntlet-loop | ขั้นสูง (เลนต่อยอด) | loop งานกับ critic จนถึงเกณฑ์คุณภาพ |

หมายเหตุ: grand-slam-offer, keyword-hook-research, agent-orchestration, gauntlet-loop ทำงานเต็มรูปแบบใน Cowork/Claude Code — ในแชทธรรมดาจะสลับเป็นโหมดเรียงคิวอัตโนมัติ (เขียนไว้ท้าย skill แล้ว)

---

## สำหรับตั้ม — วิธีดูแล repo นี้

### เพิ่ม/แก้ skill

1. แต่ละ skill = 1 โฟลเดอร์ใต้ `plugins/soloproof/skills/` ข้างในมี `SKILL.md` (+ไฟล์ประกอบถ้ามี)
2. ชื่อโฟลเดอร์ = ชื่อ skill: ตัวพิมพ์เล็ก คั่นด้วย `-` เช่น `check-idea`, `build-offer`
3. แก้แล้ว push — ผู้เรียนเลน terminal รัน `/plugin marketplace update soloproof-skills` ก็ได้ของใหม่

### ออก zip ชุดใหม่ (เลนแอป Claude)

```bash
./scripts/make-zips.sh
gh release create vX.Y.Z dist/*.zip --title "vX.Y.Z" --notes "อัปเดตอะไร เขียนตรงนี้"
```

ลิงก์ `releases/latest/download/...` ใน README จะชี้เวอร์ชันใหม่ให้เองอัตโนมัติ ไม่ต้องแก้ลิงก์

### เช็คลิสต์ก่อนวันแจก Track 0

- [x] skill ครบ 13 โฟลเดอร์
- [x] zip รายตัวขึ้น GitHub Release แล้ว (เลนแอป Claude)
- [ ] ทดสอบติดตั้งจริงบน Windows 1 เครื่อง + Mac 1 เครื่อง
- [ ] เอาชื่อ skill ไปเติมใน "ใบทดลองก่อนวันงาน" ส่วนที่ 4 และสไลด์ Skill Studio
- [ ] USB สำรอง 1 อัน ใส่ zip ทุกตัว (โหลดจากหน้า Releases) เผื่อ Wi-Fi ห้องล่ม

## โครง repo

```
soloproof-skills/
├── .claude-plugin/
│   └── marketplace.json        ← ประกาศร้าน (เลน terminal)
├── plugins/
│   └── soloproof/
│       ├── .claude-plugin/
│       │   └── plugin.json     ← ประกาศชุด skill
│       └── skills/
│           ├── <skill>/SKILL.md
│           └── ...
├── scripts/
│   └── make-zips.sh            ← สร้าง zip แจก (เลนแอป)
└── README.md
```
