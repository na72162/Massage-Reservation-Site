<template>
  <div class="home">
    <!-- ここの箇所はシングルファイルコンポーネントという
    msg="Welcome to Your Vue.js + TypeScript App"の箇所はmsgプロパティという。-->
    <HelloWorld msg="Welcome to Your Vue.js + TypeScript App"/>
    <div>こんにちは</div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import HelloWorld from '../components/HelloWorld.vue'

export default defineComponent({
  name: 'HomeView',
  components: {
    HelloWorld
  }
});
</script>
<style lang="scss" scoped>
// ここにSCSSのコード
</style>
