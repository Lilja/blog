<template>
  <div role="main">
    <navbar />
    <div class="container blog-post">
      <div class="columns">
        <div class="column is-8 is-offset-2 main">
          <header>
            <h1 class="title">
              {{attributes.title}}
            </h1>
          </header>
          <section class="columns meta">
            <div class="column is-half">
              <img class="author-image" src="https://github.com/Lilja.png"/>
              <div class="meta-info">
                <address class="author">Erik Lilja</address>
                Published
                <time :datetime="attributes.date">
                  {{isodate(attributes.date)}}
                </time>
                <meta itemprop="datePublished" :content="attributes.date.toISOString()" />
                <div v-if="attributes.updated">
                  Updated
                  <time :datetime="attributes.date">
                    {{isodate(attributes.updated)}}
                  </time>
                </div>
              </div>
            </div>
            <div class="column has-text-centered is-half tags">
              <span v-for="tag in attributes.tags" :key="tag" class="tag is-light level-item">
                {{tag}}
              </span>
            </div>
          </section>
          <hr />
          <section class="content" v-html="content" />
          <section>
            Commento should be below.
            <client-only placeholder="Loading comments">
              <div id="commento"></div>
              <script
                src="https://commento.dersand.net/js/commento.js"
                defer="true"
              ></script>
            </client-only>
          </section>
          <footer class="footer">
            <div class="columns is-centered has-text-centered">
              <a href="https://github.com/Lilja" class="column" title="GitHub profile">
                <i class="fab fa-github fa-3x"></i>
              </a>
              <a href="https://dersand.net" class="column" title="Personal website">
                <i class="fas fa-link fa-3x"></i>
              </a>
              <a href="https://github.com/Lilja/blog" class="column" title="GitHub Repository">
                <i class="fas fa-code-branch fa-3x"></i>
              </a>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import hljs from 'highlight.js'
import 'highlight.js/styles/github.css'
import python from 'highlight.js/lib/languages/python'
import json from 'highlight.js/lib/languages/json'
hljs.registerLanguage('json', json)
hljs.registerLanguage('python', python)
import navbar from '~/pages/navbar'

const fm = require('front-matter')
const markdownOptions = {
  html: true,
  linkify: true,
  typographer: true
}
const highlightJsPlugin = require('markdown-it-highlightjs')
const md = require('markdown-it')(markdownOptions).use(highlightJsPlugin, {})

export default {
  components: {
    navbar
  },
  methods: {
    isodate(d) {
      return d.toISOString().substring(0,10)
    }
  },
  async asyncData({ params, error }) {
    try {
      const post = await import(`~/contents/${params.slug}.md`);
      const res = fm(post.default);
      console.log('Spook', res.attributes)
      return {
        attributes: res.attributes,
        content: md.render(res.body)
      };
    } catch (err) {
      console.error('Error rendering markdown', err);
      error({ statusCode: 404, message: 'Post not found' })
      return false;
    }
  }
};
</script>

<style lang="css">
.blog-post {
  margin-top: 3em;
}
.meta-info {
  margin-left: 1em;
}
.footer {
  background-color: #222831;
}

</style>
