<template>
  <div class="home">
    <h1 class="h1-responsive">Create a new Post</h1>
    <TextEditor
      @save="saveArticle"
      :trigger="trigger"
      @header-empty="onHeaderEmpty"
      @header-not-empty="onHeaderNotEmpty"
    >
      <footer class="float-right">
        <Button
          class="btn-primary"
          :class="{ disabled: !headerContainsContent }"
          icon="fa-pen"
          text="Save"
          :spinner="saveInProgress"
          @clicked="triggerArticleSave"
        />
      </footer>
    </TextEditor>
  </div>
</template>

<script lang="ts">
import TextEditor from "@/components/TextEditor.vue"; // @ is an alias to /src
import Button from "@/components/button.vue";
import { ref } from "vue";
import store from "@/store";
import Post from "../methods/posts";
import { useRouter } from "vue-router";

export default {
  components: {
    TextEditor,
    Button
  },
  setup() {
    const router = useRouter()
    const trigger = ref(false);
    const saveInProgress = ref(false);
    function triggerArticleSave() {
      saveInProgress.value = true;
      trigger.value = !trigger.value;
    }

    async function saveArticle(outputData: any): Promise<any> {
      const post = new Post();
      console.log(outputData.blocks)
      post.blogId = store.getters.blog.id;
      if (post.blogId == 0) {
        saveInProgress.value = false;
        alert("5001 No blog selected");
        return null;
      }
      post.header = outputData.header;
      post.time = new Date();
      post.authorId = 1;
      post.status = "published";
      post.name = `${outputData.header}_${new Date().getDate().toString()}_${new Date().getSeconds().toString()}`;
      post.body = outputData.blocks;
      try {
        if ((await post.save()) === 200) {
          saveInProgress.value = false;
          router.push({
            name: "Posts Overview",
            params: { postName: post.name }
          });
        } else {
          saveInProgress.value = false;
          alert("5003 Unable to save post. Please try again.");
        }
      } catch {
        saveInProgress.value = false;
        alert("5004 Unable to save post. Please try again.");
      }
    }

    const headerContainsContent = ref(false);

    function onHeaderEmpty() {
      headerContainsContent.value = false;
    }

    function onHeaderNotEmpty() {
      headerContainsContent.value = true;
    }

    return {
      saveArticle,
      trigger,
      triggerArticleSave,
      onHeaderEmpty,
      onHeaderNotEmpty,
      headerContainsContent,
      saveInProgress
    };
  }
};
</script>
