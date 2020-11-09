<template>
  <div>
    <h1 class="h1-responsive">Posts</h1>
    <div class="container">
    <div class="list-group">
      <router-link :to="`/posts/${post.name}/overview`" v-for="post of posts" :key="post.id" class="list-group-item list-group-item-action">
      <div class="row">
        <div class="col text-truncate">
          {{post.header}}
        </div>
        <div class="col">
          {{post.status}}
        </div>
        <div class="col">
          {{post.time}}
        </div>
      </div>
      </router-link>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Vue } from "vue-class-component";
import Blog from '../methods/blog'
import Post from '../methods/posts'

export default class PostsView extends Vue {
  posts: Post[] | null = null;

  async mounted?() {
    this.posts = await new Blog().getPosts();
  }
}
</script>

<style lang="scss" scoped>
.col {
  text-align: left;
}
button {
  z-index: 100;
}

</style>