[%graphql
  {|
  query BlogPostBySlug($slug: String!) {
    site {
      siteMetadata {
        title
      }
    }
    markdownRemark(fields: { slug: { eq: $slug } }) @bsRecord {
      id
      excerpt(pruneLength: 160)
      html
      frontmatter @bsRecord {
        title @bsRecord
        date(formatString: "MMMM DD, YYYY")
      }
    }
  }
|};
  {inline: true}
];

[@react.component]
let make = (~data, ~pageContext) => {
  Belt.Option.(
    <article className="container mx-auto p-16">
      <PostHeading>
        {data.markdownRemark
         ->flatMap(md => md.frontmatter)
         ->flatMap(front => front.title)
         ->getExn}
      </PostHeading>
      <PostContent
        html={data.markdownRemark->flatMap(md => md.html)->getExn}
      />
    </article>
  );
};

let default = make;
