<template>
  <div>
    <h1 class="h1-responsive">Posts</h1>
    <div class="container" v-if="posts && blog !== 0">
      <div class="list-group">
        <router-link
          :to="`/posts/${post.name}/overview`"
          v-for="post of posts"
          :key="post.id"
          class="list-group-item list-group-item-action"
        >
          <PostsItem :post="post" />
        </router-link>
        <Button
          class="btn-primary"
          icon="fa-pen"
          text="Create a new post"
          @clicked="newPost"
        />
      </div>
    </div>
    <div class="container" v-else>
      <h2 class="responsive-h2">No posts for selected blog</h2>
    </div>
  </div>
</template>

<script lang="ts">
import { ref, watch } from "vue";
import Blog from "../methods/blog";
import Button from "@/components/button.vue";
import PostsItem from "@/components/PostsItem.vue";
import store from "@/store";
import { useRouter } from "vue-router";

export default {
  components: { PostsItem, Button },
  name: "PostsView",
  props: ["updater"],

  setup(props: any) {
    const router = useRouter();
    const blog: any = ref(null);
    const posts: any = ref(null);
    const getPosts = async () => {
      blog.value = store.getters.blog.id;
      const temp = await Blog.getPosts(blog.value);
      posts.value = temp;
    };
    getPosts();

    const newPost = () => {
      router.push("/posts/new");
    };

    watch(
      () => props.updater,
      async (__count__, __prevCount__) => {
        getPosts();
      }
    );

    return { posts, blog, newPost };
  }
};
</script>
