@react.component
let make = () => {
  <div
    className={Css.merge(list{
      Tailwind.text(`base`),
      Tailwind.font(`medium`),
      Tailwind.text(`gray-700`),
      Tailwind.py(32),
    })}
  />
}
