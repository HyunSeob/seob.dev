let text = size => {
  `text-${size}`
}

let font = weight => {
  `font-${weight}`
}

let px = (width: int) => {
  `px-${Belt.Int.toString(width)}`
}

let py = width => {
  `py-${Belt.Int.toString(width)}`
}

let add = (a, b) => {
  a + b
}
