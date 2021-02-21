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

@react.component
let make = () => {
  <header>
    <div className="max-w-2xl mx-auto px-4 py-8 flex justify-between items-center">
      <Gatsby.link _to="/" className="block w-48 mr-12">
        <img src="/logo.png" alt="seob.dev" />
      </Gatsby.link>
      <nav>
        <ul className="flex">
          <NavItem _to="/"> {`Posts`} </NavItem> <NavItem _to="/about"> {`About`} </NavItem>
        </ul>
      </nav>
    </div>
  </header>
}

let default = make
