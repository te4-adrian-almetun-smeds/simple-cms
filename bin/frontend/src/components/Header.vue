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
      {{ currentBlog }}
    </a>

    <div v-if="blogs">
      <div class="dropdown-menu" v-for="blog in blogs" :key="blog">
        <a class="dropdown-item" href="#">Blog {{ blog.id }}</a>
        <a class="dropdown-item" href="#">Another action</a>
        <a class="dropdown-item" href="#">Something else here</a>
      </div>
    </div>
    <div v-else>
      <div class="dropdown-menu">
        <a class="dropdown-item">Create a Blog to get started</a>
      </div>
    </div>
    <!--Slack-->
    <button type="button" class="btn btn-md xyz justify-content-center align-items-center">
      <i class="fas fa-user"></i>
    </button>
  </header>
</template>

<script>
export default {
  name: "Header",
  props: {
    blogs: {},
    currentBlog: {
      default: "No blog selected",
      type: String
    }
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
    grid-template-columns: repeat(3, auto);
    width: 100%;
    top: 0;
    z-index: 99;
    border-bottom: black 1px solid;
  }
}
</style>
