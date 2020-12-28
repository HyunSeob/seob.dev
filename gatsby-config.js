module.exports = {
  siteMetadata: {
    title: `seob.dev`,
    author: {
      name: `HyunSeob`,
      summary: `프론트엔드 개발자`,
    },
    description: `개발하면서 배운 것들을 주로 올립니다.`,
    siteUrl: `https://seob.dev/`,
    social: {
      twitter: `HyunSeob_`,
    },
  },
  plugins: [
    "gatsby-plugin-postcss",
    {
      resolve: "gatsby-source-filesystem",
      options: {
        name: "posts",
        path: `${__dirname}/posts/`,
      },
    },
    {
      resolve: "gatsby-transformer-remark",
      options: {
        plugins: [
          {
            resolve: "gatsby-remark-images",
            options: {
              maxWidth: 690,
            },
          },
          {
            resolve: "gatsby-remark-responsive-iframe",
          },
          "gatsby-remark-prismjs",
          "gatsby-remark-autolink-headers",
        ],
      },
    },
    "gatsby-plugin-sharp",
    "gatsby-transformer-sharp",
  ],
};
