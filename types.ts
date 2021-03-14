export type RawPost = {
  date: string,
  title: string,
  subtitle: string,
  updated: string,
  location: string,
  tags: string[],
  description: string,
}

export type Post = RawPost & {
  link: string
}
