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
    component: () => import(/* webpackChunkName: "about" */ "../views/Posts.vue")
  },
  {
    path: "/posts/new",
    name: "New Post",
    component: () => import("../views/NewPost.vue")
  },
  {
    path: "/posts/:postName/overview",
    name: "Posts Overview",
    component: () => import("../views/PostOverview.vue")
  },
  {
    path: "/about",
    name: "About",
    component: () => import("../views/About.vue")
  },
  {
    path: "/:pathMatch(.*)",
    name: "404",
    component: () => import("../views/404.vue")
  }
];

const router = createRouter({
  history: createWebHashHistory(),
  routes
});

export default router;
