import EditorJS from "@editorjs/editorjs";
import Header from "@editorjs/header";
import List from "@editorjs/list";
import Hyperlink from "editorjs-hyperlink";

const Editor = {
  mounted() {
    const editor = new EditorJS({
      holder: "editorjs",
      tools: {
        header: {
          class: Header,
          config: {
            levels: [2, 3, 4],
            defaultLevel: 2,
          },
        },
        hyperlink: {
          class: Hyperlink,
          config: {
            shortcut: "CMD+L",
            target: "_blank",
            rel: "nofollow",
            availableTargets: ["_blank", "_self"],
            availableRels: ["author", "noreferrer"],
            validate: false,
          },
        },
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

    this.handleEvent("save-editor", (params) => {
      editor.save().then((editor_output) => {
        const payload = {
          main_text: editor_output["blocks"],
        };
        this.pushEvent("create-post", payload);
      });
    });
  },

  updated() {},
};

export default Editor;
