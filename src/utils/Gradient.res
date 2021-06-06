let curatedGradient = list{
  list{`red`, `yellow`},
  list{`red`, `blue`},
  list{`red`, `indigo`},
  list{`red`, `purple`},
  list{`yellow`, `pink`},
  list{`green`, `blue`},
  list{`green`, `purple`},
  list{`blue`, `purple`},
  list{`blue`, `pink`},
  list{`indigo`, `pink`},
  list{`purple`, `pink`},
}

let getColors = text => {
  let charCodeSum =
    Belt.Array.map(Js.String2.split(text, ``), Js.String.charCodeAt(0))
    ->Belt.Array.map(Belt.Int.fromFloat)
    ->Belt.Array.reduce(0, (a, b) => a + b)

  let gradient =
    charCodeSum->mod(Belt.List.length(curatedGradient)) |> Belt.List.getExn(curatedGradient)
  let fromLeftToRight = Js.String2.length(text)->mod(1) === 0
  let fromColor = gradient->Belt.List.getExn(fromLeftToRight ? 0 : 1)
  let toColor = gradient->Belt.List.getExn(fromLeftToRight ? 1 : 0)

  (fromColor, toColor)
}
