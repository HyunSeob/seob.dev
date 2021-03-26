@react.component
let make = (~children) => {
  <span
    className={Js.Array.joinWith(
      ` `,
      [
        `inline-block`,
        `font-bold`,
        `text-sm`,
        `bg-yellow-400`,
        `rounded-lg`,
        `py-1`,
        `px-2`,
        `mr-2`,
        `last:m-0`,
      ],
    )}>
    {children->React.string}
  </span>
}
