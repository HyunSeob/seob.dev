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
        createdAt
        updatedAt
      }
    }
  }
`)

let query = BlogPostBySlug.query

@react.component
let make = (~data as rawData, ~pageContext) => {
  let data = BlogPostBySlug.unsafe_fromJson(rawData)

  let matter = data.markdownRemark->toOption->flatMap(md => toOption(md.frontmatter))
  let title = matter->flatMap(front => toOption(front.title))->getExn
  let description = data.markdownRemark->toOption->flatMap(md => toOption(md.excerpt))->getExn

  let updatedAt =
    matter->flatMap(front => toOption(front.updatedAt))->flatMap(Js.Json.decodeString)->getExn

  <article className="container mx-auto py-16 px-4">
    <BsReactHelmet defaultTitle={title}>
      <meta name="description" content={description} />
      // <meta name="keywords" content="Year in review" />
      <meta property="og:type" content="article" />
      <meta property="og:title" content={title} />
      <meta
        property="og:url" content="https://hyunseob.github.io/2019/12/31/2019-year-in-review/ "
      />
      <meta property="og:site_name" content="seob.dev" />
      <meta property="og:description" content={description} />
      <meta property="og:locale" content="ko" />
      <meta
        property="og:image"
        content="https://hyunseob.github.io/images/nordwood-themes-C0sW3yscQXc-unsplash.jpg"
      />
      <meta property="og:updated_time" content={updatedAt} />
      <meta name="twitter:card" content="summary" />
      <meta name="twitter:title" content={title} />
      <meta name="twitter:description" content={description} />
      <meta
        name="twitter:image"
        content="https://hyunseob.github.io/images/nordwood-themes-C0sW3yscQXc-unsplash.jpg"
      />
      <meta name="twitter:creator" content="@HyunSeob_" />
    </BsReactHelmet>
    <PostHeading>
      {data.markdownRemark
      ->toOption
      ->flatMap(md => toOption(md.frontmatter))
      ->flatMap(front => toOption(front.title))
      ->getExn}
    </PostHeading>
    <span className="block text-sm text-right max-w-2xl mx-auto italic text-gray-500 mt-8">
      {Js.Date.fromString(updatedAt)
      |> DateFns.formatWithOptions(
        DateFns.formatOptions(~locale=DateFns.Locales.ko, ()),
        `yyyy년 M월 d일`,
      )
      |> React.string}
      <time dateTime=updatedAt>
        {`에 마지막으로 업데이트 되었습니다.`->React.string}
      </time>
    </span>
    <PostContent html={data.markdownRemark->toOption->flatMap(md => toOption(md.html))->getExn} />
  </article>
}

let default = make
