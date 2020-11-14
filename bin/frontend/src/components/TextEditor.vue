<template>
  <div>
    <input
      type="text"
      name="header"
      placeholder="Post Header"
      v-model="state.header"
    />
    <div id="editorjs" @load="$emit('loaded-editor', state.editor)"></div>
    <slot></slot>
  </div>
</template>

<script lang="ts">
import { reactive, watch } from "vue";
import EditorJS from "@editorjs/editorjs";

function initializeEditor(dataVar = { blocks: [] }) {
  const editor =  new EditorJS({
    holder: "editorjs",
    placeholder: "Let`s write an awesome story!",
    data: dataVar,
    tools: {
      // header: {
      //   class: Header,
      //   inlineToolbar: ['link']
      // },
      // list: {
      //   class: List,
      //   inlineToolbar: true
      // },
      // image: {
      //   class: ImageTool,
      //   config: {
      //     uploader: {
      //     /**
      //      * Upload file to the server and return an uploaded image data
      //      * @param {File} file - file selected from the device or pasted by drag-n-drop
      //      * @return {Promise.<{success, file: {url}}>}
      //      */
      //       async uploadByFile (file: File) {
      //         console.log("upload by file")
      //       },
      //       /**
      //      * Send URL-string to the server. Backend should load image by this URL and return an uploaded image data
      //      * @param {string} url - pasted image URL
      //      * @return {Promise.<{success, file: {url}}>}
      //      */
      //       uploadByUrl (url: string) {
      //         console.log(url)
      //       // your ajax request for uploading
      //       // return MyAjax.upload(file).then(() => {
      //       //   return {
      //       //     success: 1,
      //       //     file: {
      //       //       url: 'https://codex.so/upload/redactor_images/o_e48549d1855c7fc1807308dd14990126.jpg',
      //       //       alt: 'Some random stuff'
      //       //       // any other image data you want to store, such as width, height, color, extension, etc
      //       //     }
      //       //   }
      //       // })
      //       }
      //     }
      //   }
      // }
    }
  });

  // Store.set('editor', editor)
  return editor
}

function ProductList(props: any) {
  const state = reactive({
    header: "Header",
    editor: initializeEditor(props.data)
  });

  return { state };
}

export default {
  props: {
    buttonText: {
      type: String,
      default: "Save"
    },
    header: {
      type: String,
      default: "Title"
    },
    data: {
      type: Object,
      default: () => {
        return { time: 0 };
      }
    },
    trigger: {
      type: Boolean,
      default: false
    }
  },
  setup(props: any, context: any) {
    const { state } = ProductList(props);
    watch(
      () => props.trigger,
      async (__count__, __prevCount__) => {
        const temp: { [k: string]: any } = await state.editor.save();
        temp.header = state.header;
        context.emit("save", temp);
      }
    );
    return { state };
  }
};
</script>

<style lang="scss" scoped>
input, input:focus {
  border: none;
  outline: none;
  width: 100%;
  font-size: 1.5rem;
  font-weight: bold;
}
* {
  text-align: left;
}
</style>
