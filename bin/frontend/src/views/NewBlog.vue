<template>
  <div class="home">
    <h1 class="h1-responsive">Create a new Post</h1>
    <input type="text" name="name" placeholder="Blog name" v-model="name" />
    <div class="float-right">
      <Button
        class="btn-primary"
        :class="{ disabled: !headerContainsContent }"
        icon="fa-pen"
        text="Create"
        :spinner="saveInProgress"
        @clicked="createBlog"
      />
    </div>
  </div>
</template>

<script lang="ts">
import Button from "@/components/button.vue";
import { ref, watch } from "vue";
import Blog from "@/methods/blog";
// import store from "@/store";
import { useRouter } from "vue-router";

export default {
  name: "New Blog",
  components: {
    Button
  },
  setup(props: any, { emit }: any) {
    const router = useRouter();
    const saveInProgress = ref(false);
    const headerContainsContent = ref(false);
    const name = ref("");

    async function createBlog() {
      saveInProgress.value = true;
      const temp = new Blog();
      temp.name = name.value;
      console.log(await temp.save());
      emit("reload-header");
      saveInProgress.value = false;
      router.push({ name: "Pages" });
    }

    function onHeaderEmpty() {
      headerContainsContent.value = false;
    }

    function onHeaderNotEmpty() {
      headerContainsContent.value = true;
    }

    watch(
      () => name.value,
      async (newVal, __prevVal__) => {
        if (newVal.length === 0) {
          onHeaderEmpty();
        } else {
          onHeaderNotEmpty();
        }
      }
    );

    return {
      name,
      createBlog,
      onHeaderEmpty,
      onHeaderNotEmpty,
      headerContainsContent,
      saveInProgress
    };
  }
};
</script>

<style lang="scss" scoped>
input, input:focus {
  border: none;
  outline: none;
  width: 100%;
  font-size: 1.5rem;
  font-weight: bold;
}
</style>
