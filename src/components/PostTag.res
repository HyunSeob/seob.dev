@react.component
let make = (~children) => {
  <span
    className={Js.Array.joinWith(
      ` `,
      [
        `font-bold`,
        `text-sm`,
        `bg-yellow-400`,
        `rounded-lg`,
        `py-0.5`,
        `px-1.5`,
        %css(`
          & + & {
            margin-left: 8px;
          }
        `),
      ],
    )}>
    {children->React.string}
  </span>
}
