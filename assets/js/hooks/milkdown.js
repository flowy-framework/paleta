import { Editor, defaultValueCtx, rootCtx } from "@milkdown/core";
import { nord } from "@milkdown/theme-nord";
import { commonmark } from "@milkdown/preset-commonmark";

export let MilkdownEditor = {
  mounted() {
   
    Editor.make()
          .config((ctx) => {
            ctx.set(defaultValueCtx, document.getElementById("editor-content").value)
            ctx.set(rootCtx, "#richt-editor");
          })
          .use(nord)
          .use(commonmark)
          .create();
  }
}