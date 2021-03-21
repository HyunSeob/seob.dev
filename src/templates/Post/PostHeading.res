@react.component
let make = (~children) => {
  <h1
    className="text-center font-bold text-gray-900 tracking-tight px-4 md:px-16 text-4xl md:text-8xl">
    {children->React.string}
  </h1>
}
