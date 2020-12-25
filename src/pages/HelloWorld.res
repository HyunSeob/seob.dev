let component = ReasonReact.statelessComponent("Paragraph");

let make = children => {
    ...component,
    render: _self => <p> children </p>
};

let default = ReasonReact.wrapReasonForJs(~component, jsProps => make(jsProps##children));

