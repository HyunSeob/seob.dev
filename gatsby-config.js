module.exports = {
  siteMetadata: {
    title: `seob.dev`,
    author: {
      name: `이현섭`,
      summary: `Frontend Developer`,
    },
    description: `seob.dev는 프론트엔드 개발을 다루는 블로그입니다.`,
    siteUrl: `https://seob.dev/`,
    social: {
      github: "HyunSeob",
      facebook: "hyunseob.lee.7",
      twitter: `@HyunSeob_`,
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
          `gatsby-remark-external-links`,
        ],
      },
    },
    "gatsby-transformer-sharp",
    "gatsby-plugin-sharp",
    "gatsby-plugin-postcss",
    `gatsby-plugin-react-helmet`,
    {
      resolve: `gatsby-plugin-google-gtag`,
      options: {
        trackingIds: ["G-J5YSX4SY3K"],
      },
    },
  ],
};
