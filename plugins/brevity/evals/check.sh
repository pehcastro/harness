#!/usr/bin/env bash
# Counts words and banned terms in a saved run.
#   ./check.sh runs/brevity
set -u
DIR="${1:?usage: check.sh <run-dir>}"

BANNED='\b(landed?|shipped?|dispatch(ed|ing)?|surfaced|unblocks?|in flight|kick(ed)? off|north star|source of truth|deep dive|circle back|double-click|leverag(e|ing)|holistic|robust|seamless|low-hanging|greenfield|blast radius|forcing function|load-bearing|streamline|orchestrat(e|ing)|great question|excellent point|absolutely right|good catch|happy to|feel free to|let me know if|hope this helps|standing by|worth noting|worth flagging|important to note|that said|I believe|I would argue|it seems)\b'

printf '%-6s %7s %7s  %s\n' turn words banned sample
printf '%-6s %7s %7s  %s\n' ---- ----- ------ ------

tw=0; tb=0
for f in "$DIR"/t*.txt; do
  [ -e "$f" ] || continue
  n=$(basename "$f" .txt)
  w=$(wc -w < "$f" | tr -d ' ')
  b=$(grep -oEi "$BANNED" "$f" | wc -l | tr -d ' ')
  s=$(grep -oEi "$BANNED" "$f" | sort -u | paste -sd, - | cut -c1-46)
  printf '%-6s %7s %7s  %s\n' "$n" "$w" "$b" "$s"
  tw=$((tw + w)); tb=$((tb + b))
done

printf '%-6s %7s %7s\n' TOTAL "$tw" "$tb"
echo
echo "em dashes: $(cat "$DIR"/t*.txt | grep -o '—' | wc -l | tr -d ' ')"
echo "tables:    $(cat "$DIR"/t*.txt | grep -cE '^\s*\|.*\|' | tr -d ' ')"
