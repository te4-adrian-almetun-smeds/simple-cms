<template>
  <button :type="type" class="btn" @click="$emit('clicked')">
    <span
      class="spinner-border spinner-border-sm"
      role="status"
      aria-hidden="true"
      v-show="spinner"
    >
    </span>
    <i v-if="icon !== '' && !spinner" :class="`fas ${icon} mr-1`"></i>
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
    spinner: {
      type: Boolean,
      default: false
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
