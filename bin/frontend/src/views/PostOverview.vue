<template>
  <div>
    <h1 class="h1-responsive">Post Overview</h1>
    <div class="container" v-if="post != null">
      <div class="container">
        <TextEditor
          :header="post.header"
          :data="post.body"
          :trigger="trigger"
          @save="savePost"
        >
          <footer class="float-right">
            <Button
              type="submit"
              class="btn-danger btn-sm"
              icon="fa-trash"
              text="Delete"
            />
            <Button
              class="btn-primary btn-sm"
              icon="fa-pen"
              text="Save"
              @clicked="triggerPostUpdate"
            />
          </footer>
        </TextEditor>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Post from "../methods/posts";
import TextEditor from "@/components/TextEditor.vue"; // @ is an alias to /src
import Button from "@/components/button.vue";
import { ref } from "vue";
import { useRoute } from "vue-router";

export default {
  name: "PostsOverview",
  components: {
    TextEditor,
    Button
  },
  setup() {
    const route = useRoute();

    // Handles a post
    const post: any = ref(null);
    const getPost = async () => {
      const temp = await Post.get(route.params.postName);
      post.value = temp;
    };
    getPost();

    // Handles saving the post
    const trigger = ref(false);
    function triggerPostUpdate() {
      trigger.value = !trigger.value;
      console.log("Save in progress");
    }

    function updatePost(data: any) {
      // Make a request to the CMS API
      console.log("This should update");
    }

    return { post, triggerPostUpdate, trigger, updatePost };
  }
};
</script>

<style lang="scss" scoped>
h2 {
  font-size: 1.5rem;
  font-weight: bold;
}
</style>