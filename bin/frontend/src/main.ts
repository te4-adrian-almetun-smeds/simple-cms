import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";

createApp(App)
  .use(router)
  .mount("#app");

class Post {
  private _header: string;
  private _status: string;
  private _body: string;
  private _author: number;
  private _time: string;
  private _name: string;

  public set body(input: string) {
    this._body = input;
  }

  public get body(): string {
    return this._body;
  }

  public get status(): string {
    return this._status;
  }

  public get header(): string {
    return this._header;
  }

  public get author(): string {
    // return new User(this._author)
    console.log(this._author);
    return "Administrator";
  }

  public get time(): Date {
    return new Date(this._time);
  }

  public set time(input: Date) {
    this._time = input.toISOString();
    // return new Date(this._time)
  }

  public get name(): string {
    return this._name;
  }

  constructor() {
    this._header = "";
    this._status = "draft";
    this._body = "";
    this._author = 0;
    this._time = "2000-12-12T12:12:12.120Z";
    this._name = "abcd";
  }
}

class Blog {
  private _posts: any;

  public get posts() {
    return this._posts;
  }

  async getPosts() {
    const temp = await fetch("http://localhost:9292/api/blogs/1/posts");
    console.log(temp);
    const temporary = await temp.json();
    const out: Post[] = [];
    temporary.forEach((element: { body: string }) => {
      const x = new Post();
      x.body = element.body;
      out.push(x);
    });
    return out;
  }
}
export { Blog, Post };
