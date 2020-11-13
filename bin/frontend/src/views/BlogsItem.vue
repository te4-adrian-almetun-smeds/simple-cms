<template>
  <div class="row">
    <div class="col text-truncate">
      {{ blog.name }}
    </div>
  </div>
</template>

<script lang="ts">
export default {
  name: "PostItem",
  props: ["blog"]
};
</script>

<style lang="scss" scoped>
.col {
  text-align: left;
}
</style>
