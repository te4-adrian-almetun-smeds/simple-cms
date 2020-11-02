<template>
  <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link>
  </div>
</template>

<script lang="ts">
import { Vue } from 'vue-property-decorator'

export default class Nav extends Vue {}
</script>
