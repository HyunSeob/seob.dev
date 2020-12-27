[%graphql {|
  query BlogPostBySlug($slug: String!) {
    site {
      siteMetadata {
        title
      }
    }
    markdownRemark(fields: { slug: { eq: $slug } }) {
      id
      excerpt(pruneLength: 160)
      html
      frontmatter {
        title
        date(formatString: "MMMM DD, YYYY")
      }
    }
  }
|};
  {inline: true}
];

[@react.component]
let make = (~data, ~pageContext) => {
  Js.log(pageContext);
  
  <article className="container mx-auto p-16">
    <PostHeading>
      {"Gatsby & Rescript & TailwindCSS를 사용해 블로그 만들기"}
    </PostHeading>
    <PostContent />
  </article>
}

let default = make
