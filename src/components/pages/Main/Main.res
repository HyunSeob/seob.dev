open Belt.Option
open Js.Nullable

%graphql(`
  query PostList {
    allMarkdownRemark(sort: {order: [DESC], fields: [frontmatter___createdAt]}) {
      nodes {
        id
        excerpt(pruneLength: 240)
        fields {
          slug
        }
        frontmatter {
          title
          createdAt
          updatedAt
        }
      }
    }
  }
`)

@react.component
let make = () => {
  let data: PostList.Raw.t = Gatsby.useStaticQuery(PostList.query)

  <>
    <Head />
    <NavigationBar />
    <main className="py-4">
      <div className="mb-12 max-w-2xl mx-auto px-4">
        {Belt.Array.map(data.allMarkdownRemark.nodes, node => {
          let frontmatter = node.frontmatter->toOption->getExn
          let slug = node.fields->toOption->flatMap(field => toOption(field.slug))->getExn

          <article
            key={node.id} className="mt-12 text-gray-900 hover:text-blue-600 transition-colors">
            <Gatsby.link _to={`/posts/${slug}`}>
              <h3 className="text-current font-bold text-2xl mb-4">
                {React.string(frontmatter.title->toOption->getExn)}
              </h3>
              <p className="text-gray-700 text-base">
                {React.string(node.excerpt->toOption->getExn)}
                {` `->React.string}
                <span className="underline whitespace-nowrap"> {`더 읽기`->React.string} </span>
              </p>
            </Gatsby.link>
          </article>
        })->React.array}
      </div>
    </main>
    <Footer />
  </>
}

let default = make
