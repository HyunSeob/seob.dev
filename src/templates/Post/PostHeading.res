@react.component
let make = (~children) => {
  <h1
    className={Css.merge(list{
      Css.style(list{Css.wordBreak(Css.keepAll)}),
      Tailwind.text(`8xl`),
      Tailwind.text(`center`),
      Tailwind.font(`black`),
      Tailwind.text(`gray-900`),
      `tracking-tight`,
      `break-normal`,
      Tailwind.px(16),
    })}>
    {children->React.string}
  </h1>
}
