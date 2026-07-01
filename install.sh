#!/usr/bin/env bash
# Устанавливает скилл retrospective в ~/.claude/skills/
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)/skill/retrospective"
DEST="${HOME}/.claude/skills/retrospective"
if [ -d "$DEST" ]; then
  echo "⚠  $DEST уже существует — делаю бэкап в ${DEST}.bak"
  rm -rf "${DEST}.bak"; mv "$DEST" "${DEST}.bak"
fi
mkdir -p "${HOME}/.claude/skills"
cp -r "$SRC" "$DEST"
echo "✓ Скилл установлен в $DEST"
echo "  Claude Code подхватит его по описанию; явный вызов — /retrospective"
