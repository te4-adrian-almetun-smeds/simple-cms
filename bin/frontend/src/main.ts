import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";

createApp(App)
  .use(router)
  .mount("#app");

class Post {
  private _header: string | null;
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

  public set status(input: string){
    this._status = input;
  }

  public get header(): string | null {
    return this._header;
  }

  public set header(input: string | null) {
    this._header = input;
  }

  public get author(): number {
    return this._author
  }

  public set author(input: number){
    this._author = input;
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

  public set name(input: string) {
    this._name = input;
  }

  constructor() {
    this._header = null;
    this._status = "draft";
    this._body = "";
    this._author = 0;
    this._time = "2000-12-12T12:12:12.120Z";
    this._name = "abcd";
  }

  public static async get(name: string | string[]) {
    const temp = await fetch(`http://localhost:9292/api/blogs/1/posts/${name}`);
    const elements = await temp.json();
    const x = new Post();
    x.setData(elements[0]);
    return x;
  }

  public setData(attributes: Record<string, any>) {
    Object.keys(attributes).forEach((key) => {
      const value = attributes[key]
      switch (key) {
        case 'header':
          this.header = value;
          break;
        case 'postStatus':
          this.status = value;
          break;
        case 'body':
          this.body = value;
          break;
        case 'authorId':
          this.author = value;
          break;
        case 'time':
          console.log("Did not update time")
          // this.time = value;
          break;
        case 'postName':
          this.name = value;
          break;
        default:
          console.log(key)
          console.log('Some data was excluded')
      }
    })
  }
}

class Blog {
  private _posts: any;

  public get posts() {
    return this._posts;
  }

  async getPosts() {
    const temp = await fetch("http://localhost:9292/api/blogs/1/posts");
    const temporary = await temp.json();
    const out: Post[] = [];
    temporary.forEach((element: { body: string }) => {
      const x = new Post();
      x.setData(element)
      out.push(x);
    });
    return out;
  }
}
export { Blog, Post };
