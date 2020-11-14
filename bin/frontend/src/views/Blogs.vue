<template>
  <div>
    <h1 class="h1-responsive">Blogs</h1>
    <div class="container" v-if="blogs && blogs.length > 0">
      <div class="list-group">
        <router-link
          :to="`/blogs/${blog.id}`"
          v-for="blog of blogs"
          :key="blog.id"
          class="list-group-item list-group-item-action"
        >
          <BlogsItem :blog="blog" />
        </router-link>
        <Button
          class="btn-primary"
          icon="fa-pen"
          text="Create a new blog"
          @clicked="newBlog"
        />
      </div>
    </div>
    <div class="container" v-else>
      <h2 class="responsive-h2">No Blogs</h2>
    </div>
  </div>
</template>

<script lang="ts">
import { ref, watch } from "vue";
import Blog from "../methods/blog";
import BlogsItem from "@/components/BlogsItem.vue";
import Button from "@/components/button.vue";
import { useRouter } from "vue-router";

export default {
  name: "PostsView",
  props: ["updater"],
  components: { BlogsItem, Button },

  setup(props: any) {
    const router = useRouter();

    const blogs: any = ref(null);
    const getBlogs = async () => {
      const temp = await Blog.get();
      blogs.value = temp;
    };
    getBlogs();

    const newBlog = () => {
      router.push("/pages/new");
    };

    watch(
      () => props.updater,
      async (__count__, __prevCount__) => {
        getBlogs();
      }
    );

    return { blogs, newBlog };
  }
};
</script>
