#!/usr/bin/env node
// Adds the active output style to any status line.
//
// Claude Code sends the status line command a JSON object on stdin. That object
// carries output_style.name, but most status lines ignore it. This script reads
// the name, passes the same JSON to the status line you already use, and adds
// the name to what that status line prints.
//
// In ~/.claude/settings.json:
//
//   "statusLine": {
//     "type": "command",
//     "command": "node /path/to/with-style.js -- <your existing command>"
//   }
//
// With no inner command it prints the style on its own.
//
//   node with-style.js
//     style: Brevity
//
// Options, before the -- separator:
//   --prefix     put the style before the inner output, not after
//   --label X    text before the name. Default "style: "
//   --hide-default   print nothing when the style is Default

const { spawn } = require('node:child_process');

const argv = process.argv.slice(2);
const sep = argv.indexOf('--');
const opts = sep === -1 ? argv : argv.slice(0, sep);
const inner = sep === -1 ? [] : argv.slice(sep + 1);

const prefix = opts.includes('--prefix');
const hideDefault = opts.includes('--hide-default');
const labelIdx = opts.indexOf('--label');
const label = labelIdx !== -1 && opts[labelIdx + 1] ? opts[labelIdx + 1] : 'style: ';

let raw = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', c => { raw += c; });
process.stdin.on('end', () => {
  let name = 'Default';
  try {
    name = JSON.parse(raw)?.output_style?.name || 'Default';
  } catch {
    // Not JSON. Fall through with Default and still run the inner command.
  }

  const badge = hideDefault && name === 'Default' ? '' : label + name;

  if (inner.length === 0) {
    if (badge) console.log(badge);
    return;
  }

  const child = spawn(inner[0], inner.slice(1), {
    // stderr is dropped. A status line that prints errors corrupts the display.
    stdio: ['pipe', 'pipe', 'ignore'],
    shell: true,
  });

  let out = '';
  child.stdout.setEncoding('utf8');
  child.stdout.on('data', c => { out += c; });

  child.on('error', () => {
    if (badge) console.log(badge);
    process.exit(0);
  });

  child.on('close', () => {
    const body = out.replace(/\n$/, '');
    if (!badge) {
      console.log(body);
    } else if (prefix) {
      console.log(badge + '\n' + body);
    } else {
      console.log(body + '\n' + badge);
    }
  });

  child.stdin.write(raw);
  child.stdin.end();
});
