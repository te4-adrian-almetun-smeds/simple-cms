<template>
  <div>
    <h1 class="h1-responsive">Post Overview</h1>
    <div class="container" v-if="post != null">
      <div class="container">
        <TextEditor
          :header="post.header"
          :data="post.body"
          :trigger="trigger"
          @save="updatePost"
          @header-empty="onHeaderEmpty"
          @header-not-empty="onHeaderNotEmpty"
        >
          <footer class="float-right">
            <Button
              type="submit"
              class="btn-danger btn-sm"
              icon="fa-trash"
              text="Delete"
              @clicked="deletePost"
            />
            <Button
              class="btn-primary btn-sm"
              :class="{ disabled: !headerContainsContent }"
              icon="fa-pen"
              text="Update Post"
              :spinner="saveInProgress"
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
import { useRoute, useRouter } from "vue-router";

export default {
  name: "PostsOverview",
  components: {
    TextEditor,
    Button
  },
  setup(props: any, { emit }: any) {
    const route = useRoute();
    const router = useRouter();
    const headerContainsContent = ref(false);

    // Handles a post
    const post: any = ref(null);
    const getPost = async () => {
      const temp = await Post.get(route.params.postName);
      post.value = temp;
      headerContainsContent.value = post.value.header.length !== 0;
    };
    getPost();

    // Handles saving the post
    const trigger = ref(false);
    const saveInProgress = ref(false);
    function triggerPostUpdate() {
      saveInProgress.value = true;
      trigger.value = !trigger.value;
      console.log("Save in progress");
    }

    function updatePost(data: any) {
      // Make a request to the CMS API
      console.log("This should update");
      saveInProgress.value = false;
    }

    async function deletePost() {
      if ((await post.value.delete()) === 200) {
        router.push({ name: "Posts" });
      } else {
        emit("error", { code: 5002, message: "Failed to delete post" });
      }
    }

    function onHeaderEmpty() {
      headerContainsContent.value = false;
    }

    function onHeaderNotEmpty() {
      headerContainsContent.value = true;
    }

    return {
      post,
      triggerPostUpdate,
      trigger,
      updatePost,
      deletePost,
      onHeaderEmpty,
      onHeaderNotEmpty,
      headerContainsContent,
      saveInProgress
    };
  }
};
</script>

<style lang="scss" scoped>
h2 {
  font-size: 1.5rem;
  font-weight: bold;
}
</style>
