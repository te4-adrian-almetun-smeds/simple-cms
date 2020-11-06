<template>
  <div>
    <h1 class="h1-responsive">Post Overview</h1>
    <div class="container" v-if="post != null && post.header != null">
      <h2 class="h2-responsive">{{post.header}}</h2>
      <a href="/edit">
        <button type="button" class="btn btn-primary">
          <i class="fas fa-trash mr-1"></i>
          Edit
        </button>
      </a>
      <a href="/abc">
        <button type="button" class="btn btn-danger">
          <i class="fas fa-trash mr-1"></i>
          Delete
        </button>
      </a>
    </div>
  </div>
</template>

<script lang="ts">
import { Vue } from "vue-class-component";
import {  Post } from "../main";

export default class PostsOverview extends Vue {
  post: Post | null = null;

  async mounted?() {
    console.log('Hello world')
    this.post = await new Post() // Create a post based on the provided postName
  }
}
</script>
