<template>
  <Header :key="key" @update="onUpdate" />
  <div class="row">
    <Nav class="col-4" />
    <router-view
      :key="key2"
      class="col-8 content"
      @reload-header="onReloadHeader"
    >
    </router-view>
  </div>
</template>

<script lang="ts">
import Nav from "./components/nav.vue";
import Header from "./components/Header.vue";
import { ref } from "vue";
import { useRoute } from "vue-router";

export default {
  components: { Nav, Header },
  setup() {
    const route = useRoute();
    const key = ref(true);
    const key2 = ref(true);
    const onReloadHeader = () => {
      key.value = !key.value;
    };

    const onUpdate = () => {
      if (!route.path.includes("/new")) {
        key2.value = !key2.value;
      }
    };

    return { key, key2, onUpdate, onReloadHeader };
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
