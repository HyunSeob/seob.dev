@react.component
let make = (~children) => {
  let (fromColor, toColor) = Gradient.getColors(children)

  <h1
    className={[
      `font-bold`,
      `md:font-black`,
      `text-transparent`,
      `tracking-tight`,
      `max-w-2xl`,
      `mx-auto`,
      `text-6xl`,
      `md:text-7xl`,
      `pr-6`,
      `md:pr-24`,
    ] |> Js.Array.joinWith(` `)}>
    <span
      className={[
        `inline-block`,
        `bg-clip-text`,
        `bg-gradient-to-r`,
        `from-${fromColor}-600`,
        `to-${toColor}-600`,
      ] |> Js.Array.joinWith(` `)}>
      {children->React.string}
    </span>
  </h1>
}
