class Post {
  private _header: string | null;
  private _status: string;
  private _body: any;
  private _author: number;
  private _time: Date;
  private _name: string;

  public set body(input: any) {
    input = JSON.parse(`${input}`)
    this._body = {blocks: input};
  }

  public get body(): any {
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

  public get time(): any {
    return this._time.toISOString().slice(0, 16).replace('T', ' ');
  }

  public set time(input: any) {
    this._time = input;
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
    this._time = new Date("2000-12-12T12:12:12.120Z");
    this._name = "abcd";
  }

  public static async get(name: string | string[]) {
    const temp = await fetch(`http://localhost:9292/api/blogs/1/posts/${name}`);
    const elements = await temp.json();
    const x = new Post();
    x.setData(elements[0]);
    return x;
  }

  public async delete() {
    try {
      const temp = await fetch(
        `http://localhost:9292/api/blogs/1/posts/${this._name}`,
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
          this.time = new Date(value);
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
export default Post