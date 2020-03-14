<template>
  <div role="main" class="blog-birdsview">
    <navbar />
    <div class="container">
      <div class="columns">
        <div class="column is-8 is-offset-2">
          <ul>
            <li v-for="post in posts" :key="post.title" class="blog-post-birdsview">
              <h1 class="title">
                <nuxt-link
                  :to="constructPermaLink(post)"
                  class="blog-title"
                >
                  {{ post.title }}
                </nuxt-link>
              </h1>
              <time :datetime="post.date">
                {{ isodate(post.date) }}
              </time>
              {{ post.description }}
              <hr class="blog-separator"></hr>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import navbar from '~/pages/navbar'
const fm = require('front-matter')
export default {
  components: {
    navbar
  },
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
  methods: {
    constructPermaLink (post) {
      return `posts/${post.link}`
    },
    isodate (d) {
      return d.toISOString().substring(0, 10)
    }
  }
}
</script>

<style lang="css">
.blog-post-birdsview time {
  display: block;
}
.blog-post-birdsview > h1 > a {
  text-decoration: none;
  color: white;
}
.blog-birdsview ul {
  margin-top: 3em;
}
.blog-post-birdsview > h1:hover {
  text-decoration: underline;
}
</style>
