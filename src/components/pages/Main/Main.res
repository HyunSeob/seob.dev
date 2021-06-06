open Nullable

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
          description
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
          let frontmatter = node.frontmatter->getExn
          let slug = node.fields->flatMap(field => field.slug)->getExn
          let description = if Js.Nullable.toOption(frontmatter.description) != None {
            frontmatter.description->getExn
          } else {
            node.excerpt->getExn
          }

          <PostItem
            key={node.id} title={frontmatter.title->getExn} description={description} slug={slug}
          />
        })->React.array}
      </div>
    </main>
    <Footer />
  </>
}

let default = make
