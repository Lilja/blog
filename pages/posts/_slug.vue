<template>
  <div role="section main">
    <div class="container">
      <div class="columns">
        <div class="column is-8 is-offset-2">
          <header>
            <h1 class="title">
              {{attributes.title}}
            </h1>
            <h2 class="subtitle">
              {{attributes.subtitle}}
            </h2>
          </header>
          <section class="columns meta">
            <div class="column is-one-third">
              <address class="author">Erik Lilja</address>
              <time :datetime="attributes.date">
                {{isodate(attributes.date)}}
              </time>
              <meta itemprop="datePublished" :content="attributes.date.toISOString()" />
              <div v-if="attributes.updated">
                <strong>Updated</strong>
                <time :datetime="attributes.date">
                  {{isodate(attributes.updated)}}
                </time>
              </div>
            </div>
            <div class="column is-offset-5 tags">
              <span v-for="tag in attributes.tags" :key="tag" class="tag is-light level-item">
                {{tag}}
              </span>
            </div>
          </section>
          <hr />
          <section class="content" v-html="content" />
          <section class="">
            Add Comment section here!
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

const fm = require('front-matter')
const markdownOptions = {
  html: true,
  linkify: true,
  typographer: true
}
const highlightJsPlugin = require('markdown-it-highlightjs')
const md = require('markdown-it')(markdownOptions).use(highlightJsPlugin, {})

export default {
  methods: {
    isodate(d) {
      return d.toISOString().substring(0,10)
    },
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
