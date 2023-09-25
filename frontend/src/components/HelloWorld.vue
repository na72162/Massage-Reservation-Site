<template>
  <div>
    {{ message }}
    <p>{{ msg }}</p>
  </div>
</template>

<script lang="ts">
import axios from 'axios';
import { defineComponent, ref, PropType, onMounted } from 'vue';
// import HelloWorld from '@/components/HelloWorld.vue'; // @ is an alias to /src

// @Options({
//   components: {
//     HelloWorld,
//   },
// })
interface Props {
  msg: string;
}

export default defineComponent({
  name: 'MyComponent',

  setup() {
    const message = ref<string>('');
    const fetchData = async () => {
      try {
        // const response = await axios.get('http://localhost:3000/hello/world');
        // message.value = response.data.message;

        // const message = ref({ text: '' });

        axios.get('http://localhost:3000/message')
        .then(response => {
          message.value = response.data.text;
        });
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();

    return {
      message
    };
  },

  props: {
    msg: {
      type: String as PropType<Props['msg']>,
      required: true
    }
  }
});
</script>

<style lang="scss" scoped>
</style>

