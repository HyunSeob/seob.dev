open Belt.Option
open Js.Nullable

%graphql(`
  query SiteMetadata {
    site {
      siteMetadata {
        title
        description
      }
    }
  }
`)

@react.component
let make = () => {
  let data: SiteMetadata.Raw.t = Gatsby.useStaticQuery(SiteMetadata.query)
  let meta = data.site->toOption->flatMap(site => toOption(site.siteMetadata))->getExn

  <footer className="bg-gray-100">
    <div className="max-w-2xl mx-auto py-12 px-4 text-center">
      <img src="/logo.png" alt={meta.title->toOption->getExn} className="w-48 mb-6 m-auto" />
      <p className="text-md"> {meta.description->toOption->getExn->React.string} </p>
      <small> {`© 이현섭`->React.string} </small>
    </div>
  </footer>
}

let default = make
