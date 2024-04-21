import Quill from 'quill';
export let TextEditor = {
  mounted() {
    let quill = new Quill(this.el, {
      theme: 'snow'
    });

    quill.on('text-change', (delta, oldDelta, source) => {
      if (source == 'user') {
        this.pushEventTo(this.el.phxHookId, "text-editor", {"text_content": quill.getContents()})
      }
    });
  },
  updated(){
    console.log('U');
  }
}