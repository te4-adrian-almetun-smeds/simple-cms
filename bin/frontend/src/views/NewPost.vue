<template>
  <div class="home">
    <h1>Create a new Post</h1>
    <TextEditor/>
  </div>
</template>

<script lang="ts">
import { Options, Vue } from "vue-class-component";
import TextEditor from "@/components/TextEditor.vue"; // @ is an alias to /src

@Options({
  components: {
    TextEditor
  }
})
export default class NewPost extends Vue {}
</script>
