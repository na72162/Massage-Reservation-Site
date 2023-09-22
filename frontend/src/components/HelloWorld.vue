<template>
  <div>
    {{ message }}
  </div>
</template>

<script lang="ts">
import axios from 'axios';
import { defineComponent, ref } from 'vue';

export default defineComponent({
  name: 'MyComponent',

  setup() {
    const message = ref<string>('');

    const fetchData = async () => {
      try {
        const response = await axios.get('http://localhost:3000/hello/world');
        message.value = response.data.message;
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();

    return {
      message
    };
  }
});
</script>

<style scoped>
</style>

