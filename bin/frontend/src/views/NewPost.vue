<template>
  <div class="home">
    <h1 class="h1-responsive">Create a new Post</h1>
    <TextEditor>
      <footer class="float-right">
        <Button class="btn-primary" icon="fa-pen" text="Save"/>
      </footer>
    </TextEditor>
  </div>
</template>

<script lang="ts">
import { Options, Vue } from "vue-class-component";
import TextEditor from "@/components/TextEditor.vue"; // @ is an alias to /src
import Button from "@/components/button.vue";

@Options({
  components: {
    TextEditor,
    Button
  }
})

export default class NewPost extends Vue {}
</script>
