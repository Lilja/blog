<template>
  <div>
    <h1>{{attributes.title}}</h1>
    <main v-html="content" />
    <section>
      Add Comment section here!
    </section>
  </div>
</template>
<script>
const fm = require('front-matter')
const md = require('markdown-it')({
  html: true,
  linkify: true,
  typographer: true
})
export default {
  async asyncData({ params }) {
    try {
      const post = await import(`~/contents/${params.slug}.md`);
      const res = fm(post.default);
      return {
        attributes: res.attributes,
        content: md.render(res.body)
      };
    } catch (err) {
      console.error('Erro rendering markdown', err);
      return false;
    }
  }
};
</script>
