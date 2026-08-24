#!/usr/bin/env bash
# สร้าง zip แจกผู้เรียน: รายตัว (อัปโหลดเข้าแอป Claude) + zip รวมทุกตัว
# ใช้: ./scripts/make-zips.sh   → ได้ไฟล์ใน dist/
set -euo pipefail

cd "$(dirname "$0")/.."
SKILLS_DIR="plugins/soloproof/skills"
DIST="dist"

rm -rf "$DIST"
mkdir -p "$DIST"

for dir in "$SKILLS_DIR"/*/; do
  name="$(basename "$dir")"
  [ -f "$dir/SKILL.md" ] || continue
  # zip ที่รากต้องเป็นโฟลเดอร์ skill (แอป Claude ต้องการแบบนี้)
  (cd "$SKILLS_DIR" && zip -rq "../../../$DIST/$name.zip" "$name" -x "*.DS_Store")
  echo "  $DIST/$name.zip"
done

(cd "$SKILLS_DIR" && zip -rq "../../../$DIST/soloproof-all-skills.zip" . -x "*.DS_Store")
echo "  $DIST/soloproof-all-skills.zip (รวมทุกตัว)"
