<template>
  <div class="row">
    <Nav class="col-4" />
    <router-view class="col-8"> </router-view>
  </div>
</template>

<script lang="ts">
import Nav from "./components/nav.vue";
export default {
  components: { Nav }
};
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
