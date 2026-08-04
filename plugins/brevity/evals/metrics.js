// Reads the JSON result of every turn in a run and prints token and cost totals.
//   node metrics.js runs/brevity [runs/control]
const fs = require('fs');
const path = require('path');

function load(dir) {
  const rows = [];
  for (const f of fs.readdirSync(dir).filter(f => /^t\d+\.json$/.test(f)).sort()) {
    let j;
    try { j = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8')); } catch { continue; }
    const u = j.usage || {};
    rows.push({
      turn: f.replace(/\D/g, ''),
      words: (j.result || '').trim().split(/\s+/).filter(Boolean).length,
      out: u.output_tokens || 0,
      inp: u.input_tokens || 0,
      cacheRead: u.cache_read_input_tokens || 0,
      cacheWrite: u.cache_creation_input_tokens || 0,
      cost: j.total_cost_usd || 0,
      ms: j.duration_ms || 0,
    });
  }
  return rows;
}

function sum(rows, k) { return rows.reduce((a, r) => a + r[k], 0); }

function table(label, rows) {
  console.log(`\n== ${label}`);
  console.log('turn  words   out    in  cacheR  cacheW     cost');
  for (const r of rows) {
    console.log(
      String(r.turn).padStart(4),
      String(r.words).padStart(6),
      String(r.out).padStart(5),
      String(r.inp).padStart(5),
      String(r.cacheRead).padStart(7),
      String(r.cacheWrite).padStart(7),
      ('$' + r.cost.toFixed(4)).padStart(9),
    );
  }
  console.log(
    ' SUM'.padStart(4),
    String(sum(rows, 'words')).padStart(6),
    String(sum(rows, 'out')).padStart(5),
    String(sum(rows, 'inp')).padStart(5),
    String(sum(rows, 'cacheRead')).padStart(7),
    String(sum(rows, 'cacheWrite')).padStart(7),
    ('$' + sum(rows, 'cost').toFixed(4)).padStart(9),
  );
}

const dirs = process.argv.slice(2);
const runs = dirs.map(d => ({ label: path.basename(d), rows: load(d) }));
for (const r of runs) table(r.label, r.rows);

if (runs.length === 2) {
  const [a, b] = runs;
  const pct = (x, y) => y === 0 ? 'n/a' : (((x - y) / y) * 100).toFixed(1) + '%';
  console.log(`\n== ${a.label} vs ${b.label}`);
  for (const k of ['words', 'out', 'cacheRead', 'cost']) {
    const va = sum(a.rows, k), vb = sum(b.rows, k);
    const fmt = k === 'cost' ? (v => '$' + v.toFixed(4)) : (v => String(v));
    console.log(
      k.padEnd(10),
      fmt(va).padStart(10),
      fmt(vb).padStart(10),
      pct(va, vb).padStart(9),
    );
  }
}
