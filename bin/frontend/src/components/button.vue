<template>
  <button :type="type" class="btn {{classes}}" @click="addArticle">
    <i v-if="icon !== ''" :class="`fas ${icon} mr-1`"></i>
    {{text}}
  </button>
</template>

<script lang="ts">

export default {
  props: {
    text: {
      type: String,
      default: 'Save'
      },
    type: {
      type: String,
      default: 'button'
    },
    classes: {
      type: String,
      default: 'btn-primary'
    },
    icon: {
      type: String,
      default: ''
    }
  }
}
</script>
