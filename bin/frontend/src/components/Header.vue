<template>
  <header class="white sticky-top">
    <h3 class="text-dark h3-responsive">Simple CMS</h3>

    <a
      class="btn text-dark dropdown-toggle mr-4"
      type="button"
      data-toggle="dropdown"
      aria-haspopup="true"
      aria-expanded="false"
    >
      {{ currentBlog.name }}
    </a>

    <div v-if="blogs">
      <div class="dropdown-menu" v-for="blog in blogs" :key="blog">
        <a class="dropdown-item" @click="changeBlog(blog.id)">
          {{ blog.name }}
        </a>
      </div>
    </div>
    <div v-else>
      <div class="dropdown-menu">
        <a class="dropdown-item">Create a Blog to get started</a>
      </div>
    </div>
    <div id="user">
      <button type="button" class="btn btn-md xyz float-right rounded-circle">
        <i class="fas fa-user"></i>
      </button>
    </div>
  </header>
</template>

<script lang="ts">
import store from "@/store";
import { ref } from "vue";
export default {
  name: "Header",
  setup(prop: any, { emit }: any) {
    const currentBlog = ref(store.getters.blog);

    const blogs = ref([{ id: 0 }]);
    const getBlogs = async () => {
      const temp = await fetch("http://localhost:9292/api/blogs");
      blogs.value = await temp.json();
    };
    getBlogs();

    const changeBlog = (id: number) => {
      currentBlog.value = blogs.value.find(x => x.id === id);
      store.commit("setBlog", currentBlog.value);
      emit("update");
    };
    return { changeBlog, blogs, currentBlog };
  }
};
</script>

<style lang="scss" scoped>
* {
  text-align: left;
  .xyz {
    width: 40px;
  }
  header {
    padding: 4px;
    display: grid;
    grid-template-columns: repeat(4, auto);
    width: 100%;
    top: 0;
    z-index: 99;
    border-bottom: black 1px solid;
    #user button {
      width: 45px;
      height: 45px;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
    }
  }
}
</style>
