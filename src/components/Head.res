open Nullable

%graphql(`
  query HeadMetadata {
    site {
      siteMetadata {
        title
        description
        siteUrl
      }
    }
  }
`)

@react.component
let make = () => {
  let data: HeadMetadata.Raw.t = Gatsby.useStaticQuery(HeadMetadata.query)
  let meta = data.site->flatMap(site => site.siteMetadata)->getExn
  let title = meta.title->getExn
  let description = meta.description->getExn
  let siteUrl = meta.siteUrl->getExn

  <SEO title={title} description={description} url={siteUrl} />
}

let default = make
