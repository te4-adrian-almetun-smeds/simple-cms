<template>
  <div class="row">
    <div class="col text-truncate">
      {{ post.header }}
    </div>
    <div class="col">
      {{ post.status }}
    </div>
    <div class="col">
      {{ post.time }}
    </div>
  </div>
</template>

<script lang="ts">
export default {
  name: "PostItem",
  props: ["post"]
};
</script>

<style lang="scss" scoped>
.col {
  text-align: left;
}
</style>
