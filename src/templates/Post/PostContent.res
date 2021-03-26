%%raw(`import './PostContent.css';`)

@react.component
let make = (~html) => {
  <div
    className={"post-content text-base font-medium text-gray-700"}
    dangerouslySetInnerHTML={"__html": html}
  />
}
