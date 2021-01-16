module.exports = {
  siteMetadata: {
    title: `seob.dev`,
    author: {
      name: `이현섭`,
      summary: `프론트엔드 개발자`,
    },
    description: `개발하면서 배운 것들을 주로 올립니다.`,
    siteUrl: `https://seob.dev/`,
    social: {
      twitter: `HyunSeob_`,
    },
  },
  plugins: [
    {
      resolve: "gatsby-source-filesystem",
      options: {
        name: "posts",
        path: `${__dirname}/content/posts/`,
      },
    },
    {
      resolve: "gatsby-transformer-remark",
      options: {
        plugins: [
          {
            resolve: "gatsby-remark-images",
            options: {
              maxWidth: 1500,
            },
          },
          {
            resolve: `gatsby-remark-responsive-iframe`,
            options: {
              wrapperStyle: `margin-bottom: 1.0725rem`,
            },
          },
          "gatsby-remark-prismjs",
          `gatsby-remark-copy-linked-files`,
          "gatsby-remark-autolink-headers",
        ],
      },
    },
    "gatsby-transformer-sharp",
    "gatsby-plugin-sharp",
    "gatsby-plugin-postcss",
    `gatsby-plugin-react-helmet`,
  ],
};
