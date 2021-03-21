@react.component
let make = (~children) => {
  <h1
    className="text-center font-black text-transparent tracking-tight px-4 md:px-16 text-6xl md:text-8xl bg-clip-text bg-gradient-to-r from-green-600 to-blue-600">
    {children->React.string}
  </h1>
}
