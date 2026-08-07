"""Compares benchmark arms.

Reports the things the last session showed mattered: how long replies run, how
that changes as the session grows, and how often a countable rule breaks.

    python analyze.py runs/long-control runs/long-rules runs/long-hooks
"""
import io, os, re, sys, json, glob

BANNED = r"(^|[^a-z])(landed|dispatched|in flight|shipped|surfaced|north star)([^a-z]|$)"
GREEN = r"(ci|tests|test|suite) (is |are |will be |stays )?green"
OPENER = r"^\s*(You are right|You'?re right|Great question|Good catch|Exactly right|Absolutely right)"
METRICS = [r"[0-9]+ (tests?|specs?)", r"typecheck ?[0-9]", r"lint (clean|0)",
           r"[0-9]+ routes?|routes? 200", r"(everything|all) committed|tree clean"]


def strip_code(t):
    out, fence = [], False
    for l in t.split("\n"):
        if l.strip().startswith("```"):
            fence = not fence
            continue
        if not fence:
            out.append(l)
    return "\n".join(out)


def load(d):
    rows = []
    for f in sorted(glob.glob(os.path.join(d, "t*.txt"))):
        raw = io.open(f, encoding="utf-8", errors="replace").read()
        b = strip_code(raw)
        low = b.lower()
        rows.append({
            "turn": os.path.basename(f)[1:3],
            "words": len(b.split()),
            "banned": len(re.findall(BANNED, low)) + len(re.findall(GREEN, low)),
            "emdash": b.count("—"),
            "bold": len(re.findall(r"\*\*[^*]+\*\*", b)),
            "opener": 1 if re.search(OPENER, b, re.I) else 0,
            "scorecard": 1 if sum(1 for m in METRICS if re.search(m, low)) >= 2 else 0,
            "tables": len(re.findall(r"(?m)^\s*\|.*\|\s*$", b)),
        })
    return rows


def cost(d):
    tot, out_tok = 0.0, 0
    for f in sorted(glob.glob(os.path.join(d, "t*.json"))):
        try:
            j = json.load(io.open(f, encoding="utf-8"))
        except Exception:
            continue
        tot += j.get("total_cost_usd", 0) or 0
        out_tok += (j.get("usage") or {}).get("output_tokens", 0) or 0
    return tot, out_tok


def lintlog(d):
    p = os.path.join(d, "lint.log")
    if not os.path.exists(p):
        return None
    lines = [l for l in io.open(p, encoding="utf-8", errors="replace").read().split("\n") if l.strip()]
    flagged = [l for l in lines if "\tclean" not in l]
    return len(lines), len(flagged)


def summarize(label, d):
    rows = load(d)
    if not rows:
        return None
    n = len(rows)
    w = [r["words"] for r in rows]
    c, ot = cost(d)
    ll = lintlog(d)
    return {
        "label": label, "n": n, "total": sum(w), "mean": sum(w) // n,
        "median": sorted(w)[n // 2], "max": max(w),
        "over120": sum(1 for x in w if x > 120),
        "over250": sum(1 for x in w if x > 250),
        "banned": sum(r["banned"] for r in rows),
        "emdash": sum(r["emdash"] for r in rows),
        "bold": sum(r["bold"] for r in rows),
        "tables": sum(r["tables"] for r in rows),
        "opener": sum(r["opener"] for r in rows),
        "scorecard": sum(r["scorecard"] for r in rows),
        "cost": c, "out_tok": ot, "lint": ll, "rows": rows,
    }


arms = [a for a in (summarize(os.path.basename(d), d) for d in sys.argv[1:]) if a]

print(f"{'':22}" + "".join(f"{a['label']:>16}" for a in arms))
def line(name, key, fmt="{}"):
    print(f"{name:22}" + "".join(f"{fmt.format(a[key]):>16}" for a in arms))

line("replies", "n")
line("total words", "total")
line("mean words", "mean")
line("median words", "median")
line("longest reply", "max")
line("replies >120w", "over120")
line("replies >250w", "over250")
print()
line("banned words", "banned")
line("em dashes", "emdash")
line("bold phrases", "bold")
line("table rows", "tables")
line("agreeing openers", "opener")
line("scorecards", "scorecard")
print()
line("output tokens", "out_tok")
print(f"{'cost (usd)':22}" + "".join(f"{('$%.4f' % a['cost']):>16}" for a in arms))
for a in arms:
    if a["lint"]:
        t, f = a["lint"]
        print(f"  {a['label']}: lint saw {t} turns, asked for a rewrite on {f} ({100*f//max(t,1)}%)")

print("\n== drift: mean words by third of the session ==")
print(f"{'third':22}" + "".join(f"{a['label']:>16}" for a in arms))
for k in range(3):
    cells = []
    for a in arms:
        r = a["rows"]
        seg = r[k * len(r) // 3:(k + 1) * len(r) // 3]
        cells.append(sum(x["words"] for x in seg) // max(len(seg), 1))
    print(f"{'turns ' + str(k+1) + '/3':22}" + "".join(f"{c:>16}" for c in cells))

print("\n== drift: countable violations by third ==")
for k in range(3):
    cells = []
    for a in arms:
        r = a["rows"]
        seg = r[k * len(r) // 3:(k + 1) * len(r) // 3]
        cells.append(sum(x["banned"] + x["emdash"] + x["opener"] + x["scorecard"] for x in seg))
    print(f"{'turns ' + str(k+1) + '/3':22}" + "".join(f"{c:>16}" for c in cells))
