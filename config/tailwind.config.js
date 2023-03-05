const defaultTheme = require('tailwindcss/defaultTheme');
const plugin = require("tailwindcss/plugin");

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    screens: {
      "0": "40em",
      "1": "52em",
      "2": "64em",
      "3": "100em"
    },
    fontFamily: {
      body: "Telegraf, sans-serif",
      heading: "Telegraf, sans-serif",
      monospace: "Menlo, monospace"
    },
    fontSize: {
      "0": 16,
      "1": 20,
      "2": 24,
      "3": 32,
      "4": 48,
      "5": 64,
      "6": 72
    },
    fontWeight: {
      body: 400,
      heading: 400,
      bold: 500
    },
    lineHeight: {
      body: 1.5,
      heading: 1.125
    },
    letterSpacing: {
      body: "normal"
    },
    colors: {
      "text": "#F5F5F5",
      "background": "#343434",
      "primary": "#41EAD4",
      "secondary": "#FF206E",
      "accent": "#FBFF12",
      "muted": "#0C0F0A",
      "highlight": "#FBFF12",
      "white": "#F5F5F5",
      "bg": "#343434",
      "blue": "#41EAD4",
      "pink": "#FF206E",
      "yellow": "#FBFF12",
      "black": "#0C0F0A"
    },
    container: {
      center: true,
      padding: "2rem"
      // todo: width 820px
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    plugin(function({ addComponents, theme }) {
      const makeTransition = (...properties) => properties.map(p => `${p} 0.2s ease-in-out`).join(", ");
      const defaultTransition = makeTransition("box-shadow", "border-color", "background-color", "color", "outline");

      /** @type CSSStyleDeclaration */
      const buttonLgBase = {
        paddingTop: "1rem",
        paddingBottom: "1rem",
        paddingLeft: "1.375rem",
        paddingRight: "1.375rem",
        borderRadius: "100px", // arbitrarily large value
        fontWeight: theme("fontWeight.body"),
        fontSize: "2.625rem",
        letterSpacing: "-0.03em",
        lineHeight: "100%",
        fontFamily: theme("fontFamily.body")
      };

      const focusStyle = (color) => ({
        outline: "none",
        borderColor: color,
        boxShadow: "0 0 0 3px rgba(65, 234, 212, 0.5)" // thanks copilot
      })
      
      const buttonMdFactory = (text, bg) => {
        /** @type CSSStyleDeclaration */
        return {
          border: "1px solid",
          borderColor: theme("colors.black"),
          color: text,
          backgroundColor: bg,
          display: "flex",
          flexDirection: "row",
          justifyContent: "center",
          alignItems: "center",
          padding: "0.5rem 0.625rem",
          borderRadius: "100px",
          fontSize: "1.5rem",
          lineHeight: "100%",
          "&:focus": focusStyle(bg),
          transition: defaultTransition,
          fontFamily: theme("fontFamily.body")
        };
      };
      
      const badgeFactory = (text, bg) => {
        /** @type CSSStyleDeclaration */
        return {
          padding: "0.5rem 0.6875rem",
          borderRadius: "100px",
          // display: "flex",
          // flexDirection: "row",
          // alignItems: "flex-start",
          backgroundColor: bg,
          color: text,
          fontSize: "1.25rem",
          lineHeight: "100%",
          fontWeight: 500,
          fontFamily: "body",
          textTransform: "uppercase"
        };
      };

      /** @type CSSStyleDeclaration */
      const input = {
        backgroundColor: theme("colors.text"),
        color: theme("colors.black"),
        border: "1px solid",
        borderColor: "black",
        borderRadius: "0.5rem",
        padding: "0.625rem 1rem",
        display: "flex",
        alignItems: "flex-start",
        fontSize: "1rem",
        lineHeight: "100%",
        // placeholder color
        "&::placeholder": {
            color: "#686868"
        },
        transition: defaultTransition,
        "&:focus": focusStyle(theme("colors.blue")),
        fontFamily: theme("fontFamily.body")
      }

      /** @type CSSStyleDeclaration */
      const label = {
        color: theme("colors.text"),
        fontSize: "1rem",
        lineHeight: "100%",
        marginBottom: "0.25rem"
      };

      addComponents({
        ".btn-lg-primary": {
          ...buttonLgBase,
          color: theme("colors.black"),
          backgroundColor: theme("colors.white")
        },
        ".btn-md-white": buttonMdFactory(theme("colors.black"), theme("colors.white")),
        ".btn-md-blue": buttonMdFactory(theme("colors.black"), theme("colors.blue")),
        ".btn-md-pink": buttonMdFactory(theme("colors.white"), theme("colors.pink")),
        ".btn-md-yellow": buttonMdFactory(theme("colors.black"), theme("colors.yellow")),
        ".badge-white": badgeFactory(theme("colors.black"), theme("colors.white")),
        ".badge-blue": badgeFactory(theme("colors.black"), theme("colors.blue")),
        ".badge-pink": badgeFactory(theme("colors.white"), theme("colors.pink")),
        ".badge-yellow": badgeFactory(theme("colors.black"), theme("colors.yellow")),
        ".input": input,
        ".label": label
      })
    })
  ]
};