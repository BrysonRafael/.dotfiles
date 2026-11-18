// Clears a terminal selection shortly after it is made, the way the Herdr TUI
// did: highlight, it lands on the clipboard, and the highlight goes away.
//
// The app copies a mouse selection on release (settings.json `copy_on_select`)
// but leaves it highlighted, and has no setting to clear it. A mod can't see
// the mouse button, only the selection itself, so this polls for one, waits
// until it has stopped changing for SETTLE ms, copies it and clears it. The
// copy is repeated here on purpose: if a drag is paused for longer than SETTLE
// the selection is cleared before the button is released, and the app's own
// copy-on-release would then have nothing to copy.
//
// Draws nothing; stays loaded as a kept overlay window (see mod.json).

import { View, div } from "gpui-kit";
import { focused, terminals, run, checking } from "herdr";

const SETTLE = 600;
const POLL = 150;

export default class SelClear extends View {
  init(_props, cx) {
    if (checking()) return;
    this.seen = null; // the selection last seen, as a string
    this.at = 0; // when it last changed
    // Polled: re-render on selection change wasn't reliable for this copy.
    cx.timer.every(POLL, () => {
      // A mouse selection lives in the terminal that was clicked, which is the
      // focused one; any other terminal with a selection is cleared the same way.
      const t = terminals().find((t) => t.selection);
      const now = t ? `${t.address}:${JSON.stringify(t.selection)}` : null;
      if (now !== this.seen) {
        this.seen = now;
        this.at = Date.now();
        return;
      }
      if (!now || Date.now() - this.at < SETTLE) return;
      if (focused()?.terminal === t.address) run("terminal.copy");
      run("terminal.clear_selection", { terminal: t.address });
      this.seen = null;
    });
  }

  render() {
    return div();
  }
}
