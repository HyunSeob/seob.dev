%raw
{| import './PostContent.css'; |};

[@react.component]
let make = (~html) => {
  <div
    className={Css.merge([
      "post-content",
      "text-base",
      "font-medium",
      "text-gray-700",
      "py-16",
      "md:py-32",
    ])}
    dangerouslySetInnerHTML={"__html": html}
  />;
};
 