// ProseMirrorView{
import { EditorView } from "prosemirror-view";
import { EditorState } from "prosemirror-state";
import {
  schema,
  defaultMarkdownParser,
  defaultMarkdownSerializer,
} from "prosemirror-markdown";
import { exampleSetup } from "prosemirror-example-setup";

export let ProsemirrorEditor = {
  mounted() {
    // ProseMirrorView{
    class ProseMirrorView {
      constructor(target, content) {
        this.view = new EditorView(target, {
          state: EditorState.create({
            doc: defaultMarkdownParser.parse(content),
            plugins: exampleSetup({ schema }),
          }),
        });
      }

      get content() {
        return defaultMarkdownSerializer.serialize(this.view.state.doc);
      }
      focus() {
        this.view.focus();
      }
      destroy() {
        this.view.destroy();
      }
    }
    // }

    let place = document.querySelector("#prosemirror-editor");

    let editorView = new ProseMirrorView(
      place,
      document.querySelector("#prosemirror-content").value
    );

    editorView.view.setProps({
      dispatchTransaction(transaction) {
        let newState = editorView.view.state.apply(transaction);
        editorView.view.updateState(newState);
        document.querySelector("#prosemirror-content").value =
          editorView.content;
      },
    });

    editorView.focus();
  },
};
