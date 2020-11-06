<template>
  <div>
    <input
      type="text"
      name="header"
      placeholder="Post Header"
      v-model="state.header"
    />
    <div id="editorjs"></div>
    <button @click="addArticle">Submit</button>
  </div>
</template>

<script lang="ts">
import { reactive } from "vue";
import EditorJS from "@editorjs/editorjs";

function initializeEditor() {
  return new EditorJS({
    holder: "editorjs",
    placeholder: "Let`s write an awesome story!",
    // data: {},
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
}

function ProductList() {
 const state = reactive({
    header: '',
    editor: initializeEditor(),
  });

  const addArticle = (e: Event) => {
    e.preventDefault();
    state.editor
      .save()
      .then((outputData: any) => {
        outputData.header = state.header
        outputData.author = 1;
        console.log("Article data: ", outputData);
        fetch("http://localhost:9292/api/blogs/1/posts", {
          method: "POST",
          body: JSON.stringify(outputData)
        });
      })
      .catch(error => {
        console.log("Saving failed: ", error);
      });
  };

//  const removeArticle = (i) => {
//     state.data.splice(i, 1);
//   };

  return { state, addArticle };
}

export default {
  setup() {
      const { state, addArticle } = ProductList();
      return { state, addArticle };
    },
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
