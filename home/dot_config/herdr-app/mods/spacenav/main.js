// A small "space mode", like the TUI's workspace picker: leader+space opens
// it (keys.json: `mod.open:spacenav`), then j/k (or the arrows) step through
// the spaces in the sidebar, switching as they go. Enter keeps the space you
// landed on; Esc goes back to the one you started from.
//
// It is a popup only so it can hold the keyboard while the mode is on; all it
// draws is a one-line hint.

import { View, div } from "gpui-kit";
import { h_flex } from "gpui-base";
import { spaces, run, theme, props, closeOverlay, checking } from "herdr";

export default class SpaceNav extends View {
  init(_props, cx) {
    this.origin = spaces().find((s) => s.active)?.id ?? null;
    this.handle = cx.focus_handle();
    if (checking()) return;
    this.handle.focus();
    // Again shortly after: opening the popup can hand the keyboard elsewhere.
    cx.timer.after(150, () => this.handle.focus());
  }

  close() {
    closeOverlay(props().overlay);
  }

  render() {
    const t = theme();
    const here = spaces().find((s) => s.active);
    const key = (label) => div().px(5).rounded(4).bg(t.raised).text_color(t.foreground).child(label);
    return h_flex()
      .id("spacenav")
      .track_focus(this.handle)
      .size_full()
      .px(12)
      .gap(6)
      .items_center()
      .bg(t.popover)
      .text_size(12)
      .text_color(t.muted)
      .on_key_down((e, cx) => {
        const k = e.key;
        cx.stop_propagation();
        if (k === "j" || k === "down") run("space.next");
        else if (k === "k" || k === "up") run("space.prev");
        else if (k === "enter") return this.close();
        else if (k === "escape") {
          if (this.origin) run("space.select", { id: this.origin });
          return this.close();
        } else return;
        // Switching spaces focuses a terminal there; take the keyboard back.
        this.handle.focus();
        cx.timer.after(30, () => this.handle.focus());
        cx.notify();
      })
      .child(key("j"))
      .child(key("k"))
      .child(div().child("spaces"))
      .child(key("⏎"))
      .child(div().flex_1().truncate().text_color(t.foreground).child(here?.name ?? ""))
      .child(key("esc"))
      .child(div().child("back"));
  }
}
