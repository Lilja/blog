<template>
  <div>
    <h1>My blog posts</h1>
    <ul>
      <li v-for="post in posts" :key="post.title">
        <nuxt-link :to="constructPermaLink(post)">
          {{ post.title }}
        </nuxt-link>
      </li>
    </ul>
  </div>
</template>
<script>
const fm = require('front-matter')
export default {
  asyncData () {
    const resolve = require.context('~/contents/', true, /\.md$/)
    const imports = resolve.keys().map((key) => {
      const [, name] = key.match(/\/(.+)\.md$/)
      const attributes = fm(resolve(key).default).attributes
      const permalink = { link: name }
      return Object.assign({}, attributes, permalink)
    })
    return {
      posts: imports
    }
  },
  data () {
    return {
      prefix: 'posts'
    }
  },
  methods: {
    constructPermaLink (post) {
      return `${this.prefix}/${post.link}`
    }
  }
}
</script>
