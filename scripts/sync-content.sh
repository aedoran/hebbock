#!/usr/bin/env bash
# Sync the Obsidian vault (../wiki) into the Quartz content folder.
# The vault is the source of truth; content/ is the build snapshot.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WIKI="$(cd "$ROOT/.." && pwd)/wiki"
DEST="$ROOT/content"
# The vault is the source of truth; content/ is the build snapshot.
# On the GitHub runner there is no ../wiki (it isn't in the repo),
# so fall back to the content/ last synced locally.
if [ ! -d "$WIKI" ]; then
  echo "No vault found at $WIKI - using committed content/ (CI mode)."
  if [ ! -d "$DEST" ]; then
    echo "content/ is missing and there is no vault to sync from; aborting."
    exit 1
  fi
  exit 0
fi
rm -rf "$DEST"
mkdir -p "$DEST"
# Copy everything except the Obsidian config file
(cd "$WIKI" && tar --exclude='.obsidian-wiki-config.json' --exclude='.gitkeep' -cf - .) | (cd "$DEST" && tar -xf -)
echo "Synced vault -> $DEST"
