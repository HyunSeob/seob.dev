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
      <Logo className="w-48 mb-6 m-auto" />
      <p className="text-md mb-6"> {meta.description->toOption->getExn->React.string} </p>
      <small className="block mb-2">
        {`Powered by `->React.string}
        <ExternalLink href="https://www.gatsbyjs.com/"> {`Gatsby`->React.string} </ExternalLink>
        {`,  `->React.string}
        {`Hosted by `->React.string}
        <ExternalLink href="https://vercel.com/"> {`Vercel`->React.string} </ExternalLink>
        {`.`->React.string}
      </small>
      <small className="block">
        <ExternalLink href="https://github.com/HyunSeob">
          {`© 이현섭`->React.string}
        </ExternalLink>
        {`, `->React.string}
        <ExternalLink href="https://creativecommons.org/licenses/by-sa/4.0/deed.ko">
          {`All rights reserved.`->React.string}
        </ExternalLink>
      </small>
    </div>
  </footer>
}

let default = make
