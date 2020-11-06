import { createRouter, createWebHashHistory, RouteRecordRaw } from "vue-router";
import Home from "../views/Home.vue";

const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: "Home",
    component: Home
  },
  {
    path: "/posts",
    name: "Posts",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/Posts.vue")
  },
  {
    path: "/posts/new",
    name: "New Posts",
    component: () => import("../views/NewPost.vue")
  }
];

const router = createRouter({
  history: createWebHashHistory(),
  routes
});

export default router;
