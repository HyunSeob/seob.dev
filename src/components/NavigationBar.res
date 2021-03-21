module NavItem = {
  @react.component
  let make = (~children, ~_to) => {
    <li className="text-lg font-semibold pl-4">
      <Gatsby.link
        _to={_to}
        className="text-gray-700 hover:text-blue-600 transition-colors"
        activeClassName="text-blue-600">
        {children->React.string}
      </Gatsby.link>
    </li>
  }
}

module ExternalItem = {
  @react.component
  let make = (~children, ~_to) => {
    <li className="text-lg font-semibold pl-4">
      <a
        href={_to}
        target="_blank"
        rel="noopener"
        className="text-gray-700 hover:text-blue-600 transition-colors">
        {children->React.string}
      </a>
    </li>
  }
}

@react.component
let make = () => {
  <header>
    <div className="max-w-2xl mx-auto px-4 py-8 flex justify-between items-center">
      <Gatsby.link _to="/" className="block w-48 mr-12 focus:ring-2"> <Logo /> </Gatsby.link>
      <nav>
        <ul className="flex">
          <NavItem _to="/"> {`Posts`} </NavItem>
          <ExternalItem _to="https://github.com/HyunSeob/seob.dev"> {`GitHub`} </ExternalItem>
        </ul>
      </nav>
    </div>
  </header>
}

let default = make
