@react.component
let make = (~className: option<string>=?) => {
  <hr
    className={Js.Array.joinWith(
      ` `,
      [
        `block`,
        `w-24`,
        `h-0.5`,
        `bg-gray-200`,
        `mx-auto`,
        Belt.Option.getWithDefault(className, ``),
      ],
    )}
  />
}
