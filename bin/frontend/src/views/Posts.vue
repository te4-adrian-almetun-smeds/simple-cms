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
import PostsItem from './PostsItem.vue';

  components: { PostsItem },

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