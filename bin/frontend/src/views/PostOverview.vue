<template>
  <div>
    <h1 class="h1-responsive">Post Overview</h1>
    <div class="container" v-if="post != null">
      <div class="container">
        <TextEditor :header="post.header" :data="post.body" buttonText="Update"/>
      </div>
      <router-link  :to="`/posts/${post.name}/delete`">
        <button type="button" class="btn btn-danger">
          <i class="fas fa-trash mr-1"></i>
          Delete
        </button>
      </router-link>
    </div>
  </div>
</template>

<script lang="ts">
import { Options, Vue } from "vue-class-component";
import Post from "../methods/posts";
import TextEditor from "@/components/TextEditor.vue"; // @ is an alias to /src

@Options({
  components: {
    TextEditor
  }
})

export default class PostsOverview extends Vue {
  post: Post | null = null;

  async mounted?() {
    console.log('Hello world')
    this.post = await Post.get(this.$route.params.postName) // Create a post based on the provided postName
  }
}
</script>

<style lang="scss" scoped>
h2 {
  font-size: 1.5rem;
  font-weight: bold;
}
</style>