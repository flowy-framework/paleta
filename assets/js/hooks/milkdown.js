import { Editor, defaultValueCtx, rootCtx } from "@milkdown/core";
import { nord } from "@milkdown/theme-nord";
import { commonmark } from "@milkdown/preset-commonmark";
import { menu, menuDefaultConfig } from "@milkdown-lab/plugin-menu";

export let MilkdownEditor = {
  mounted() {
    Editor.make()
      .config(menuDefaultConfig)
      .config((ctx) => {
        ctx.set(
          defaultValueCtx,
          document.getElementById("editor-content").value
        );
        ctx.set(rootCtx, "#richt-editor");
      })
      .use(menu)
      .use(commonmark)
      .create();
  },
};
