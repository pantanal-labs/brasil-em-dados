import EditorJS from "@editorjs/editorjs";
import Header from "@editorjs/header";
import List from "@editorjs/list";

const Editor = {
  mounted() {
    const editor = new EditorJS({
      holder: "editorjs",
      tools: {
        header: Header,
        list: List,
      },
      data: {
        blocks: [
          {
            type: "paragraph",
            data: {
              text:
                "Hey. Meet the new Editor. On this page you can see it in action — try to edit this text. Source code of the page contains the example of connection and configuration.",
            },
          },
          {
            type: "list",
            data: {
              items: [
                "It is a block-styled editor",
                "It returns clean data output in JSON",
                "Designed to be extendable and pluggable with a simple API",
              ],
              style: "unordered",
            },
          },
          {
            type: "header",
            data: {
              text: "What does it mean «block-styled editor»",
              level: 3,
            },
          },
        ],
      },
    });
  },

  updated() {
    this.pending = this.page();
  },
};

export default Editor;
