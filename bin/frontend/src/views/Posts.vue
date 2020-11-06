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
          <router-link to="/abc">
            <button type="button" class="btn btn-danger">
              <i class="fas fa-trash mr-1"></i>
              Delete
            </button>
          </router-link>
        </div>
      </div>
      </router-link>
      </div>
    </div>
    <!-- <p>{{ posts }}</p> -->
  </div>
</template>

<script lang="ts">
import { Vue } from "vue-class-component";
import { Blog, Post } from "../main";

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