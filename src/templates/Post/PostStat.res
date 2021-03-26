@react.component
let make = (~title, ~value) => {
  <div
    className={[
      `flex`,
      `flex-col`,
      `tracking-tight`,
      `mr-8`,
      `mt-4`,
      `last:m-0`,
    ] |> Js.Array.joinWith(` `)}>
    <span> {title->React.string} </span> <span className="font-bold"> {value} </span>
  </div>
}
