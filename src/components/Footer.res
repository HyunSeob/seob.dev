open Belt.Option
open Js.Nullable

module ExternalLink = {
  @react.component
  let make = (~children, ~href) => {
    <a href={href} target="_blank" rel="noopener noreferrer"> {children->React.string} </a>
  }
}

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
        <ExternalLink href="https://www.gatsbyjs.com/"> {`Gatsby`} </ExternalLink>
        {`,  `->React.string}
        {`Hosted by `->React.string}
        <ExternalLink href="https://vercel.com/"> {`Vercel`} </ExternalLink>
        {`.`->React.string}
      </small>
      <small className="block">
        <ExternalLink href="https://github.com/HyunSeob"> {`© 이현섭`} </ExternalLink>
        {`, `->React.string}
        <ExternalLink href="https://creativecommons.org/licenses/by-sa/4.0/deed.ko">
          {`All rights reserved.`}
        </ExternalLink>
      </small>
    </div>
  </footer>
}

let default = make
