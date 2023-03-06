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
      "sm": "40em",
      "md": "52em",
      "lg": "64em",
      "xl": "100em"
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
      "3": [32, "100%"],
      "4": [48, "100%"],
      "5": [64, "100%"],
      "6": [72, "100%"]
    },
    fontWeight: {
      body: 400,
      heading: 700,
      bold: 500
    },
    /*lineHeight: {
      body: 1.5,
      heading: 1
    },*/
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
      "black": "#0C0F0A",
      "green": "#56FF53"
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
      const focusStyle = (color) => ({
        outline: "none",
        borderColor: color,
        boxShadow: "0 0 0 3px rgba(65, 234, 212, 0.5)" // thanks copilot
      });

      /** @type {(...args: (CSSStyleDeclaration | (p: any) => CSSStyleDeclaration)[]) => (p: any) => CSSStyleDeclaration} */
      const extend = (...a) => p => a.reduce((acc, s) => ({ ...acc, ...(typeof s === "object" ? s : s(p)) }), {});


      const componentBase = ({ bg }) => {
        /** @type CSSStyleDeclaration */
        return {
          transition: defaultTransition,
          fontFamily: theme("fontFamily.body"),
          lineHeight: "100%",
          "&:focus": focusStyle(bg)
        };
      };

      const buttonBase = extend(componentBase, ({ bg, text }) => ({
        display: "flex",
        flexDirection: "row",
        justifyContent: "center",
        boxShadow: "0px 3.61px 3.61px rgba(0, 0, 0, 0.25)",
        borderRadius: "100px",
        backgroundColor: bg,
        color: text
      }));

      const buttons = {
        "md": extend(buttonBase, {
          padding: "0.625rem 0.90625rem",
          fontWeight: theme("fontWeight.body"),
          fontSize: "1.75rem"  
        }),
        "sm": extend(buttonBase, {
          padding: "0.5rem 0.75rem",
          fontWeight: "700",
          fontSize: "1.25rem"
        }),
        "lg": extend(buttonBase, {
          padding: "1rem 1.375rem",
          fontWeight: theme("fontWeight.body"),
          fontSize: "2.625rem"
        })
      };
      
      const chip = extend(componentBase, ({ text, bg }) => ({
        padding: "0.5rem 0.6875rem",
        borderRadius: "100px",
        backgroundColor: bg,
        color: text,
        fontSize: "1.25rem",
        lineHeight: "100%",
        fontWeight: 500,
        fontFamily: theme("fontFamily.body"),
        textTransform: "uppercase"
      }));

      const input = extend(componentBase({ bg: theme("colors.blue") }), {
        backgroundColor: theme("colors.text"),
        color: theme("colors.black"),
        border: "1px solid",
        borderColor: "black",
        borderRadius: "0.5rem",
        padding: "0.625rem 1rem",
        display: "flex",
        alignItems: "flex-start",
        fontSize: "1rem",
        // placeholder color
        "&::placeholder": {
            color: "#686868"
        }
      });

      /** @type CSSStyleDeclaration */
      const label = {
        color: theme("colors.text"),
        fontSize: "1rem",
        lineHeight: "100%",
        marginBottom: "0.25rem"
      };

      const colors = {
        "white": { bg: theme("colors.white"), text: theme("colors.black") },
        "blue": { bg: theme("colors.blue"), text: theme("colors.black") },
        "pink": { bg: theme("colors.pink"), text: theme("colors.white") },
        "yellow": { bg: theme("colors.yellow"), text: theme("colors.black") }
      };

      addComponents({
        ...Object.fromEntries(Object.entries(buttons).map(([size, s]) => Object.entries(colors).map(([color, c]) => [`.btn-${size}-${color}`, s(c)])).flat()),
        ...Object.fromEntries(Object.entries(colors).map(([color, c]) => [`.chip-${color}`, chip(c)])),
        ".input": input(),
        ".label": label
      });
    })
  ]
};