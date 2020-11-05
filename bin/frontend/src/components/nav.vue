<template>
  <nav id="nav" class="elegant-color text-white">
    <ul class="nav flex-column">
      <li class="nav-item">
        <router-link to="/">Dashboard</router-link>
      </li>
      <li class="nav-item dropdown">
        <router-link to="/posts">Posts</router-link>
        <div class="dropdown-content">
          <router-link to="/posts/new">New Post</router-link>
        </div>
      </li>
      <li class="nav-item">
        <router-link to="/media">Media</router-link>
      </li>
      <li class="nav-item">
        <router-link to="/pages">Pages</router-link>
      </li>
      <li class="nav-item">
        <router-link to="/settings">Settings</router-link>
      </li>
      <li class="nav-item">
        <router-link to="/about">About</router-link>
      </li>
    </ul>
  </nav>
</template>

<style lang="scss" scoped>
li {
  padding-left: 10px;
  text-align: left;
}
nav {
  min-height: 100vh;
  height: 100%;
  a {
    color: inherit !important;
  }
  .router-link-active {
    color: #3F729B !important;
  }
}
</style>

<script lang="ts">
import { Vue } from "vue-class-component";

export default class Nav extends Vue {
  // public name = "Nav"
  // constructor() {
  //   // super()
  //   this.name = 'Nav'
  // }
}
</script>
