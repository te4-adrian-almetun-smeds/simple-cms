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
  position: sticky;
  top: 0;
  left: 0;
  font-weight: bold;
  min-height: 100vh;
  overflow: scroll;
  a {
    color: inherit !important;
    &.router-link-exact-active {
      color: #3f729b !important;
    }
  }
}
</style>

<script lang="ts">
export default {
  name: "Nav"
}
</script>
