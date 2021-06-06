@react.component
let make = (~title, ~description, ~slug) => {
  let (fromColor, toColor) = Gradient.getColors(title)

  <article className="mt-12 text-gray-900 hover:text-transparent">
    <Gatsby.link _to={`/posts/${slug}`}>
      <h3 className="text-current font-bold text-3xl mb-4 transition-colors duration-300">
        <span
          className={[
            `inline-block`,
            `bg-clip-text`,
            `bg-gradient-to-r`,
            `from-${fromColor}-600`,
            `to-${toColor}-600`,
          ] |> Js.Array.joinWith(` `)}>
          {title->React.string}
        </span>
      </h3>
      <p className="text-gray-700 text-base">
        {description->React.string}
        <span className="font-bold block underline whitespace-nowrap mt-2">
          {`더 읽기`->React.string}
        </span>
      </p>
    </Gatsby.link>
  </article>
}
