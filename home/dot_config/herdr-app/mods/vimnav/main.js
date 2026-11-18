// Vim-aware pane navigation, ported from the TUI's herdr-nav script
// (~/.config/herdr/bin/herdr-nav), which itself replaced tmux's
// `is_vim_or_lazygit` check.
//
// keys.json binds ctrl-h/j/k/l to `vimnav.left|down|up|right`. If the focused
// pane runs vim/neovim or lazygit, the key is passed on to that program (so vim
// moves between its own splits; Navigator.nvim calls `herdr-app do pane.go`
// at the edge). Otherwise Herdr's pane focus moves in that direction.
//
// It also ports the TUI's alt+arrow pane resizing (tmux: `resize-pane -L/R/U/D`):
// keys.json binds alt-left/right/up/down to `vimnav.resize-<direction>`, which
// moves the focused pane's border one step that way. The app has no pane
// resize command, so this reads the tab's split tree from herdr-core's layout
// document and sets the two panes beside the border with `layout.resize`.
// Spaces on this computer only.
//
// Draws nothing: it only listens for its key commands.

import { View, div } from "gpui-kit";
import { focused, panes, run, hc, nextCommand, checking, readTextFile, home } from "herdr";

const KEYS = { left: "ctrl+h", down: "ctrl+j", up: "ctrl+k", right: "ctrl+l" };
// Program-table keys (see `program.key`) that get the raw key instead.
const PASS_THROUGH = /^(n?vim|g?view|n?vimdiff|lazygit)$/;

// Resizing: share of the split moved per key press, and the smallest share a
// side may be squeezed to.
const STEP = 0.03;
const MIN = 0.1;
const DOC = ".local/state/herdr-core/default/docs.json";

// The chain of nodes from `node` down to the one with `id`, or null.
function pathTo(node, id) {
  if (node.id === id) return [node];
  for (const child of node.children ?? []) {
    const rest = pathTo(child, id);
    if (rest) return [node, ...rest];
  }
  return null;
}

export default class VimNav extends View {
  init(_props, cx) {
    if (checking()) return;
    // Weights this copy just set, so quick repeated presses build on each
    // other before the document on disk catches up.
    this.recent = new Map();
    cx.spawn(async () => {
      for (;;) {
        const command = await nextCommand();
        if (command.startsWith("resize-")) {
          try {
            await this.resize(command.slice("resize-".length));
          } catch (e) {
            console.log(`vimnav: resize failed: ${e}`);
          }
          continue;
        }
        const direction = command;
        if (!KEYS[direction]) continue;
        const f = focused();
        const pane = f?.pane ? panes().find((p) => p.pane === f.pane) : null;
        if (f?.terminal && PASS_THROUGH.test(pane?.program?.key ?? "")) {
          hc(["keys", f.terminal, KEYS[direction]]);
        } else {
          run("pane.go", { direction });
        }
      }
    });
  }

  weight(node, fallback) {
    const r = this.recent.get(node.id);
    if (r && Date.now() - r.at < 2000) return r.weight;
    return node.size?.weight ?? fallback;
  }

  async resize(direction) {
    const axis = { left: "row", right: "row", up: "column", down: "column" }[direction];
    const pane = focused()?.pane;
    if (!axis || !pane) return;
    const text = await readTextFile(`${home()}/${DOC}`);
    if (!text) return;
    const doc = JSON.parse(text)["herdr-app"]?.value;
    let path = null;
    for (const space of doc?.spaces ?? []) {
      for (const tab of space.tabs ?? []) path ??= pathTo(tab.root, pane);
    }
    if (!path) return;
    // The nearest split along this axis that the pane's branch shares with others.
    for (let i = path.length - 2; i >= 0; i--) {
      const split = path[i];
      const kids = split.children ?? [];
      if (split.type !== axis || kids.length < 2) continue;
      const at = kids.indexOf(path[i + 1]);
      // The border after the branch, or before it when it is the last one.
      const first = at < kids.length - 1 ? at : at - 1;
      const a = kids[first];
      const b = kids[first + 1];
      const known = kids.map((k) => k.size?.weight).filter((w) => typeof w === "number");
      const fallback = known.length ? known.reduce((x, y) => x + y, 0) / known.length : 1;
      const total = kids.reduce((sum, k) => sum + this.weight(k, fallback), 0);
      const pair = this.weight(a, fallback) + this.weight(b, fallback);
      const sign = direction === "right" || direction === "down" ? 1 : -1;
      const min = Math.min(MIN * total, pair / 2);
      const wa = Math.min(pair - min, Math.max(min, this.weight(a, fallback) + sign * STEP * total));
      const now = Date.now();
      this.recent.set(a.id, { weight: wa, at: now });
      this.recent.set(b.id, { weight: pair - wa, at: now });
      run("layout.resize", { id: a.id, weight: wa });
      run("layout.resize", { id: b.id, weight: pair - wa });
      return;
    }
  }

  render() {
    return div();
  }
}
