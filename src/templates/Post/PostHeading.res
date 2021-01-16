@react.component
let make = (~children) => {
  <h1
    className="text-center font-black text-gray-900 tracking-tight break-normal px-4 md:px-16 text-6xl md:text-8xl">
    {children->React.string}
  </h1>
}
