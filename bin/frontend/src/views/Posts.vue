<template>
  <div>
    <h1 class="h1-responsive">Posts</h1>
    <div class="container">
      <div class="list-group">
        <router-link
          :to="`/posts/${post.name}/overview`"
          v-for="post of posts"
          :key="post.id"
          class="list-group-item list-group-item-action"
        >
          <PostsItem :post="post" />
        </router-link>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { ref } from "vue";
import Blog from "../methods/blog";
import PostsItem from "./PostsItem.vue";

export default {
  components: { PostsItem },
  name: "PostsView",

  setup() {
    const posts: any = ref(null);
    const getPosts = async () => {
      const temp = await new Blog().getPosts();
      posts.value = temp;
    };
    getPosts();

    return { posts };
  }
};
</script>
