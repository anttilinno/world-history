#!/usr/bin/env bash
# Consume PLAN.md: generate one article per civilization in data.js,
# using parallel fresh-context `claude -p` agents.
#
# Usage:   ./build-articles.sh              # all missing articles
#          CONCURRENCY=10 ./build-articles.sh
#          ./build-articles.sh mali-empire inca   # only these ids
set -uo pipefail
cd "$(dirname "$0")"
mkdir -p articles

CONCURRENCY="${CONCURRENCY:-6}"
MODEL="${MODEL:-claude-sonnet-5}"

gen() {
  local id="$1"
  local out="articles/$id.html"
  if [[ -s "$out" ]]; then
    echo "skip  $id (exists)"
    return 0
  fi
  local entry
  entry=$(grep -F "id:\"$id\"" data.js) || { echo "FAIL  $id (not in data.js)" >&2; return 1; }
  local prompt="You are one parallel article-writer agent with fresh context, working in $(pwd).
Read PLAN.md section 'Article spec' and the reference article articles/ancient-egypt.html, then write articles/$id.html for this data.js entry:
$entry
Follow the spec exactly. Write only that one file."
  if claude -p --model "$MODEL" --permission-mode acceptEdits "$prompt" >/dev/null 2>&1 && [[ -s "$out" ]]; then
    echo "done  $id"
  else
    rm -f "$out"
    echo "FAIL  $id (re-run script to retry)" >&2
    return 1
  fi
}
export -f gen
export MODEL

if [[ $# -gt 0 ]]; then
  ids=$(printf '%s\n' "$@")
else
  ids=$(grep -oE 'id:"[a-z0-9-]+"' data.js | cut -d'"' -f2)
fi

total=$(wc -l <<<"$ids")
echo "articles: $total entries, concurrency $CONCURRENCY, model $MODEL"
xargs -P "$CONCURRENCY" -I{} bash -c 'gen "$@"' _ {} <<<"$ids"

missing=$(comm -23 <(sort <<<"$ids") <(ls articles | sed -n 's/\.html$//p' | sort) | grep -v '^$' || true)
if [[ -n "$missing" ]]; then
  echo "still missing:"; echo "$missing"
  exit 1
fi
echo "all articles present."
