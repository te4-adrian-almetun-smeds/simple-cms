import { createStore } from "vuex";

export default createStore({
  state: {
    blog: { id: 0, name: "Select Blog" }
  },
  mutations: {
    setBlog(state, payload) {
      state.blog = payload;
    }
  },
  getters: {
    blog: (state, getters) => {
      return state.blog;
    }
  },
  actions: {},
  modules: {}
});
