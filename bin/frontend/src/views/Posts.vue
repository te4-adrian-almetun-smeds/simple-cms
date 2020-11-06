<template>
  <div>
    <h1>Posts</h1>
    <table>
      <tr>
        <th>Header</th>
        <th>status</th>
      </tr>
      <tr v-for="post of posts" :key="post.id">
        <a :href="`/posts/${post.name}`">
          <td>{{ post.header }}</td>
          <td>{{ post.status }}</td>
        </a>
      </tr>
    </table>

    <p>{{ posts }}</p>
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
