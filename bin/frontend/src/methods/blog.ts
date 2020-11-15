import Post from "./posts"

class Blog {
  private _name: string;
  private _id: string;

  public get name() {
    return this._name;
  }
  public set name(x: string) {
    this._name = x;
  }
  public get id() {
    return this._id;
  }

  constructor() {
    this._id = "";
    this._name = "";
  }

  static async get() {
    const baseUrl = `${window.location.protocol}//${window.location.hostname}`;
    const temp = await fetch(`${baseUrl}:9292/api/blogs`);
    const temporary = await temp.json();
    const out: Blog[] = [];
    temporary.forEach((element: { body: string }) => {
      const x = new Blog();
      x.setData(element)
      out.push(x);
    });
    return out;
  }

  public setData(attributes: Record<string, any>) {
    Object.keys(attributes).forEach(key => {
      const value = attributes[key];
      switch (key) {
        case "name":
          this._name = value;
          break;
        case "id":
          this._id = value;
          break;
        default:
          console.log(key)
          console.log("Some data was excluded");
      }
    })
  }

  static async getPosts(id: string) {
    const baseUrl = `${window.location.protocol}//${window.location.hostname}`;
    const temp = await fetch(`${baseUrl}:9292/api/blogs/${id}/posts`);
    const temporary = await temp.json();
    const out: Post[] = [];
    temporary.forEach((element: { body: string }) => {
      const x = new Post();
      x.setData(element)
      out.push(x);
    });
    return out;
  }

  async save() {
    const data = {
      name: this._name
    };
    const baseUrl = `${window.location.protocol}//${window.location.hostname}`;
    const temp = await fetch(`${baseUrl}:9292/api/blogs`, {
      method: "POST",
      body: JSON.stringify(data)
    });
    return await temp.text();
  }
}

export default Blog