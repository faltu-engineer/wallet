const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  purge: [
    '../lib/**/*.ex',
    '../lib/**/*.leex',
    '../lib/**/*.heex',
    '../lib/**/*.eex',
    './js/**/*.js'
  ],
  darkMode: true, // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', defaultTheme.fontFamily.sans],
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require("postcss-import"),
    require("tailwindcss")("./tailwind.config.js"),
    require('autoprefixer'),
    require('@tailwindcss/forms'),
  ],
}
