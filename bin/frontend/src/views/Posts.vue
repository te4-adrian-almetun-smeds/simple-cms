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
import { ref, watch } from "vue";
import Blog from "../methods/blog";
import PostsItem from "./PostsItem.vue";
import store from "@/store";

export default {
  components: { PostsItem },
  name: "PostsView",
  props: ["updater"],

  setup(props: any) {
    const posts: any = ref(null);
    const getPosts = async () => {
      const temp = await Blog.getPosts(store.getters.blog.id);
      posts.value = temp;
    };
    getPosts();
    watch(
      () => props.updater,
      async (__count__, __prevCount__) => {
        getPosts();
      }
    );

    return { posts };
  }
};
</script>
