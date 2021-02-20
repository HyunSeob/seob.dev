@react.component
let make = (~title, ~description, ~url, ~children) => {
  <BsReactHelmet defaultTitle={title}>
    <meta name="description" content={description} />
    <meta property="og:type" content="website" />
    <meta property="og:title" content={title} />
    <meta property="og:url" content={url} />
    <meta property="og:site_name" content="seob.dev" />
    <meta property="og:description" content={description} />
    <meta property="og:locale" content="ko_KR" />
    <meta property="og:image" content="https://seob.dev/og-image.png" />
    <meta name="twitter:card" content="summary" />
    <meta name="twitter:title" content={title} />
    <meta name="twitter:description" content={description} />
    <meta name="twitter:image" content="https://seob.dev/og-image.png" />
    <meta name="twitter:creator" content="@HyunSeob_" />
    <link rel="canonical" href={url} />
    {children}
  </BsReactHelmet>
}

let default = make
