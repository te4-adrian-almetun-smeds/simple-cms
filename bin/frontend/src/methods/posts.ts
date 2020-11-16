class Post {
  private _header: string | null;
  private _status: string;
  private _body: any;
  private _authorId: number;
  private _time: Date;
  private _name: string;
  private _blogId: number;
  private _parent: number | null;

  public set body(input: any) {
    this._body = input;
  }

  public get body(): any {
    return { blocks: this._body };
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
    console.log("Should return a author instance.");
    return this._authorId;
  }

  public set authorId(input: number){
    this._authorId = input;
  }

  public get blogId(): number {
    return this._blogId;
  }

  public set blogId(input: number){
    this._blogId = input;
  }

  public get parent(): number | null {
    return this._parent;
  }

  public set parent(input: number | null) {
    this._parent = input;
  }

  public get time(): any {
    return this._time
      .toISOString()
      .slice(0, 16)
      .replace("T", " ");
  }

  public set time(input: any) {
    this._time = input;
  }

  public get name(): string {
    return this._name;
  }

  public set name(input: string) {
    input = input.replace(/([^a-zA-Z0-9_])+/g, "_").toLowerCase();
    this._name = input;
  }

  constructor() {
    this._header = null;
    this._status = "draft";
    this._body = "";
    this._authorId = 0;
    this._time = new Date("2000-12-12T12:12:12.120Z");
    this._name = "abcd";
    this._blogId = 0;
    this._parent = null;
  }

  public static async get(name: string | string[], blogId: number) {
    const baseUrl = `${window.location.protocol}//${window.location.hostname}`;
    const temp = await fetch(
      `${baseUrl}:9292/api/blogs/${blogId}/posts/${name}`
    );
    const elements = await temp.json();
    const x = new Post();
    console.log("Elements", elements)
    x.setData(elements[0]);
    return x;
  }

  public async delete() {
    const baseUrl = `${window.location.protocol}//${window.location.hostname}`;
    try {
      const temp = await fetch(
        `${baseUrl}:9292/api/blogs/1/posts/${this._name}`,
        {
          method: "DELETE"
        }
      );
      return temp.status;
    } catch {
      return new Error("Unable to delete post");
    }
  }

  public setData(attributes: Record<string, any>) {
    console.log(attributes);
    Object.keys(attributes).forEach((key) => {
      const value = attributes[key]
      switch (key) {
        case "header":
          this.header = value;
          break;
        case "postStatus":
          this.status = value;
          break;
        case "body":
          this.body = JSON.parse(value);
          break;
        case "authorId":
          this.authorId = value;
          break;
        case "blogId":
          this.blogId = value;
          break;
        case "time":
          this.time = new Date(value);
          break;
        case "postName":
          this.name = value;
          break;
        case "postParent":
          this.parent = value;
          break;
        default:
          console.log(key)
          console.log("Some data was excluded");
      }
    });
  }

  async save() {
    const data = {
      header: this._header,
      postStatus: this._status,
      body: JSON.stringify(this._body),
      blogId: this._blogId,
      authorId: this._authorId,
      time: this._time,
      postName: this._name,
      postParent: this._parent
    };
    console.log("Article data", data);
    const baseUrl = `${window.location.protocol}//${window.location.hostname}`;
    const temp = await fetch(`${baseUrl}:9292/api/blogs/${this._blogId}/posts`, {
        method: "POST",
        body: JSON.stringify(data)
      }
    );
    await temp.text();
    return temp.status;
  }
}
export default Post;
