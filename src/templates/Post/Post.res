open Nullable
open ReasonDateFns

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
        description
        createdAt
        updatedAt
        tags
      }
    }
  }
`)

type pageContext = {slug: string}

let query = BlogPostBySlug.query

let decodeString = str => {
  Js.Json.decodeString(str)->Js.Nullable.fromOption
}

@react.component
let make = (~data as rawData, ~pageContext: pageContext) => {
  let data = BlogPostBySlug.unsafe_fromJson(rawData)

  let markdown = data.markdownRemark->getExn
  let matter = markdown.frontmatter->getExn
  let siteMetadata = data.site->flatMap(site => site.siteMetadata)->getExn

  let author = siteMetadata.author->getExn
  let social = siteMetadata.social->getExn

  let title = matter.title->getExn
  let description = if Js.Nullable.toOption(matter.description) != None {
    matter.description->getExn
  } else {
    markdown.excerpt->getExn
  }

  let createdAt = matter.createdAt->flatMap(decodeString)->getExn
  let updatedAt = matter.updatedAt->flatMap(decodeString)->getExn
  let tags = matter.tags->getExn

  <>
    <SEO
      title={`${title} / seob.dev`}
      description={description}
      url={`https://seob.dev/posts/${pageContext.slug}/`}>
      <meta property="article:published_time" content={createdAt} />
      <meta property="article:modified_time" content={updatedAt} />
    </SEO>
    <NavigationBar />
    <article className="container mx-auto py-16 px-4">
      <PostHeading> {title} </PostHeading>
      <div className="flex flex-col md:flex-row max-w-2xl mx-auto pt-4">
        <PostStat
          title={`마지막 업데이트`}
          value={<time dateTime=updatedAt>
            {Js.Date.fromString(updatedAt)
            |> DateFns.formatWithOptions(
              DateFns.formatOptions(~locale=DateFns.Locales.ko, ()),
              `yyyy년 M월 d일`,
            )
            |> React.string}
          </time>}
        />
        <PostStat
          title={`태그`}
          value={tags->Belt.Array.map(tag => <PostTag> {tag->getExn} </PostTag>)->React.array}
        />
        <PostStat
          title={`글쓴이`}
          value={<ExternalLink href={`https://twitter.com/${social.twitter->getExn}`}>
            {`이현섭`->React.string}
          </ExternalLink>}
        />
      </div>
      <Divider className="mt-24 mb-16" />
      <PostContent html={markdown.html->getExn} />
      <Divider className="mt-16" />
      <section className="max-w-2xl mx-auto pt-12">
        <h4 className="text-gray-900 text-xl md:text-2xl font-bold mb-4">
          {`글쓴이`->React.string}
        </h4>
        <div className="flex items-center">
          <img
            src="https://ko.gravatar.com/userimage/99798884/1e93a7577245566cc5a088b05f461ca2.png"
            alt=""
            ariaHidden={true}
            className="rounded-full h-12 w-12"
          />
          <div className="pl-4">
            <div className="flex text-gray-900 text-md md:text-lg">
              <span className="font-bold"> {author.name->getExn->React.string} </span>
              <span className="inline-block mx-2 text-gray-200"> {`|`->React.string} </span>
              <span> {author.summary->getExn->React.string} </span>
            </div>
            <div className="flex text-gray-700 text-sm md:text-md">
              <ExternalLink href={`https://github.com/${social.github->getExn}`} className="mr-2">
                {`GitHub`->React.string}
              </ExternalLink>
              <ExternalLink href={`https://twitter.com/${social.twitter->getExn}`} className="mr-2">
                {`Twitter`->React.string}
              </ExternalLink>
              <ExternalLink href={`https://www.facebook.com/${social.facebook->getExn}`}>
                {`Facebook`->React.string}
              </ExternalLink>
            </div>
          </div>
        </div>
      </section>
    </article>
    <Footer />
  </>
}

let default = make
