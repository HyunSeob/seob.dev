open Belt.Option
open ReasonDateFns
open Js.Nullable

%graphql(`
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
        date
      }
    }
  }
`)

let query = BlogPostBySlug.query

@react.component
let make = (~data as rawData, ~pageContext) => {
  let data = BlogPostBySlug.unsafe_fromJson(rawData)

  let dateString =
    data.markdownRemark
    ->toOption
    ->flatMap(md => toOption(md.frontmatter))
    ->flatMap(front => toOption(front.date))
    ->flatMap(Js.Json.decodeString)
    ->getExn

  <article className="container mx-auto py-16 px-4">
    <PostHeading>
      {data.markdownRemark
      ->toOption
      ->flatMap(md => toOption(md.frontmatter))
      ->flatMap(front => toOption(front.title))
      ->getExn}
    </PostHeading>
    <span className="block text-sm text-right max-w-2xl mx-auto italic text-gray-500 mt-8">
      {Js.Date.fromString(dateString)
      |> DateFns.formatWithOptions(
        DateFns.formatOptions(~locale=DateFns.Locales.ko, ()),
        `yyyy년 M월 d일`,
      )
      |> React.string}
      <time dateTime=dateString>
        {`에 마지막으로 업데이트 되었습니다.`->React.string}
      </time>
    </span>
    <PostContent html={data.markdownRemark->toOption->flatMap(md => toOption(md.html))->getExn} />
  </article>
}

let default = make
