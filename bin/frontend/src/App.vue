<template>
  <Header @update="onUpdate" />
  <div class="row">
    <Nav class="col-4" />
    <router-view class="col-8 content" :updater="key"> </router-view>
  </div>
</template>

<script lang="ts">
import Nav from "./components/nav.vue";
import Header from "./components/Header.vue";
import { ref } from "vue";
export default {
  components: { Nav, Header },
  setup() {
    const key = ref(true);
    const onUpdate = () => {
      key.value = !key.value;
    };

    return { key, onUpdate };
  }
};
</script>

<style lang="scss">
#app {
  font-family: "Roboto", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  width: 100%;
}
.content {
  padding-top: 4px;
}
</style>
