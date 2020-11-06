<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png" />
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
