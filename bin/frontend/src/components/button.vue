<template>
  <button :type="type" class="btn" @click="$emit('clicked')">
    <i v-if="icon !== ''" :class="`fas ${icon} mr-1`"></i>
    {{ text }}
  </button>
</template>

<script lang="ts">
export default {
  name: "Button",
  props: {
    text: {
      type: String,
      default: "Save"
    },
    type: {
      type: String,
      default: "button"
    },
    icon: {
      type: String,
      default: ""
    }
  }
};
</script>
