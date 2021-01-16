open Belt.Option
open ReasonDateFns
open Js.Nullable

%graphql(`
  query BlogPostBySlug($slug: String!) {
    site {
      siteMetadata {
        title
        author {
          name
          summary
        }
        description
        siteUrl
        social {
          github
          facebook
          twitter
        }
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

type pageContext = {slug: string}

let query = BlogPostBySlug.query

@react.component
let make = (~data as rawData, ~pageContext: pageContext) => {
  let data = BlogPostBySlug.unsafe_fromJson(rawData)

  let matter = data.markdownRemark->toOption->flatMap(md => toOption(md.frontmatter))
  let siteMetadata = data.site->toOption->flatMap(site => toOption(site.siteMetadata))->getExn

  let author = siteMetadata.author->toOption->getExn
  let social = siteMetadata.social->toOption->getExn

  let title = matter->flatMap(front => toOption(front.title))->getExn
  let description = data.markdownRemark->toOption->flatMap(md => toOption(md.excerpt))->getExn

  let createdAt =
    matter->flatMap(front => toOption(front.createdAt))->flatMap(Js.Json.decodeString)->getExn
  let updatedAt =
    matter->flatMap(front => toOption(front.updatedAt))->flatMap(Js.Json.decodeString)->getExn

  <>
    <article className="container mx-auto py-16 px-4">
      <BsReactHelmet defaultTitle={title}>
        <meta name="description" content={description} />
        // <meta name="keywords" content="Year in review" />
        <meta property="og:type" content="article" />
        <meta property="og:title" content={title} />
        <meta property="og:url" content={`https://seob.dev/posts/${pageContext.slug}/`} />
        <meta property="og:site_name" content={siteMetadata.title->toOption->getExn} />
        <meta property="og:description" content={description} />
        <meta property="og:locale" content="ko_KR" />
        <meta property="og:image" content="https://seob.dev/og-image.png" />
        <meta property="article:published_time" content={createdAt} />
        <meta property="article:modified_time" content={updatedAt} />
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:title" content={title} />
        <meta name="twitter:description" content={description} />
        <meta name="twitter:image" content="https://seob.dev/og-image.png" />
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
      <hr className="max-w-2xl mx-auto" />
      <section className="max-w-2xl mx-auto pt-12">
        <h4 className="text-gray-900 text-xl md:text-2xl font-bold mb-4">
          {`글쓴이`->React.string}
        </h4>
        <div className="flex items-center">
          <img
            src="https://ko.gravatar.com/userimage/99798884/1e93a7577245566cc5a088b05f461ca2.png"
            alt=""
            ariaHidden={true}
            className="rounded-full h-12 w-12 md:h-20 md:w-20"
          />
          <div className="pl-4">
            <div className="flex text-gray-900 text-md md:text-lg">
              <span className="font-bold"> {author.name->toOption->getExn->React.string} </span>
              <span className="inline-block mx-2 text-gray-200"> {`|`->React.string} </span>
              <span> {author.summary->toOption->getExn->React.string} </span>
            </div>
            <div className="flex text-gray-700 text-sm md:text-md">
              <a
                href={`https://github.com/${social.github->toOption->getExn}`}
                target="_blank"
                rel="noopener noreferrer"
                className="mr-2">
                {`GitHub`->React.string}
              </a>
              <a
                href={`https://twitter.com/${social.twitter->toOption->getExn}`}
                target="_blank"
                rel="noopener noreferrer"
                className="mr-2">
                {`Twitter`->React.string}
              </a>
              <a
                href={`https://www.facebook.com/${social.facebook->toOption->getExn}`}
                target="_blank"
                rel="noopener noreferrer">
                {`Facebook`->React.string}
              </a>
            </div>
          </div>
        </div>
      </section>
    </article>
    <footer className="bg-gray-100">
      <div className="max-w-2xl mx-auto py-12 px-4 text-center">
        <img
          src="/logo.png" alt={siteMetadata.title->toOption->getExn} className="w-48 mb-6 m-auto"
        />
        <p className="text-md"> {siteMetadata.description->toOption->getExn->React.string} </p>
        <small> {`© 이현섭`->React.string} </small>
      </div>
    </footer>
  </>
}

let default = make
