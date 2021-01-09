%raw
{| import './PostContent.css'; |};

[@react.component]
let make = (~html) => {
  <div
    className={Css.merge([
      "post-content",
      Tailwind.text("base"),
      Tailwind.font("medium"),
      Tailwind.text("gray-700"),
      "py-16",
      "md:py-32",
    ])}
    dangerouslySetInnerHTML={"__html": html}
  />;
};
