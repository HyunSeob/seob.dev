open Js.Nullable

let getExn = arg => arg->toOption->Belt.Option.getExn

let flatMap = (arg, mapper) => {
  toOption(arg)
  ->Belt.Option.flatMap(opt => {
    mapper(opt)->toOption
  })
  ->fromOption
}
