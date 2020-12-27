@react.component
let make = () => {
  let (count, setCount) = React.useState(() => 0)

  <div>
    <button
      onClick={_ =>
        setCount(prev => {
          prev + 1
        })}>
      {`+`->React.string}
    </button>
    <button
      onClick={_ =>
        setCount(prev => {
          prev - 1
        })}>
      {`-`->React.string}
    </button>
    {count->React.int}
  </div>
}
