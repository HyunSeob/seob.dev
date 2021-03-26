@react.component
let make = (~className: option<string>=?, ~children, ~href) => {
  <a
    href
    className={Js.Array.joinWith(
      ` `,
      [
        `text-blue-600`,
        `hover:shadow-link`,
        `transition-shadow`,
        `font-bold`,
        Belt.Option.getWithDefault(className, ``),
      ],
    )}
    target="_blank"
    rel="noopener noreferrer">
    {children}
  </a>
}
