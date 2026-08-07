"""Token accounting per arm.

On a subscription plan the dollar figure means nothing. What matters is tokens,
and especially cache reads: every turn re-reads the whole transcript, so a
verbose early turn is paid for again on every turn that follows.

    python tokens.py runs/long-control runs/long-rules runs/long-hooks
"""
import io, os, sys, json, glob


def load(d):
    turns = []
    for f in sorted(glob.glob(os.path.join(d, "t*.json"))):
        try:
            j = json.load(io.open(f, encoding="utf-8"))
        except Exception:
            continue
        u = j.get("usage") or {}
        turns.append({
            "turn": os.path.basename(f)[1:3],
            "in": u.get("input_tokens", 0) or 0,
            "out": u.get("output_tokens", 0) or 0,
            "cread": u.get("cache_read_input_tokens", 0) or 0,
            "cwrite": u.get("cache_creation_input_tokens", 0) or 0,
            "cost": j.get("total_cost_usd", 0) or 0,
            "ms": j.get("duration_ms", 0) or 0,
        })
    return turns


def summarize(d):
    t = load(d)
    if not t:
        return None
    n = len(t)
    s = lambda k: sum(x[k] for x in t)
    billable = s("in") + s("out") + s("cwrite")
    return {
        "label": os.path.basename(d), "n": n,
        "in": s("in"), "out": s("out"), "cread": s("cread"), "cwrite": s("cwrite"),
        "total_ctx": s("cread") + s("cwrite") + s("in"),
        "billable": billable,
        "out_per_turn": s("out") // n,
        "cread_per_turn": s("cread") // n,
        "cost": s("cost"), "min": s("ms") // 60000,
        "turns": t,
    }


arms = [a for a in (summarize(d) for d in sys.argv[1:]) if a]
if not arms:
    sys.exit("no runs found")

w = 17
print(f"{'':26}" + "".join(f"{a['label']:>{w}}" for a in arms))
print("-" * (26 + w * len(arms)))


def row(name, key, fmt="{:,}"):
    print(f"{name:26}" + "".join(f"{fmt.format(a[key]):>{w}}" for a in arms))


row("turns", "n", "{}")
print()
print("TOKENS THE MODEL WROTE")
row("  output tokens", "out")
row("  output per turn", "out_per_turn")
print()
print("TOKENS THE MODEL READ")
row("  cache read (history)", "cread")
row("  cache read per turn", "cread_per_turn")
row("  cache creation", "cwrite")
row("  fresh input", "in")
row("  total context read", "total_ctx")
print()
print("SUM")
row("  billable (in+out+write)", "billable")
print(f"{'  wall clock (min)':26}" + "".join(f"{a['min']:>{w}}" for a in arms))
print(f"{'  cost (reference only)':26}" + "".join(f"{('$%.2f' % a['cost']):>{w}}" for a in arms))

base = arms[0]
if len(arms) > 1:
    print("\nRELATIVE TO " + base["label"].upper())
    for a in arms[1:]:
        print(f"  {a['label']}")
        for k, lab in [("out", "output tokens"), ("cread", "cache read"),
                       ("billable", "billable tokens"), ("total_ctx", "context read")]:
            b, v = base[k], a[k]
            pct = ((v - b) / b * 100) if b else 0
            print(f"      {lab:20} {v:>12,}  {pct:+7.1f}%")

print("\nCONTEXT GROWTH: cache read per turn, by third")
print(f"{'third':26}" + "".join(f"{a['label']:>{w}}" for a in arms))
for k in range(3):
    cells = []
    for a in arms:
        t = a["turns"]
        seg = t[k * len(t) // 3:(k + 1) * len(t) // 3]
        cells.append(sum(x["cread"] for x in seg) // max(len(seg), 1))
    print(f"{'  turns ' + str(k+1) + '/3':26}" + "".join(f"{c:>{w},}" for c in cells))
