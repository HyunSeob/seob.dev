@react.component
let make = (~children) => {
  <h1
    className="font-bold md:font-black text-transparent tracking-tight max-w-2xl mx-auto text-6xl md:text-7xl bg-clip-text bg-gradient-to-r from-green-600 to-blue-600">
    {children->React.string}
  </h1>
}
