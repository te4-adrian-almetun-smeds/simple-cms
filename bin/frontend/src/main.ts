import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
// import Post from "./methods/posts"
// import Blog from "./methods/blog"

createApp(App)
  .use(router)
  .mount("#app");
