import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
// import Post from "./methods/posts"
// import Blog from "./methods/blog"

const app = createApp(App)
app.use(router)
app.mount("#app");
