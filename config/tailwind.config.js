const defaultTheme = require('tailwindcss/defaultTheme');

const themeUIGenerated = {
  "theme": {
    "screens": {
      "0": "40em",
      "1": "52em",
      "2": "64em",
      "3": "100em"
    },
    "fontFamily": {
      "body": "Telegraf, sans-serif",
      "heading": "Telegraf, sans-serif",
      "monospace": "Menlo, monospace"
    },
    "fontSize": {
      "0": 16,
      "1": 20,
      "2": 24,
      "3": 32,
      "4": 48,
      "5": 64,
      "6": 72
    },
    "fontWeight": {
      "body": 400,
      "heading": 400,
      "bold": 500
    },
    "lineHeight": {
      "body": 1.5,
      "heading": 1.125
    },
    "letterSpacing": {
      "body": "normal"
    },
    "colors": {
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
    "styles": {
      "root": {
        "fontFamily": "body",
        "lineHeight": "body",
        "fontWeight": "body",
        "backgroundColor": "background",
        "color": "text",
        "& body": {
          "minHeight": "100vh"
        }
      }
    },
    "sizes": {
      "container": 820
    },
    "layout": {},
    "buttons": {
      "primaryLg": {
        "paddingY": "1rem",
        "paddingX": "1.375rem",
        "borderRadius": "100px",
        "fontWeight": 400,
        "fontSize": "2.625rem",
        "letterSpacing": "-0.03em",
        "lineHeight": "100%",
        "fontFamily": "body",
        "color": "#0C0F0A",
        "backgroundColor": "#F5F5F5"
      },
      "whiteMd": {
        "border": "1px solid",
        "borderColor": "black",
        "color": "#0C0F0A",
        "backgroundColor": "#F5F5F5",
        "display": "flex",
        "flexDirection": "row",
        "justifyContent": "center",
        "alignItems": "center",
        "padding": "0.5rem 0.625rem",
        "borderRadius": "100px",
        "fontSize": "1.5rem",
        "lineHeight": "100%",
        "&:focus": {
          "outline": "none",
          "borderColor": "#F5F5F5",
          "boxShadow": "0 0 0 3px rgba(65, 234, 212, 0.5)"
        },
        "transition": "box-shadow 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out, color 0.2s ease-in-out, outline 0.2s ease-in-out",
        "fontFamily": "body"
      },
      "blueMd": {
        "border": "1px solid",
        "borderColor": "black",
        "color": "#0C0F0A",
        "backgroundColor": "#41EAD4",
        "display": "flex",
        "flexDirection": "row",
        "justifyContent": "center",
        "alignItems": "center",
        "padding": "0.5rem 0.625rem",
        "borderRadius": "100px",
        "fontSize": "1.5rem",
        "lineHeight": "100%",
        "&:focus": {
          "outline": "none",
          "borderColor": "#41EAD4",
          "boxShadow": "0 0 0 3px rgba(65, 234, 212, 0.5)"
        },
        "transition": "box-shadow 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out, color 0.2s ease-in-out, outline 0.2s ease-in-out",
        "fontFamily": "body"
      },
      "pinkMd": {
        "border": "1px solid",
        "borderColor": "black",
        "color": "#F5F5F5",
        "backgroundColor": "#FF206E",
        "display": "flex",
        "flexDirection": "row",
        "justifyContent": "center",
        "alignItems": "center",
        "padding": "0.5rem 0.625rem",
        "borderRadius": "100px",
        "fontSize": "1.5rem",
        "lineHeight": "100%",
        "&:focus": {
          "outline": "none",
          "borderColor": "#FF206E",
          "boxShadow": "0 0 0 3px rgba(65, 234, 212, 0.5)"
        },
        "transition": "box-shadow 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out, color 0.2s ease-in-out, outline 0.2s ease-in-out",
        "fontFamily": "body"
      },
      "yellowMd": {
        "border": "1px solid",
        "borderColor": "black",
        "color": "#0C0F0A",
        "backgroundColor": "#FBFF12",
        "display": "flex",
        "flexDirection": "row",
        "justifyContent": "center",
        "alignItems": "center",
        "padding": "0.5rem 0.625rem",
        "borderRadius": "100px",
        "fontSize": "1.5rem",
        "lineHeight": "100%",
        "&:focus": {
          "outline": "none",
          "borderColor": "#FBFF12",
          "boxShadow": "0 0 0 3px rgba(65, 234, 212, 0.5)"
        },
        "transition": "box-shadow 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out, color 0.2s ease-in-out, outline 0.2s ease-in-out",
        "fontFamily": "body"
      }
    },
    "forms": {
      "input": {
        "backgroundColor": "text",
        "color": "black",
        "border": "1px solid",
        "borderColor": "black",
        "borderRadius": "0.5rem",
        "padding": "0.625rem 1rem",
        "display": "flex",
        "alignItems": "flex-start",
        "fontSize": "1rem",
        "lineHeight": "100%",
        "&::placeholder": {
          "color": "#686868"
        },
        "transition": "box-shadow 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out, color 0.2s ease-in-out, outline 0.2s ease-in-out",
        "&:focus": {
          "outline": "none",
          "borderColor": "#41EAD4",
          "boxShadow": "0 0 0 3px rgba(65, 234, 212, 0.5)"
        },
        "fontFamily": "body"
      },
      "label": {
        "color": "text",
        "fontSize": "1rem",
        "lineHeight": "100%",
        "marginBottom": "0.25rem"
      }
    },
    "badges": {
      "white": {
        "padding": "0.5rem 0.6875rem",
        "borderRadius": "100px",
        "backgroundColor": "#F5F5F5",
        "color": "#0C0F0A",
        "fontSize": "1.25rem",
        "lineHeight": "100%",
        "fontWeight": 500,
        "fontFamily": "body",
        "textTransform": "uppercase"
      },
      "blue": {
        "padding": "0.5rem 0.6875rem",
        "borderRadius": "100px",
        "backgroundColor": "#41EAD4",
        "color": "#0C0F0A",
        "fontSize": "1.25rem",
        "lineHeight": "100%",
        "fontWeight": 500,
        "fontFamily": "body",
        "textTransform": "uppercase"
      },
      "pink": {
        "padding": "0.5rem 0.6875rem",
        "borderRadius": "100px",
        "backgroundColor": "#FF206E",
        "color": "#F5F5F5",
        "fontSize": "1.25rem",
        "lineHeight": "100%",
        "fontWeight": 500,
        "fontFamily": "body",
        "textTransform": "uppercase"
      },
      "yellow": {
        "padding": "0.5rem 0.6875rem",
        "borderRadius": "100px",
        "backgroundColor": "#FBFF12",
        "color": "#0C0F0A",
        "fontSize": "1.25rem",
        "lineHeight": "100%",
        "fontWeight": 500,
        "fontFamily": "body",
        "textTransform": "uppercase"
      }
    },
    "text": {
      "sectionHeading": {
        "fontWeight": 700,
        "fontSize": [
          "3rem",
          null,
          "4rem"
        ],
        "lineHeight": "100%"
      }
    }
  }
};

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    /*extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },*/
    ...themeUIGenerated.theme,
    // provide font-sans for the preflight styles
    /*fontFamily: {
      ...themeUIGenerated.theme.fontFamily,
      sans: themeUIGenerated.theme.fontFamily.body
    }*/
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
};