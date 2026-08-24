# soloproof-skills

Skill library ประกอบคอร์ส SOLO PROOF — ติดตั้งครั้งเดียวได้ครบชุด กด update รับของใหม่ได้ตลอด

## สำหรับผู้เรียน — ติดตั้ง 2 บรรทัด (Claude Code)

```
/plugin marketplace add <GITHUB_USERNAME>/soloproof-skills
/plugin install soloproof@soloproof-skills
```

เสร็จแล้วพิมพ์ `/reload-plugins` หนึ่งครั้ง แล้วเช็คด้วย `/plugin` — ต้องเห็น skill ครบทุกตัว

รับของเวอร์ชันใหม่ภายหลัง: `/plugin marketplace update soloproof-skills`

### ใช้แอป Claude (ไม่ใช้ terminal)

ใช้ไฟล์ zip รายตัวที่แจกในคอร์สแทน: Settings → Capabilities → เปิด **Code execution and file creation**
→ Skills → ปุ่ม **+** → Upload a skill → เลือกไฟล์ zip
(skill ที่เปิดในแอปจะ sync ลง Claude Code อัตโนมัติด้วย)

---

## สำหรับตั้ม — วิธีเอา skill ใส่ repo นี้

1. แต่ละ skill = 1 โฟลเดอร์ใต้ `plugins/soloproof/skills/` ข้างในมี `SKILL.md` (+ไฟล์ประกอบถ้ามี)
   ดูแม่แบบใน `_template-skill/` — **ลบโฟลเดอร์ _template-skill ทิ้งก่อน push จริง**
2. ชื่อโฟลเดอร์ = ชื่อ skill: ตัวพิมพ์เล็ก คั่นด้วย `-` เช่น `check-idea`, `build-offer`
3. push ขึ้น GitHub เป็น **public repo** ชื่อ `soloproof-skills`
   แล้วแก้ `<GITHUB_USERNAME>` ใน README นี้ให้เป็นชื่อจริง
4. ทดสอบก่อนแจก: เครื่องตัวเอง รัน 2 บรรทัดข้างบน แล้วลองเรียกใช้ skill สัก 2 ตัว
5. แก้ skill ภายหลัง: แก้ไฟล์ → push → บอกผู้เรียนรัน `/plugin marketplace update soloproof-skills`

### เช็คลิสต์ก่อนวันแจก Track 0

- [x] skill ครบ 13 โฟลเดอร์
- [ ] ทดสอบติดตั้งจริงบน Windows 1 เครื่อง + Mac 1 เครื่อง
- [ ] ทำ zip รายตัว (zip ที่ *ราก* คือโฟลเดอร์ skill) สำหรับเลนแอป → เก็บในโฟลเดอร์แจกไฟล์ของคอร์ส
- [ ] เอาชื่อ skill ทั้ง 10 ไปเติมใน "ใบทดลองก่อนวันงาน" ส่วนที่ 4 และสไลด์ Skill Studio
- [ ] USB สำรอง 1 อัน ใส่ zip ทุกตัว เผื่อ Wi-Fi ห้องล่ม


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

## โครง repo

```
soloproof-skills/
├── .claude-plugin/
│   └── marketplace.json        ← ประกาศร้าน
├── plugins/
│   └── soloproof/
│       ├── .claude-plugin/
│       │   └── plugin.json     ← ประกาศชุด skill
│       └── skills/
│           ├── <skill-1>/SKILL.md
│           ├── ...
│           └── <skill-10>/SKILL.md
└── README.md
```
