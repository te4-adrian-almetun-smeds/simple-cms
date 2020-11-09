import Post from "./posts"

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

export default Blog