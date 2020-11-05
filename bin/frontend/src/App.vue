<template>
  <div class="row">
    <Nav class="col-4"/>
    <router-view class="col-8"> </router-view>
  </div>
</template>

<script lang="ts">
// import { onMounted } from 'vue'
import { Options, Vue } from 'vue-class-component'
import Nav from "./components/nav.vue"

@Options({
  components: {
    Nav
  }
})

export default class App extends Vue {}
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  display: grid;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
