[%graphql
  {|
  query ($slug: String!) {
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
        date
      }
    }
  }
|};
  {inline: true}
];

open Belt.Option;
open ReasonDateFns;

[@react.component]
let make = (~data, ~pageContext) => {
  let dateString =
    data.markdownRemark
    ->flatMap(md => md.frontmatter)
    ->flatMap(front => front.date)
    ->flatMap(Js.Json.decodeString)
    ->getExn;

  <article className="container mx-auto py-16 px-4">
    <PostHeading>
      {data.markdownRemark
       ->flatMap(md => md.frontmatter)
       ->flatMap(front => front.title)
       ->getExn}
    </PostHeading>
    <time
      className="block text-right max-w-2xl mx-auto italic"
      dateTime=dateString>
      {Js.Date.fromString(dateString)
       |> DateFns.lightFormat("마지막 업데이트: yyyy-MM-dd")
       |> React.string}
    </time>
    <PostContent html={data.markdownRemark->flatMap(md => md.html)->getExn} />
  </article>;
};

let default = make;
