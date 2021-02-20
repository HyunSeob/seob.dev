@bs.module("gatsby") external useStaticQuery: string => 'a = "useStaticQuery"
@bs.module("gatsby") @react.component
external link: (
  ~_to: string,
  ~rel: option<string>=?,
  ~className: option<string>=?,
  ~style: option<ReactDOMRe.Style.t>=?,
  ~activeStyle: option<ReactDOMRe.Style.t>=?,
  ~activeClassName: option<string>=?,
  ~children: option<React.element>=?,
) => React.element = "Link"
