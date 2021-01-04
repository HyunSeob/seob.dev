@react.component
let make = (~children) => {
  <h1
    className={Css.merge(list{
      Css.style(list{Css.wordBreak(Css.keepAll)}),
      Tailwind.text(`center`),
      Tailwind.font(`black`),
      Tailwind.text(`gray-900`),
      `tracking-tight`,
      `break-normal`,
      `px-4`,
      `md:px-16`,
      `text-6xl`,
      `md:text-8xl`,
    })}>
    {children->React.string}
  </h1>
}
