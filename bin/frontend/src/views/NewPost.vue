<template>
  <div class="home">
    <h1 class="h1-responsive">Create a new Post</h1>
    <TextEditor @save="saveArticle" :trigger="trigger">
      <footer class="float-right">
        <Button
          class="btn-primary"
          icon="fa-pen"
          text="Save"
          @clicked="triggerArticleSave"
        />
      </footer>
    </TextEditor>
  </div>
</template>

<script lang="ts">
import TextEditor from "@/components/TextEditor.vue"; // @ is an alias to /src
import Button from "@/components/button.vue";
import { ref } from 'vue';

export default {
  components: {
    TextEditor,
    Button
  },
  setup() {
    const trigger = ref(false);

    function triggerArticleSave() {
      trigger.value = !trigger.value;
    }

    function saveArticle(outputData: any) {
      outputData.authorId = 1;
      outputData.blogId = 1;
      outputData.body = outputData.blocks;
      outputData.postStatus = "published";
      outputData.postName = `${outputData.header}-${new Date().getDate().toString()}-${new Date().getSeconds().toString()}`;
      delete outputData.version;
      delete outputData.blocks;
      console.log("Article data: ", outputData);
      outputData.body = JSON.stringify(outputData.body);
      fetch("http://localhost:9292/api/blogs/1/posts", {
        method: "POST",
        body: JSON.stringify(outputData)
      });
    }
    return { saveArticle, trigger, triggerArticleSave };
  }
};
</script>
