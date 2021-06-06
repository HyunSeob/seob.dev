const colors = require("tailwindcss/colors");

module.exports = {
  purge: {
    content: ["./src/**/*.{js,jsx,ts,tsx}"],
    options: {
      safelist: [/from-.+-600/, /to-.+-600/],
    },
  },
  darkMode: "media",
  theme: {
    boxShadow: {
      link: `0 2px 0 ${colors.blue[600]}`,
    },
  },
  variants: {
    extend: {},
  },
  plugins: ["gatsby-plugin-postcss"],
};
